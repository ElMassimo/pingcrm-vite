import { createInertiaApp, Head, Link } from '@inertiajs/vue3'
import type { DefineComponent } from 'vue'
import { createApp as createVueApp, createSSRApp, h } from 'vue'
import { resolvePage } from '~/pages'
import api from '~/api'

export function createApp (options: Record<string, any> = {}) {
  return createInertiaApp({
    title: (title) => title ? `${title} - PingCRM on Vite Ruby` : 'PingCRM on Vite Ruby',
    resolve: resolvePage,
    setup ({ App, props, plugin, el }) {
      const createFn = import.meta.env.SSR ? createSSRApp : createVueApp
      const app = createFn({ render: () => h(App, props) })

      app.use(plugin)
      app.component('InertiaHead', Head)
      app.component('InertiaLink', Link)
      app.config.globalProperties.$api = api

      if (el) {
        app.mount(el)
      }

      return app
    },
    ...options,
  })
}
