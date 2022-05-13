// NOTE: Optimize the SSR bundle by not splitting by page.
const pages = import.meta.env.SSR
  ? import.meta.globEagerDefault('./Pages/**/*.vue')
  : import.meta.glob('./Pages/**/*.vue')

export async function resolvePage (name: string) {
  const page = pages[`./Pages/${name}.vue`]

  if (!page)
    throw new Error(`Unknown page ${name}. Is it located under Pages with a .vue extension?`)

  return import.meta.env.SSR
    ? page
    : (await page()).default
}
