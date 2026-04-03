// Shim for @inertiajs/inertia to support @js-from-routes/inertia
// which still imports from the old package name.
import { router } from '@inertiajs/vue3'

export const Inertia = router
