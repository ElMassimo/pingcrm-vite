// This file is automatically detected by Vite Rails, along with any other files
// present in this directory. You're encouraged to place your actual application
// logic in a relevant structure within app/javascript and only use these
// entrypoints to reference that code so it'll be compiled.
import 'virtual:windi.css'
import 'virtual:windi-devtools'
import '~/styles/application.css'

import { InertiaProgress } from '@inertiajs/progress'
import { createApp } from '~/app'

InertiaProgress.init()

createApp()
