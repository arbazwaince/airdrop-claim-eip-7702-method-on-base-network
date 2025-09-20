# Airdrop Claim eip-7702 Method on Base Network
Claim airdrop with eip 7702 method for drained wallets on base network

---

## 1. Clone and install

```bash
git clone https://github.com/abahuto/airdrop-claim-eip-7702-method-on-base-network.git
```
```bash
cd airdrop-claim-eip-7702-method-on-base-network
```
```bash
npm install
```

## 2. Configure environment variables

Create a `.env` 
```bash
nano .env
```
Input
```bash
RPC_URL_BASE=https://base.drpc.org 
CHAIN_ID=8453 

//WALLET THAT HAS BEEN DRAINED
PRIVKEY_A=0xYour_Privatekey
ADDR_A=0xYour_adrress

//WALLET TO PAY GAS FEES
PRIVKEY_B=0xYour_Privatekey

//NEW WALLET TO RECEIVE AIRDROP
RECIPIENT_ADDR=0xYour_adrress

//AIRDROP CLAIM CONTRACT ADDRESS
AIRDROP_ADDR=0x...

//AIRDROP TOKEN ADDRESS
TOKEN_ADDR=0x...

//DATA WHEN SIGNING, CAN BE SEEN WHEN SIGNING WALLET
CLAIM_MODE=raw 
AIRDROP_CALLDATA=0x...

CONTRACT_7702=0x6106e79063f9a09f5c950dadd4386e9aea7510c9 
FORWARDER=0xeaa6702a44DeF2C961D8de6285710B4E42858443 
```

---

### For AIRDROP CLAIM CONTRACT ADDRESS & AIRDROP_CALLDATA you can check on wallet example OKX or METAMASK

- Example
the top one is for (CLAIM CONTRACT ADDRESS) the bottom one is for (AIRDROP_CALLDATA)

<img width="333" height="217" alt="image" src="https://github.com/user-attachments/assets/f1a14f5e-34f8-4a86-a59b-aa7676297af4" />


### For AIRDROP TOKEN ADDRESS you can ask the airdrop project about the contract token.

---

## 3. Run scripts

**For Claim:**

```bash
npm run claim
```

**After Claim you can Revoke:**

```bash
npm run revoke
```

---

## Hashtag

#BaseNetwork #EIP7702 #AirdropClaim #DrainedWalletRecovery #WalletRescue #Web3Security #SmartContractTools #CryptoTools #BlockchainRecovery #GasSponsor

