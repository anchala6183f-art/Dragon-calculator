import { resolve } from 'path'
import { defineConfig } from 'vite'

export default defineConfig({
  build: {
    rollupOptions: {
      input: {
        main: resolve(__dirname, 'index.html'),
        about: resolve(__dirname, 'about.html'),
        contact: resolve(__dirname, 'contact.html'),
        howToUse: resolve(__dirname, 'how-to-use.html'),
        privacyPolicy: resolve(__dirname, 'privacy-policy.html')
      }
    }
  }
})
