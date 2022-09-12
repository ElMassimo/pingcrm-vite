import { defineConfig, splitVendorChunkPlugin } from 'vite'

import vue from '@vitejs/plugin-vue'
import ruby from 'vite-plugin-ruby'
import windicss from 'vite-plugin-windicss'

import autoImport from 'unplugin-auto-import/vite'
import components from 'unplugin-vue-components/vite'
import layouts from './app/frontend/vite-plugins/layouts'
import reloadOnChange from 'vite-plugin-full-reload'

import inspect from 'vite-plugin-inspect'

export default defineConfig({
  plugins: [
    /**
     * Core
     */
    ruby(),
    vue({ reactivityTransform: true }),
    windicss({ root: process.cwd() }),

    /**
     * DX
     */
    autoImport({
      imports: ['vue'],
    }),
    components({
      dts: true,
      dirs: [`components`],
      extensions: ['vue', 'ts'],
    }),
    layouts(),
    reloadOnChange(['config/routes.rb', 'app/views/**/*']),

    /**
     * Build
     */
    splitVendorChunkPlugin(),

    /**
     * Debug
     */
    process.env.DEBUG && inspect(),
  ],
})
