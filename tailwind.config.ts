import type { Config } from 'tailwindcss'

const config: Config = {
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        hanzo: {
          primary: '#FF6B35',
          secondary: '#004E89',
          accent: '#00D9FF',
        },
        zoo: {
          primary: '#2ECC71',
          secondary: '#27AE60',
          accent: '#F39C12',
        },
        zen: {
          primary: '#9B59B6',
          secondary: '#8E44AD',
          accent: '#E74C3C',
        },
        lux: {
          primary: '#3498DB',
          secondary: '#2980B9',
          accent: '#E67E22',
        },
      },
    },
  },
  plugins: [],
}
export default config
