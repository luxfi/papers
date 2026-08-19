import { execFileSync } from 'node:child_process'
import { copyFileSync, existsSync, mkdirSync, readdirSync, readFileSync, rmSync, writeFileSync } from 'node:fs'
import { basename, dirname, join, relative, resolve } from 'node:path'

const siteRoot = resolve(import.meta.dirname, '..')
const repoRoot = resolve(siteRoot, '..')
const pdfRoot = join(siteRoot, 'public', 'pdfs')
const generatedRoot = join(siteRoot, 'src', 'generated')
const sourceRoot = join(generatedRoot, 'papers.ts')

const featured = new Map([
  ['lux-aivm/lux-aivm.pdf', {
    rank: 0,
    title: 'AIVM: Proof of AI',
    subtitle: 'PQ-Rooted Useful-Work Consensus and Omnichain Settlement',
    abstract: 'A-Chain is the sole useful-work mining authority: it admits demand-backed AI jobs, validates deterministic integer execution, consumes the global work nullifier, and finalizes one receipt. Z-Chain compresses those finalized transitions with P3Q, a Plonky3-derived pairing-free STARK/FRI settlement proof, while Lux Quasar supplies post-quantum finality.',
    tags: ['Proof of AI', 'A-Chain', 'P3Q', 'Post-Quantum'],
  }],
  ['ethos-of-lux.pdf', {
    rank: 1,
    title: 'The Ethos of Lux',
    subtitle: 'Eight Design Principles for the Lux Network',
    abstract: 'The architectural constraints that guide Lux protocol, cryptography, and product decisions.',
    tags: ['Architecture', 'Design Principles'],
  }],
  ['lp-020-quasar-consensus/lp-020-quasar-consensus.pdf', {
    rank: 2,
    title: 'Quasar Consensus',
    subtitle: 'Hybrid Post-Quantum Finality for Lux Chains',
    abstract: 'The consensus and certificate architecture that orders and finalizes Lux state with classical performance and post-quantum durability.',
    tags: ['Consensus', 'Quasar', 'Post-Quantum'],
  }],
  ['lp-219-p3q-framework/lp-219-p3q-framework.pdf', {
    rank: 3,
    title: 'P3Q',
    subtitle: 'Pairing-Free Post-Quantum Proof Aggregation',
    abstract: 'The Lux proof framework for compressing post-quantum verification and settlement into pairing-free STARK/FRI proofs.',
    tags: ['P3Q', 'STARK', 'FRI', 'Z-Chain'],
  }],
  ['lp-073-pulsar/lp-073-pulsar.pdf', {
    rank: 4,
    title: 'Pulsar',
    subtitle: 'Dynamic Lattice Threshold Signatures',
    abstract: 'Module-LWE threshold signatures with lifecycle support for dynamic validator sets and Quasar finality.',
    tags: ['Post-Quantum', 'Threshold Signatures', 'Module-LWE'],
  }],
  ['lux-corona-pq/lux-corona-pq.pdf', {
    rank: 5,
    title: 'Corona',
    subtitle: 'Two-Round Module-LWE Threshold Signatures',
    abstract: 'A permissionless lattice-threshold construction with dealerless key generation and dynamic validator-set support.',
    tags: ['Post-Quantum', 'Threshold Signatures', 'Module-LWE'],
  }],
  ['lux-magnetar-pq/lux-magnetar-pq.pdf', {
    rank: 6,
    title: 'Magnetar',
    subtitle: 'Hash-Based Post-Quantum Signatures for Consensus',
    abstract: 'The SLH-DSA leg of the Lux post-quantum certificate family.',
    tags: ['Post-Quantum', 'SLH-DSA', 'Consensus'],
  }],
  ['chain-first-architecture/chain-first-architecture.pdf', {
    rank: 7,
    title: 'Chain-First Architecture',
    subtitle: 'Blockchain as the Source of Truth',
    abstract: 'A state architecture in which signed chain history is authoritative and conventional databases are rebuildable read caches.',
    tags: ['Architecture', 'State Machine', 'Infrastructure'],
  }],
])

const acronyms = new Map([
  ['ai', 'AI'], ['aivm', 'AIVM'], ['amm', 'AMM'], ['api', 'API'], ['bls', 'BLS'],
  ['achain', 'A-Chain'], ['ats', 'ATS'], ['dag', 'DAG'], ['dao', 'DAO'], ['dex', 'DEX'], ['did', 'DID'], ['evm', 'EVM'], ['fhe', 'FHE'],
  ['fpc', 'FPC'], ['fri', 'FRI'], ['gpu', 'GPU'], ['iam', 'IAM'], ['kem', 'KEM'],
  ['hsm', 'HSM'], ['lss', 'LSS'], ['lwe', 'LWE'], ['ml', 'ML'], ['mlkem', 'ML-KEM'], ['mpc', 'MPC'], ['mvcc', 'MVCC'], ['ntt', 'NTT'],
  ['p3q', 'P3Q'], ['pq', 'PQ'], ['qkd', 'QKD'], ['rns', 'RNS'], ['slh', 'SLH'],
  ['simd', 'SIMD'], ['sql', 'SQL'], ['stark', 'STARK'], ['tee', 'TEE'], ['tfhe', 'TFHE'], ['tls', 'TLS'], ['tla', 'TLA'], ['ux', 'UX'], ['vfs', 'VFS'], ['vm', 'VM'],
  ['wasm', 'WASM'], ['zchain', 'Z-Chain'], ['zk', 'ZK'], ['zkp', 'ZKP'], ['zap', 'ZAP'],
])

function trackedPdfs() {
  const output = execFileSync('git', ['ls-files', '-z', '*.pdf'], { cwd: repoRoot })
  return output.toString().split('\0').filter(Boolean).filter((path) => !path.startsWith('site/'))
}

function paperId(path) {
  const withoutExt = path.replace(/\.pdf$/i, '').replace(/\/paper$/i, '')
  return withoutExt.replace(/[^a-zA-Z0-9]+/g, '-').replace(/^-|-$/g, '').toLowerCase()
}

function titleFor(path) {
  let slug = basename(path, '.pdf')
  if (slug === 'paper') slug = basename(dirname(path))
  return slug
    .replace(/^lux[-_]/, '')
    .replace(/[-_]+/g, ' ')
    .split(' ')
    .filter(Boolean)
    .map((word) => acronyms.get(word.toLowerCase()) || (/^lp\d+$/i.test(word) ? word.toUpperCase().replace(/^LP/, 'LP-') : word.charAt(0).toUpperCase() + word.slice(1)))
    .join(' ')
    .replace(/\b(\d+) (\d+)\b/g, '$1.$2')
}

function categoryFor(path) {
  const value = path.toLowerCase()
  if (/aivm|p3q|stark|fri|proof|zchain|zkp/.test(value)) return 'Proofs & Settlement'
  if (/consensus|quasar|nova|nebula|photon|wave|flare|prism|ray|field|fpc|mysticeti/.test(value)) return 'Consensus'
  if (/post-quantum|\bpq\b|corona|pulsar|magnetar|mlkem|lattice|crypto|threshold|fhe|tfhe|qkd|encrypted|privacy/.test(value)) return 'Post-Quantum & Privacy'
  if (/evm|gpu|ntt|performance|benchmark|block-stm|execution|scaling/.test(value)) return 'Execution & Performance'
  if (/bridge|teleport|warp|omnichain|cross-chain|interchain/.test(value)) return 'Interoperability'
  if (/dex|amm|defi|finance|liquidity|market|credit|lending|custody|securities|asset/.test(value)) return 'Markets & Finance'
  if (/governance|dao|tokenomics|validator|economics/.test(value)) return 'Governance'
  return 'Architecture & Infrastructure'
}

function sourceFor(pdfPath) {
  const folder = join(repoRoot, dirname(pdfPath))
  if (!existsSync(folder)) return undefined
  const preferred = join(folder, `${basename(pdfPath, '.pdf')}.tex`)
  if (existsSync(preferred)) return relative(repoRoot, preferred)
  if (dirname(pdfPath) === '.') return undefined
  const candidates = readdirSync(folder)
    .filter((name) => name.endsWith('.tex'))
    .map((name) => join(folder, name))
  return candidates.find((path) => /\\documentclass/.test(readFileSync(path, 'utf8')))
    ? relative(repoRoot, candidates.find((path) => /\\documentclass/.test(readFileSync(path, 'utf8'))))
    : undefined
}

rmSync(pdfRoot, { recursive: true, force: true })
mkdirSync(pdfRoot, { recursive: true })
mkdirSync(generatedRoot, { recursive: true })

const papers = trackedPdfs().map((path) => {
  const id = paperId(path)
  const outputName = `${id}.pdf`
  copyFileSync(join(repoRoot, path), join(pdfRoot, outputName))
  const source = sourceFor(path)
  const detail = featured.get(path)
  const category = categoryFor(path)
  return {
    id,
    title: detail?.title || titleFor(path),
    subtitle: detail?.subtitle || category,
    abstract: detail?.abstract || '',
    pdfUrl: `/pdfs/${outputName}`,
    latexUrl: source ? `https://github.com/luxfi/papers/blob/main/${source}` : undefined,
    githubUrl: source ? `https://github.com/luxfi/papers/blob/main/${source}` : 'https://github.com/luxfi/papers',
    authors: ['Lux Industries'],
    tags: detail?.tags || [category],
    featured: Boolean(detail),
    rank: detail?.rank ?? 999,
  }
}).sort((a, b) => a.rank - b.rank || a.title.localeCompare(b.title))

writeFileSync(sourceRoot, `// Generated by scripts/generate-catalog.mjs. Do not edit.\nexport const generatedPapers = ${JSON.stringify(papers, null, 2)} as const\n`)
console.log(`Generated ${papers.length} papers and copied their PDFs.`)
