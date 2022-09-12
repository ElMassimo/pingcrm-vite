import DefaultLayout from '~/layouts/DefaultLayout.vue'

// NOTE: Optimize the SSR bundle by not splitting by page.
const pages = import.meta.env.SSR
  ? import.meta.globEagerDefault('./**/*.vue')
  : import.meta.glob('./**/*.vue')

export async function resolvePage (name: string) {
  const page = pages[`./${name}.vue`]

  if (!page)
    throw new Error(`Unknown page ${name}. Is it located under 'app/frontend/pages' with a .vue extension?`)

  const resolvedPage  = import.meta.env.SSR ? page : (await page()).default

  return {
    layout: DefaultLayout,
    ...resolvedPage,
  }
}
