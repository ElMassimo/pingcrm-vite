import { createRenderer } from 'vue-server-renderer'
import createServer from '@inertiajs/server'
import { createApp } from '~/app'

createServer(page => createApp({
  page,
  render: createRenderer().renderToString,
}))
