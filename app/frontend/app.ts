import { createInertiaApp } from '@inertiajs/vue3'
import { createSSRApp, h } from 'vue'
import { resolvePage } from '~/pages'
import api from '~/api'

type InertiaOptions = Parameters<typeof createInertiaApp>[0]

export function createApp (options?: Omit<InertiaOptions, 'resolve' | 'setup'>) {
  return createInertiaApp({
    resolve: resolvePage,

    title: title => [title, 'PingCRM on Vite Ruby'].filter(x => x).join(' - '),

    setup ({ plugin, App, props, el }) {
      const app = createSSRApp({ render: () => h(App, props) })
        .use(plugin)

      app.config.globalProperties.$api = api

      if (el)
        app.mount(el)

      return app
    },
    ...options,
  })
}
