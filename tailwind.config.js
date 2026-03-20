const colors = require('tailwindcss/colors')

/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    'app/views/**/*.{html,erb}',
    'app/helpers/**/*.rb',
    'app/javascript/**/*.{vue,js,ts,jsx,tsx}',
  ],
  theme: {
    extend: {
      colors: {
        transparent: 'transparent',
        current: 'currentColor',
        black: colors.black,
        white: colors.white,
        red: colors.red,
        orange: colors.orange,
        yellow: colors.yellow,
        green: colors.green,
        gray: colors.slate,
        indigo: {
          100: '#e6e8ff',
          300: '#b2b7ff',
          400: '#7886d7',
          500: '#6574cd',
          600: '#5661b3',
          800: '#2f365f',
          900: '#191e38',
        },
      },
      borderColor: ({ theme }) => ({
        DEFAULT: theme('colors.gray.200', 'currentColor'),
      }),
      boxShadow: ({ theme }) => ({
        outline: `0 0 0 2px ${theme('colors.indigo.500')}`,
      }),
      fill: ({ theme }) => theme('colors'),
    },
  },
  plugins: [],
}
