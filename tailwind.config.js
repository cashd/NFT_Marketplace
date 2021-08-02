const colors = require('tailwindcss/defaultTheme')

module.exports = {
  purge: [
    './pages/**/*.{js,ts,jsx,tsx}',
    './components/**/*.{js,ts,jsx,tsx}',
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        retro: {
          pink: '#FFCFEA',
          pinkOpac4: 'rgba(255, 207, 234, 0.5)',
          purple: '#D2C9FD',
          blue: '#AFE9FF',
        },
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
