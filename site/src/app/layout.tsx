import type { Metadata } from 'next'
import { ThemeProvider } from 'next-themes'
import { siteConfig } from '@/config/papers'
import './global.css'

export const metadata: Metadata = {
  title: 'Lux Network Research Library',
  description: siteConfig.description,
  openGraph: { title: 'Lux Network Research Library', description: siteConfig.description, url: 'https://papers.lux.network', siteName: 'Lux Papers', type: 'website' },
}

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" className="dark" suppressHydrationWarning>
      <head><script dangerouslySetInnerHTML={{ __html: `(function(){try{var d=document.documentElement;var s=localStorage.getItem('lux-papers-theme');if(s==='light'){d.classList.remove('dark')}else{d.classList.add('dark')}}catch(e){}})()` }} /></head>
      <body className="min-h-svh bg-background font-sans antialiased">
        <ThemeProvider attribute="class" defaultTheme="dark" storageKey="lux-papers-theme" enableSystem={false}>{children}</ThemeProvider>
      </body>
    </html>
  )
}
