module.exports = {
  theme: {
    container: {
      center: true,
    },
    fontFamily: {
      default: ['IBM Plex Sans', 'sans-serif'],
    },
    extend: {
      colors: {
        primary: {
          '500': '#319795',
          '800': '#2C6A68',
        },
        "transparent-black": {
          '60': 'rgba(0, 0, 0, 0.6)'
        }
      },
      minWidth: {
        '0': '0',
        '3/4': '75%',
        '1/2': '50%',
        '1/4': '25%',
        '1/5': '20%',
        '1/6': '17%',
        'full': '100%',
        'sm': "15rem",
        'xs': "10rem",
      },
      maxWidth: {
        'xxs': '15rem'
      },
      inset: {
        '0': 0,
        'auto': 'auto',
        '1/4': '25%',
        '1/2': '50%',
        '3/5': '60%',
        '3/4': '75%',
      },
      zIndex: {
        '-10': '-10',
      },
      flex: {
        bottom: "1 0 auto",
      },
      height: {
        '14': "3.5rem",
      }
    }
  },
  variants: {},
  plugins: []
};
