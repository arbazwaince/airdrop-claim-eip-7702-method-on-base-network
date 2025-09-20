import 'dotenv/config'
import { createWalletClient, http, zeroAddress } from 'viem'
import { privateKeyToAccount } from 'viem/accounts'

const RPC_URL =
  process.env.RPC_URL_BASE ??
const CHAIN_ID = Number(process.env.CHAIN_ID || 59144)
const PRIVKEY_B = process.env.PRIVKEY_B!
const PRIVKEY_A = process.env.PRIVKEY_A!
const ADDR_A = process.env.ADDR_A!

const chain = {
  id: CHAIN_ID,
  name: 'EVM',
  nativeCurrency: { name: 'Ether', symbol: 'ETH', decimals: 18 },
  rpcUrls: { default: { http: [RPC_URL] } },
} as const

async function main() {
  const accountA = privateKeyToAccount(PRIVKEY_A as `0x${string}`)
  const accountB = privateKeyToAccount(PRIVKEY_B as `0x${string}`)
  const walletB = createWalletClient({ account: accountB, chain, transport: http(RPC_URL) })

  const authorization = await walletB.signAuthorization({
    account: accountA,
    chainId: CHAIN_ID,
    contractAddress: zeroAddress,
  })

  const hash = await walletB.sendTransaction({
    to: ADDR_A as `0x${string}`,
    data: '0x',
    authorizationList: [authorization],
  })
  console.log('revoke tx:', hash)
}

main().catch((e) => {
  console.error(e)
  process.exit(1)
})
