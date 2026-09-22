// Maps the legacy `@inertiajs/inertia` API onto the unified `@inertiajs/vue3`
// router. `@js-from-routes/inertia` (used by `~/api`, i.e. `$api`) imports
// `{ Inertia }` from `@inertiajs/inertia` and calls `Inertia[method](...)`.
// Aliasing that package to this shim (see vite.config.ts) routes `$api` calls
// through the same Inertia instance as the app, so progress, flash and page
// state stay in sync.
import { router } from '@inertiajs/vue3'

export const Inertia = router
export default router
