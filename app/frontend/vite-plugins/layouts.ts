import type { Plugin } from 'vite'
import { parse } from 'vue/compiler-sfc'
import MagicString from 'magic-string'

const templateLayoutAttrRegex = /<template.*?\slayout=\s*['"](\w+)['"].*?>/
const pageIdRegex = /\/([^/]+)\/pages\/.*\.vue$/

function titleize (str: string) {
  return `${str[0].toUpperCase()}${str.slice(1)}`
}

/**
 * Public: Allows to specify an Inertia layout in Vue pages using:
 *
 *    <template layout="name">
 */
export default function inertiaLayouts (): Plugin {
  return {
    name: 'inertia:layout',
    enforce: 'pre',
    transform (code: string, id: string) {
      if (!pageIdRegex.test(id)) return

      const layoutName = code.match(templateLayoutAttrRegex)?.[1] ?? 'false'

      if (layoutName === 'false') return

      const { descriptor: { script, scriptSetup }, errors } = parse(code, { filename: id })
      if (errors.length > 0) return

      const s = new MagicString(code)

      let scriptOffset = script?.loc?.start?.offset

      // Open a new script tag if none was defined
      if (scriptOffset === undefined) {
        const scriptLang = scriptSetup?.attrs?.lang
        s.prepend(`<script${scriptLang ? ` lang="${scriptLang}"` : ''}>`)
        scriptOffset = 0
      }

      s.appendRight(scriptOffset, `
import layout from '~/layouts/${titleize(layoutName)}Layout.vue'
export default { layout }\n`)

      // Close script tag if no script tag was defined.
      if (!script)
        s.appendRight(scriptOffset, '\n</script>\n')

      return { code: s.toString(), map: s.generateMap({ hires: true }) }
    },
  }
}
