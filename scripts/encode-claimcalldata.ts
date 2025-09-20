import 'dotenv/config'
import { encodeFunctionData, parseAbi } from 'viem'

const SIG = process.env.CLAIM_TO_SIGNATURE || 'claim(address)'
const RECIPIENT = process.env.RECIPIENT_B!
const EXTRA_ARGS_JSON = process.env.EXTRA_ARGS_JSON || '[]'

const abi = parseAbi([`function ${SIG}`])
const args = [RECIPIENT, ...JSON.parse(EXTRA_ARGS_JSON)]
const data = encodeFunctionData({ abi, functionName: SIG.split('(')[0] as any, args })
console.log(data)
