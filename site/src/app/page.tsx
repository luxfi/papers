import { Footer } from '@/components/Footer'
import { Header } from '@/components/Header'
import { PaperLibrary } from '@/components/PaperLibrary'
import { siteConfig } from '@/config/papers'

export default function Home() {
  return (
    <div className="flex min-h-svh flex-col">
      <Header config={siteConfig} />
      <main className="flex-1">
        <div className="mx-auto max-w-7xl px-6 pb-12 pt-16">
          <p className="mb-3 font-mono text-sm text-muted-foreground">{siteConfig.papers.length} published papers · generated from main</p>
          <h1 className="mb-4 text-4xl font-bold tracking-tight md:text-5xl">Lux Network<span className="mt-1 block text-2xl font-normal text-muted-foreground md:text-3xl">Research Library</span></h1>
          <p className="max-w-3xl text-lg leading-relaxed text-muted-foreground">{siteConfig.description}</p>
        </div>
        <div className="mx-auto max-w-7xl px-6 pb-20"><PaperLibrary papers={siteConfig.papers} /></div>
      </main>
      <Footer config={siteConfig} />
    </div>
  )
}
