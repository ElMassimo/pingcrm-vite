import js from '@eslint/js'
import pluginVue from 'eslint-plugin-vue'
import globals from 'globals'
import tseslint from 'typescript-eslint'

export default tseslint.config(
  {
    ignores: [
      'app/frontend/.vite-inspect/**',
      'app/frontend/auto-imports.d.ts',
      'app/frontend/components.d.ts',
      'node_modules/**',
      'public/**',
      'vendor/**',
    ],
  },
  js.configs.recommended,
  ...tseslint.configs.recommended,
  ...pluginVue.configs['flat/recommended'],
  {
    files: ['app/frontend/**/*.{js,ts,vue}'],
    languageOptions: {
      globals: {
        ...globals.browser,
        ...globals.node,
        $computed: 'readonly',
        $ref: 'readonly',
        computed: 'readonly',
        nextTick: 'readonly',
        onMounted: 'readonly',
        onUnmounted: 'readonly',
        ref: 'readonly',
        useId: 'readonly',
        useTemplateRef: 'readonly',
        watch: 'readonly',
      },
    },
    rules: {
      '@typescript-eslint/no-explicit-any': 'off',
      'no-alert': 'off',
      'no-debugger': process.env.NODE_ENV === 'production' ? 'error' : 'off',
      'vue/block-order': ['error', { order: ['script', 'template', 'style'] }],
      'vue/component-name-in-template-casing': ['error', 'PascalCase', { registeredComponentsOnly: false }],
      'vue/define-props-destructuring': ['error', { destructure: 'always' }],
      'vue/multi-word-component-names': 'off',
    },
  },
  {
    files: ['app/frontend/**/*.vue'],
    languageOptions: {
      parserOptions: {
        parser: tseslint.parser,
      },
    },
  },
)
