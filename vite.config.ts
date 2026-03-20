import { defineConfig } from 'vite'
import path from 'path'

import Vue from '@vitejs/plugin-vue'
import RubyPlugin from 'vite-plugin-ruby'
import ReloadOnChange from 'vite-plugin-full-reload'

export default defineConfig({
  resolve: {
    alias: {
      '@inertiajs/inertia': path.resolve(__dirname, 'app/javascript/shims/inertia.ts'),
    },
  },
  plugins: [
    ReloadOnChange(['config/routes.rb', 'app/views/**/*']),
    RubyPlugin(),
    Vue(),
  ],
})
