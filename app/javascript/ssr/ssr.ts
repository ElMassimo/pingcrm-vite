import { renderToString } from 'vue/server-renderer'
import { createInertiaApp } from '@inertiajs/vue3'
import createServer from '@inertiajs/vue3/server'
import { createSSRApp, h } from 'vue'
import { resolvePage } from '~/pages'
import api from '~/api'
import { Head, Link } from '@inertiajs/vue3'

createServer(page => createInertiaApp({
  page,
  render: renderToString,
  title: (title) => title ? `${title} - PingCRM on Vite Ruby` : 'PingCRM on Vite Ruby',
  resolve: resolvePage,
  setup ({ App, props, plugin }) {
    const app = createSSRApp({ render: () => h(App, props) })

    app.use(plugin)
    app.component('InertiaHead', Head)
    app.component('InertiaLink', Link)
    app.config.globalProperties.$api = api

    return app
  },
}))
