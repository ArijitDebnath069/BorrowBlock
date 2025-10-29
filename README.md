# 💠 BorrowBlock  
*A Transparent Blockchain Ledger for Credit Agreements*

![Solidity](https://img.shields.io/badge/Solidity-0.8.x-blue?logo=ethereum)
![License](https://img.shields.io/badge/License-MIT-green)
![Status](https://img.shields.io/badge/Stage-Beginner%20Project-orange)

---

## 🧩 Overview


<img width="1920" height="1080" alt="Screenshot (42)" src="https://github.com/user-attachments/assets/20d03147-fcf8-4809-8bb9-fe1145cfed2f" />




**BorrowBlock** is a beginner-friendly **Solidity smart contract** that creates a **transparent, immutable ledger** for credit (loan) agreements between lenders and borrowers.  

It allows anyone to:
- Record a new credit agreement (loan terms)
- Fund the loan directly to a borrower
- Repay in ETH (tracked on-chain)
- Withdraw repayments
- Mark loans as **repaid** or **defaulted**

Everything is **public and verifiable** on the blockchain — promoting trust and transparency in peer-to-peer credit.

---

## ⚙️ Features

✅ Transparent on-chain record of loan agreements  
✅ ETH-based funding and repayment  
✅ Tracks principal, interest, duration, and repayment status  
✅ Lender withdrawal mechanism  
✅ Supports multiple repayments  
✅ Default marking after loan term expiry  
✅ Clean event logs for tracking actions  

---

## 🧱 How It Works

### 1. Create an Agreement
The **lender** starts by creating a loan record:
```solidity
createAgreement(
  borrowerAddress,
  principalInWei,
  interestRateInBasisPoints,  // 100 = 1%
  durationInSeconds,
  "optional memo"
)
