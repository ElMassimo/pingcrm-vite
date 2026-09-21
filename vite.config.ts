import path from 'path'

import { defineConfig } from 'vite'

import vue from '@vitejs/plugin-vue'
import reactivityTransform from '@vue-macros/reactivity-transform/vite'
import ruby from 'vite-plugin-ruby'
import tailwindcss from '@tailwindcss/vite'

import autoImport from 'unplugin-auto-import/vite'
import components from 'unplugin-vue-components/vite'
import layouts from './app/frontend/vite-plugins/layouts.ts'
import reloadOnChange from 'vite-plugin-full-reload'

import inspect from 'vite-plugin-inspect'

export default defineConfig(({ isSsrBuild }) => ({
  resolve: {
    alias: {
      // Route `$api` (js-from-routes) through the unified @inertiajs/vue3 router.
      '@inertiajs/inertia': path.resolve(process.cwd(), 'app/frontend/shims/inertia.ts'),
    },
  },
  build: {
    ssr: isSsrBuild ? 'app/frontend/ssr/ssr.ts' : undefined,
    rollupOptions: {
      output: {
        manualChunks (id) {
          if (id.includes('node_modules'))
            return 'vendor'
        },
      },
    },
  },
  plugins: [
    /**
     * Core
     */
    ruby(),
    tailwindcss(),
    reactivityTransform(),
    vue(),

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
     * Debug
     */
    process.env.DEBUG ? inspect() : undefined,
  ],
}))
