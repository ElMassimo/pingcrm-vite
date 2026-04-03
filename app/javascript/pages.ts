// NOTE: Optimize the SSR bundle by not splitting by page.
const pages = import.meta.env.SSR
  ? import.meta.glob('./Pages/**/*.vue', { eager: true })
  : import.meta.glob('./Pages/**/*.vue')

export async function resolvePage (name: string) {
  const page = pages[`./Pages/${name}.vue`]

  if (!page)
    throw new Error(`Unknown page ${name}. Is it located under Pages with a .vue extension?`)

  const module = import.meta.env.SSR
    ? page
    : await page()

  const component = (module as any).default || module
  component.layout = component.layout || (await import('./Layouts/Main.vue')).default
  return component
}
