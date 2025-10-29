# 💠 BorrowBlock  
*A Transparent Blockchain Ledger for Credit Agreements on Celo Sepolia*

![Solidity](https://img.shields.io/badge/Solidity-0.8.x-blue?logo=ethereum)
![License](https://img.shields.io/badge/License-MIT-green)
![Status](https://img.shields.io/badge/Stage-Deployed-success)

<img width="1920" height="1080" alt="Screenshot (42)" src="https://github.com/user-attachments/assets/df65b05b-fd8a-426e-bbab-1dac9bb31eb7" />


## 🧩 Overview

**BorrowBlock** is a beginner-friendly **Solidity smart contract** that creates a **transparent, immutable ledger** for credit (loan) agreements between lenders and borrowers.  

It allows anyone to:
- Record a new credit agreement (loan terms)
- Fund the loan directly to a borrower
- Repay in ETH (tracked on-chain)
- Withdraw repayments
- Mark loans as **repaid** or **defaulted**

Everything is **public and verifiable** on the blockchain — promoting trust and transparency in peer-to-peer credit.

---

## 📜 Deployed Contract

**Network:** Celo Sepolia  
**Contract Name:** `BorrowBlock`  
**Address:** [0xD04BA6AbB414f32Ba22F05816d671c35E1ee65e1](https://celo-sepolia.blockscout.com/address/0xD04BA6AbB414f32Ba22F05816d671c35E1ee65e1)

> 🔎 You can view transactions, logs, and contract events on [Blockscout for Celo Sepolia](https://celo-sepolia.blockscout.com/address/0xD04BA6AbB414f32Ba22F05816d671c35E1ee65e1).

---

## ⚙️ Features

✅ Transparent on-chain record of loan agreements  
✅ ETH / CELO-based funding and repayment (on Celo network)  
✅ Tracks principal, interest, duration, and repayment status  
✅ Lender withdrawal mechanism  
✅ Supports multiple repayments  
✅ Default marking after loan term expiry  
✅ Event-based tracking for each action  

---

## 🧱 How It Works

### 1. Create an Agreement  
The lender starts by creating a loan record:  
```solidity
createAgreement(
  borrowerAddress,
  principalInWei,
  interestRateInBasisPoints,  // 100 = 1%
  durationInSeconds,
  "optional memo"
)
