import DefaultLayout from '~/layouts/DefaultLayout.vue'

const pages = import.meta.glob<{ default: any }>('./**/*.vue')

// Cache resolved pages so a given page keeps a stable component identity across
// reloads. Without this, returning a fresh `{ layout, ...page }` object each
// time makes Inertia re-mount the page on every partial reload (e.g. filtering),
// which would reset component state such as open dropdowns.
const resolved = new Map<string, any>()

export async function resolvePage (name: string) {
  if (resolved.has(name))
    return resolved.get(name)

  const page = pages[`./${name}.vue`]

  if (!page)
    throw new Error(`Unknown page ${name}. Is it located under 'app/frontend/pages' with a .vue extension?`)

  const resolvedPage = {
    layout: DefaultLayout,
    ...(await page()).default,
  }

  resolved.set(name, resolvedPage)

  return resolvedPage
}
