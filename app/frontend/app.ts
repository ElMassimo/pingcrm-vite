import { createInertiaApp } from '@inertiajs/inertia-vue'
import type { CreateInertiaAppProps } from '@inertiajs/inertia-vue'
import Vue from '~/vue'
import { resolvePage } from '~/pages'

export function createApp (options: Omit<CreateInertiaAppProps, 'resolve' | 'setup'>) {
  return createInertiaApp({
    resolve: resolvePage,
    setup ({ plugin, app, props, el }) {
      Vue.use(plugin)

      const vueApp = new Vue({
        render: h => h(app, props),
        metaInfo: {
          titleTemplate (title) {
            return title ? `${title} - PingCRM on Vite Ruby` : 'PingCRM on Vite Ruby'
          },
        },
      })

      if (el)
        vueApp.$mount(el)

      return vueApp
    },
    ...options,
  })
}
