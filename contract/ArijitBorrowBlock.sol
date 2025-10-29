// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title BorrowBlock — a tiny transparent ledger of credit agreements (learning/demo)
/// @author ChatGPT (GPT-5 Thinking mini)
/// @notice Simple on-chain record of loan agreements. Use for learning only.
contract BorrowBlock {
    address public admin;
    uint256 public nextId;

    enum State { Active, Repaid, Defaulted }

    struct Agreement {
        uint256 id;
        address lender;
        address borrower;
        uint256 principal;         // principal in wei
        uint256 interestBps;      // annual interest rate in basis points (1% = 100 bps)
        uint256 durationSeconds;  // duration of agreement (seconds)
        uint256 startTimestamp;   // 0 until funded / started
        uint256 repaidAmount;     // amount (wei) repaid so far
        uint256 withdrawnAmount;  // amount lender has withdrawn from repaidAmount
        State state;
        string memo;             // optional human-readable note
    }

    // id => Agreement
    mapping(uint256 => Agreement) public agreements;
    // simple list of ids for enumeration
    uint256[] public agreementIds;

    // Events
    event AgreementCreated(uint256 indexed id, address indexed lender, address indexed borrower, uint256 principal);
    event AgreementFunded(uint256 indexed id, uint256 startTimestamp);
    event Repaid(uint256 indexed id, address indexed payer, uint256 amount);
    event Withdrawn(uint256 indexed id, address indexed lender, uint256 amount);
    event Defaulted(uint256 indexed id);

    modifier onlyAdmin() {
        require(msg.sender == admin, "only admin");
        _;
    }

    modifier onlyLender(uint256 id) {
        require(msg.sender == agreements[id].lender, "only lender");
        _;
    }

    modifier onlyBorrower(uint256 id) {
        require(msg.sender == agreements[id].borrower, "only borrower");
        _;
    }

    constructor() {
        admin = msg.sender;
        nextId = 1;
    }

    /// @notice Create a new agreement record. Does NOT transfer funds — this just creates the on-chain ledger entry.
    /// @param _borrower borrower address
    /// @param _principal principal in wei
    /// @param _interestBps annual interest rate in basis points (100 = 1%)
    /// @param _durationSeconds loan duration in seconds
    /// @param _memo optional note
    function createAgreement(
        address _borrower,
        uint256 _principal,
        uint256 _interestBps,
        uint256 _durationSeconds,
        string calldata _memo
    ) external returns (uint256) {
        require(_borrower != address(0), "invalid borrower");
        require(_principal > 0, "principal > 0");
        require(_durationSeconds > 0, "duration > 0");

        uint256 id = nextId++;
        agreements[id] = Agreement({
            id: id,
            lender: msg.sender,
            borrower: _borrower,
            principal: _principal,
            interestBps: _interestBps,
            durationSeconds: _durationSeconds,
            startTimestamp: 0,
            repaidAmount: 0,
            withdrawnAmount: 0,
            state: State.Active,
            memo: _memo
        });

        agreementIds.push(id);

        emit AgreementCreated(id, msg.sender, _borrower, _principal);
        return id;
    }

    /// @notice Lender funds the loan by sending principal to the borrower through the contract.
    /// The contract forwards the principal to the borrower and marks the start timestamp.
    /// @dev lender must send exactly `principal` wei along with this call.
    function fundAgreement(uint256 id) external payable onlyLender(id) {
        Agreement storage a = agreements[id];
        require(a.startTimestamp == 0, "already funded");
        require(a.state == State.Active, "not active");
        require(msg.value == a.principal, "must send principal");

        // mark start
        a.startTimestamp = block.timestamp;

        // forward principal to borrower
        (bool ok, ) = a.borrower.call{value: msg.value}("");
        require(ok, "transfer to borrower failed");

        emit AgreementFunded(id, a.startTimestamp);
    }

    /// @notice Borrower (or anyone) can repay by sending ETH to contract against an agreement id.
    /// The contract records repaid amount. Lender withdraws later.
    function repay(uint256 id) external payable {
        Agreement storage a = agreements[id];
        require(a.startTimestamp != 0, "not funded");
        require(a.state == State.Active, "not active");

        require(msg.value > 0, "send > 0");
        a.repaidAmount += msg.value;

        // if fully repaid (or overpaid) and due amount reached, mark Repaid
        uint256 due = totalDue(id);
        if (a.repaidAmount >= due) {
            a.state = State.Repaid;
        }

        emit Repaid(id, msg.sender, msg.value);
    }

    /// @notice Lender withdraws the repaid funds (or portion) for their agreement.
    /// Withdraws only the available (repaidAmount - withdrawnAmount)
    function withdraw(uint256 id) external onlyLender(id) {
        Agreement storage a = agreements[id];
        uint256 available = a.repaidAmount - a.withdrawnAmount;
        require(available > 0, "nothing to withdraw");

        a.withdrawnAmount += available;
        (bool ok, ) = a.lender.call{value: available}("");
        require(ok, "withdraw failed");

        emit Withdrawn(id, a.lender, available);
    }

    /// @notice Lender may mark an agreement as defaulted after the duration has passed and not fully repaid.
    /// This only records the state; any dispute resolution must be off-chain or implemented separately.
    function markDefaulted(uint256 id) external onlyLender(id) {
        Agreement storage a = agreements[id];
        require(a.startTimestamp != 0, "not funded");
        require(a.state == State.Active, "not active");
        require(block.timestamp >= a.startTimestamp + a.durationSeconds, "duration not passed");

        uint256 due = totalDue(id);
        require(a.repaidAmount < due, "already repaid");

        a.state = State.Defaulted;
        emit Defaulted(id);
    }

    /// @notice Calculate total due (principal + simple interest accrued for the full duration)
    /// @dev interestBps is annual rate in basis points; uses simple interest for the full duration
    function totalDue(uint256 id) public view returns (uint256) {
        Agreement storage a = agreements[id];
        // interest = principal * interestBps/10000 * (durationSeconds / 365 days)
        // compute safely using integer math:
        uint256 numerator = a.principal * a.interestBps * a.durationSeconds;
        uint256 denominator = 10000 * 365 days;
        uint256 interest = 0;
        if (denominator > 0) {
            interest = numerator / denominator;
        }
        return a.principal + interest;
    }

    /// @notice Fetch a list of agreement ids (simple enumeration helper)
    function allAgreementIds() external view returns (uint256[] memory) {
        return agreementIds;
    }

    /// @notice Admin can change admin address
    function setAdmin(address newAdmin) external onlyAdmin {
        require(newAdmin != address(0), "invalid");
        admin = newAdmin;
    }

    // Fallback to reject unexpected ETH sends
    receive() external payable {
        revert("send with repay(id) or use repay()");
    }

    fallback() external payable {
        revert("invalid call");
    }
}

