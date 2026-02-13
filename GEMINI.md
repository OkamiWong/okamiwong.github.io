# User Input

## Misc
- Use pnpm

## Example blog post

src/data/blog/hello-world.md

```
---
author: Your Name
pubDatetime: 2026-02-12T10:00:00Z
title: Hello World
slug: hello-world
featured: false
draft: false
tags:
  - general
description: My very first post on this new blog.
---

Welcome to my new blog! This is a simple hello world post to get things started.

## How to write a post

1. Create a new `.md` file in `src/data/blog/`.
2. Add the required frontmatter (author, pubDatetime, title, etc.).
3. Write your content in Markdown.

Happy blogging!

## Image example

![Forest](@/assets/images/forrest-gump-quote.png)
```

# GEMINI.md - Project Context: AstroPaper

## Project Overview
**AstroPaper** is a minimal, responsive, accessible, and SEO-friendly Astro blog theme. It is built with **Astro**, **TypeScript**, and **Tailwind CSS**.

### Core Technologies
- **Framework:** [Astro](https://astro.build/) (v5.x)
- **Language:** [TypeScript](https://www.typescriptlang.org/)
- **Styling:** [Tailwind CSS](https://tailwindcss.com/) (v4.x)
- **Markdown Processing:** Remark & Rehype plugins (including `remark-math`, `rehype-katex` for LaTeX support).
- **Search:** [Pagefind](https://pagefind.app/) (static search)
- **Formatting & Linting:** Prettier, ESLint

## Project Structure
- `src/data/blog/`: Contains all blog post Markdown files.
- `src/pages/`: File-based routing for the application.
- `src/layouts/`: Base templates (e.g., `Layout.astro`, `PostDetails.astro`).
- `src/components/`: Reusable UI components.
- `src/config.ts`: Primary site configuration (`SITE` object).
- `src/constants.ts`: Social links and site-wide constants.
- `src/content.config.ts`: Zod-validated content collection schemas.
- `src/styles/`: Global styles (`global.css`) and typography overrides.
- `src/utils/`: Helper functions for OG image generation, sorting posts, and slugification.

## Building and Running
The project uses `pnpm` as the preferred package manager.

| Task | Command |
| :--- | :--- |
| **Development** | `pnpm run dev` |
| **Build** | `pnpm run build` (Runs `astro check`, `astro build`, and `pagefind`) |
| **Preview** | `pnpm run preview` |
| **Format** | `pnpm run format` |
| **Lint** | `pnpm run lint` |
| **Sync Types** | `pnpm run sync` |

## Development Conventions
- **Code Style:** Formatted with Prettier. Key rules:
  - Semicolons: `false`
  - Quotes: Single (`jsxSingleQuote: false`)
  - Indentation: 2 spaces
  - Line Length: 80 characters
  - Arrow Parens: `avoid`
  - Trailing Commas: `es5`
  - Line Endings: `lf`
  - Plugins: `prettier-plugin-astro`, `prettier-plugin-tailwindcss`
- **Content:** Blog posts are written in Markdown with a strict frontmatter schema defined in `src/content.config.ts`.
- **Styling:** Uses Tailwind CSS. Global variables and theme overrides are found in `src/styles/global.css`.
- **LaTeX:** Supported via `$...$` for inline and `$$...$$` for block equations. KaTeX CSS is loaded in `src/layouts/Layout.astro`.
- **Static Assets:** Images and icons should be placed in `src/assets/` or `public/`. Use Astro's `<Image />` component for optimization.
- **Search:** The search index is generated during the build process using Pagefind.

## Key Files for Configuration
- `src/config.ts`: Update `SITE.website`, `author`, `title`, and `desc` here.
- `src/constants.ts`: Manage social media links in the `SOCIALS` array.
- `astro.config.ts`: Configure Astro integrations (sitemap, markdown plugins).
