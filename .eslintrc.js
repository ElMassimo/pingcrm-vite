module.exports = {
  extends: ['@mussi/eslint-config'],
  rules: {
    'no-alert': 'off',
    'no-debugger': process.env.NODE_ENV === 'production' ? 'error' : 'off',
  },
}
