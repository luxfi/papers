'use client'

import { Moon, Sun } from 'lucide-react'
import { useTheme } from 'next-themes'
import type { SiteConfig } from '@/config/papers'

export function Header({ config }: { config: SiteConfig }) {
  const { resolvedTheme, setTheme } = useTheme()
  return (
    <header className="sticky top-0 z-50 border-b border-border/60 bg-background/85 backdrop-blur-xl">
      <div className="mx-auto flex max-w-7xl items-center justify-between px-6 py-4">
        <a href="/" className="flex items-center gap-3" aria-label="Lux papers home">
          <Logo />
          <div>
            <p className="text-lg font-semibold tracking-tight">{config.name}</p>
            <p className="text-xs text-muted-foreground">Research Library</p>
          </div>
        </a>
        <div className="flex items-center gap-4">
          <nav className="hidden items-center gap-5 text-sm md:flex">
            <a href="https://proofs.lux.network" className="text-muted-foreground transition-colors hover:text-foreground">Formal Proofs</a>
            <a href={config.website} className="text-muted-foreground transition-colors hover:text-foreground">Network</a>
            <a href={config.github} className="text-muted-foreground transition-colors hover:text-foreground">GitHub</a>
          </nav>
          <button
            type="button"
            onClick={() => setTheme(resolvedTheme === 'dark' ? 'light' : 'dark')}
            className="rounded-md p-2 text-muted-foreground transition-colors hover:bg-accent hover:text-foreground"
            aria-label="Toggle theme"
          >
            <Sun className="hidden h-4 w-4 dark:block" />
            <Moon className="h-4 w-4 dark:hidden" />
          </button>
        </div>
      </div>
    </header>
  )
}

function Logo() {
  return (
    <svg viewBox="0 0 32 32" className="h-7 w-7" aria-hidden="true">
      <path d="M16 2 30 27H2L16 2Zm0 7.2L8.7 23h14.6L16 9.2Z" fill="currentColor" fillRule="evenodd" />
    </svg>
  )
}
