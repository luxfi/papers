import type { SiteConfig } from '@/config/papers'

export function Footer({ config }: { config: SiteConfig }) {
  return (
    <footer className="mt-20 border-t border-border/60">
      <div className="mx-auto flex max-w-7xl flex-col items-center justify-between gap-4 px-6 py-8 text-sm text-muted-foreground md:flex-row">
        <p>&copy; {new Date().getFullYear()} {config.fullName}</p>
        <div className="flex gap-5"><a href={config.website} className="hover:text-foreground">Network</a><a href={config.github} className="hover:text-foreground">GitHub</a></div>
      </div>
    </footer>
  )
}
