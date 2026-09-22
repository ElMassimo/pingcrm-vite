import createServer from '@inertiajs/vue3/server'
import { renderToString } from 'vue/server-renderer'
import { createApp } from '~/app'

createServer(page => createApp({
  page,
  render: renderToString,
}))
