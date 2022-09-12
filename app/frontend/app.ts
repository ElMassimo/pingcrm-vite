import { createInertiaApp } from '@inertiajs/inertia-vue3'
import type { CreateInertiaAppProps } from '@inertiajs/inertia-vue3'
import { createApp as createVueApp, h } from 'vue'
import { resolvePage } from '~/pages'
import api from '~/api'

export function createApp (options?: Omit<CreateInertiaAppProps, 'resolve' | 'setup'>) {
  return createInertiaApp({
    resolve: resolvePage,

    title: title => [title, 'PingCRM on Vite Ruby'].filter(x => x).join(' - '),

    setup ({ plugin, app: InertiaApp, props, el }) {
      const app = createVueApp({ render: () => h(InertiaApp, props) })
        .use(plugin)

      app.config.globalProperties.$api = api

      if (el)
        app.mount(el)

      return app
    },
    ...options,
  })
}
