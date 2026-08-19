import { generatedPapers } from '@/generated/papers'

export interface PaperConfig {
  id: string
  title: string
  subtitle: string
  abstract: string
  pdfUrl: string
  latexUrl?: string
  githubUrl: string
  authors: readonly string[]
  tags: readonly string[]
  featured?: boolean
}

export interface SiteConfig {
  name: string
  fullName: string
  description: string
  website: string
  github: string
  papers: readonly PaperConfig[]
}

export const siteConfig: SiteConfig = {
  name: 'Lux Network',
  fullName: 'Lux Industries',
  description: 'Post-quantum consensus, verifiable computation, high-performance execution, and omnichain settlement. A complete, searchable library generated directly from the published paper archive.',
  website: 'https://lux.network',
  github: 'https://github.com/luxfi',
  papers: generatedPapers,
}
