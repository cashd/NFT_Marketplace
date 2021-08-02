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
        grayD: '#C4C4C4',
      },
    },
    screens: {
      '2xl': { max: '1535px' },
      // => @media (max-width: 1535px) { ... }

      xl: { max: '1279px' },
      // => @media (max-width: 1279px) { ... }

      lg: { max: '1023px' },
      // => @media (max-width: 1023px) { ... }

      md: { max: '639px' },
      // => @media (max-width: 767px) { ... }

      sm: { min: '639px' },
      // => @media (max-width: 639px) { ... }
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
