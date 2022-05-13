import { createRenderer } from 'vue-server-renderer'
import { createApp } from '~/app'

import createServer from '@inertiajs/server'

createServer((page) => createApp({
  page,
  render: createRenderer().renderToString,
}))
