import { FileText, Star } from 'lucide-react'
import type { PaperConfig } from '@/config/papers'

const basePath = process.env.NEXT_PUBLIC_BASE_PATH || ''

export function PaperCard({ paper }: { paper: PaperConfig }) {
  return (
    <article className="group flex h-full flex-col rounded-lg border border-border/60 bg-card p-5 transition-colors hover:border-foreground/30">
      <div className="mb-3 flex items-center justify-between">
        <span className="font-mono text-[11px] uppercase tracking-wide text-muted-foreground">{paper.tags[0]}</span>
        {paper.featured ? <Star className="h-4 w-4 fill-current text-foreground" aria-label="Featured paper" /> : <FileText className="h-4 w-4 text-muted-foreground/50" />}
      </div>
      <h2 className="mb-1 text-base font-semibold leading-snug">{paper.title}</h2>
      <h3 className="mb-3 text-sm leading-snug text-muted-foreground">{paper.subtitle}</h3>
      {paper.abstract ? <p className="mb-4 line-clamp-4 text-sm leading-relaxed text-muted-foreground/85">{paper.abstract}</p> : null}
      <p className="mb-4 mt-auto text-xs text-muted-foreground">{paper.authors.join(' · ')}</p>
      <div className="mb-4 flex flex-wrap gap-1.5">
        {paper.tags.slice(0, 4).map((tag) => <span key={tag} className="rounded bg-accent px-2 py-0.5 font-mono text-[11px] text-accent-foreground">{tag}</span>)}
      </div>
      <div className="flex gap-2 border-t border-border/40 pt-3">
        <a href={`${basePath}${paper.pdfUrl}`} target="_blank" rel="noreferrer" className="flex flex-1 items-center justify-center gap-1.5 rounded-md bg-foreground px-3 py-1.5 text-sm font-medium text-background transition-opacity hover:opacity-85">
          <FileText className="h-3.5 w-3.5" /> PDF
        </a>
        <a href={paper.githubUrl} target="_blank" rel="noreferrer" className="rounded-md border border-border px-3 py-1.5 text-sm text-muted-foreground transition-colors hover:border-foreground/30 hover:text-foreground">Source</a>
      </div>
    </article>
  )
}
