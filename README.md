# 💠 BorrowBlock  
*A Transparent Ledger for Credit Agreements on the Blockchain*

![Solidity](https://img.shields.io/badge/Solidity-0.8.x-blue?logo=ethereum)
![License](https://img.shields.io/badge/License-MIT-green)
![Status](https://img.shields.io/badge/Network-Celo%20Sepolia-yellow)
![Deployed](https://img.shields.io/badge/Deployed-Yes-success)

<img width="1920" height="1080" alt="Screenshot (42)" src="https://github.com/user-attachments/assets/851ce57d-4a8b-4c2b-bdc1-97116b3c559b" />


## 🧩 Project Description  

**BorrowBlock** is a simple and transparent blockchain-based ledger for recording **credit agreements** between lenders and borrowers.  
It enables **trustless, verifiable, and decentralized lending** — where all transactions and agreements are permanently stored on the blockchain.  

This project is designed as a **beginner-friendly Solidity smart contract** for learning how to create, fund, repay, and manage small on-chain loan agreements securely.

---

## ⚙️ What It Does  

BorrowBlock provides a **public and immutable ledger** of credit agreements, enabling users to:  

1. **Create** a loan agreement specifying borrower, principal, interest, and duration.  
2. **Fund** the agreement, sending funds directly to the borrower.  
3. **Repay** the loan on-chain, tracked transparently.  
4. **Withdraw** repayments as the lender.  
5. **Mark** agreements as **repaid** or **defaulted** depending on repayment status.  

All actions emit blockchain events for traceability, ensuring complete transparency in the credit process.  

---

## 🌟 Features  

✅ **Transparent Ledger** – All loans and repayments are visible on-chain.  
✅ **Decentralized Agreements** – No third party, just lender and borrower.  
✅ **ETH/CELO Support** – Works with native CELO currency on the Celo network.  
✅ **Interest Tracking** – Calculates simple interest based on rate and duration.  
✅ **Default Detection** – Automatically identifies overdue loans.  
✅ **Secure Withdrawals** – Lenders can withdraw repayments anytime.  
✅ **Event Logging** – Every action (create, repay, withdraw) emits logs for auditing.  

---

## 🌐 Deployed Smart Contract  

**Network:** Celo Sepolia Testnet  
**Contract Address:** `0xD04BA6AbB414f32Ba22F05816d671c35E1ee65e1`  
**Block Explorer:** [View on Blockscout](https://celo-sepolia.blockscout.com/address/0xD04BA6AbB414f32Ba22F05816d671c35E1ee65e1)  

You can verify the live contract, view all transactions, and check event logs directly on **Blockscout**.

---

## 💻 How to Use  

### 🧠 Prerequisites  
- [Remix IDE](https://remix.ethereum.org) or [Hardhat](https://hardhat.org)  
- A crypto wallet (e.g., [MetaMask](https://metamask.io))  
- Some **test CELO** from [Celo Faucet](https://faucet.celo.org)  

### 🚀 Steps  
1. Open **Remix IDE** and paste the Solidity code for BorrowBlock.  
2. Compile using **Solidity 0.8.x**.  
3. Connect your wallet to **Celo Sepolia** network.  
4. Deploy or interact using the **Deployed Contract** address above.  
5. Try creating, funding, and repaying an agreement!  

---

## 🧮 Example Use Case  

1. **Lender** creates a loan agreement of `1 CELO` at `5%` interest for `30 days`.  
2. **Borrower** receives the funds once the agreement is funded.  
3. After `30 days`, the **borrower repays** `1.004 CELO` (including interest).  
4. The **lender withdraws** the repayment, and the agreement is marked as **Repaid**.  

---

## 🛠️ Tech Stack  

- **Language:** Solidity (v0.8.x)  
- **Blockchain:** Celo (Sepolia Testnet)  
- **IDE:** Remix / Hardhat  
- **Explorer:** Blockscout  
- **Wallet:** MetaMask  

---

## 📜 License  

This project is licensed under the **MIT License** — feel free to use and modify it for your own learning or projects.

---

## ✍️ Author  

Developed by **Arijit Debnath**  
Assisted by **GPT-5 (OpenAI)**  

> 💬 *"Transparency builds trust — even in credit."*
