/** @type {import("prettier").Config} */
export default {
  arrowParens: 'avoid',
  semi: false,
  tabWidth: 2,
  printWidth: 80,
  singleQuote: true,
  jsxSingleQuote: false,
  trailingComma: 'es5',
  bracketSpacing: true,
  endOfLine: 'lf',
  plugins: ['prettier-plugin-astro', 'prettier-plugin-tailwindcss'],
  tailwindStylesheet: './src/styles/global.css',
  overrides: [
    {
      files: '*.astro',
      options: {
        parser: 'astro',
      },
    },
  ],
}
