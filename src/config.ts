export const SITE = {
  website: 'https://okamiwong.github.io/', // replace this with your deployed domain
  author: 'Okami Wong',
  profile: 'https://github.com/OkamiWong',
  desc: "Okami's Blog",
  title: "Okami's Blog",
  ogImage: '',
  lightAndDarkMode: false,
  postPerIndex: 4,
  postPerPage: 4,
  scheduledPostMargin: 15 * 60 * 1000, // 15 minutes
  showArchives: true,
  showBackButton: true, // show back button in post detail
  editPost: {
    enabled: false,
    text: 'Edit page',
    url: 'https://github.com/satnaing/astro-paper/edit/main/',
  },
  dynamicOgImage: true,
  dir: 'ltr', // "rtl" | "auto"
  lang: 'en', // html lang code. Set this empty and default will be "en"
  timezone: 'UTC', // Default global timezone (IANA format) https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
} as const
