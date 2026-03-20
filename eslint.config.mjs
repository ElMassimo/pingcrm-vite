import js from '@eslint/js'
import pluginVue from 'eslint-plugin-vue'

export default [
  js.configs.recommended,
  ...pluginVue.configs['flat/recommended'],
  {
    languageOptions: {
      globals: {
        console: 'readonly',
        document: 'readonly',
        window: 'readonly',
        setTimeout: 'readonly',
        confirm: 'readonly',
        File: 'readonly',
        FormData: 'readonly',
        URL: 'readonly',
      },
    },
    rules: {
      'no-alert': 'off',
      'no-unused-vars': ['error', { argsIgnorePattern: '^_' }],
      'vue/require-explicit-emits': 'off',
      'vue/multi-word-component-names': 'off',
      'vue/no-reserved-component-names': 'off',
    },
  },
  {
    ignores: ['public/', 'vendor/'],
  },
]
