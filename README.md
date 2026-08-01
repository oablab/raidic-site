# raidic-site

Marketing site for [Raidic](https://raidic.app) — a macOS AppleRAID admin app.

- GitHub Pages, custom domain `raidic.app` (CNAME file)
- i18n: root = English, full copies at `/zh/` (zh-Hant), `/ja/`, `/ko/`
  with hreflang alternates
- Language switcher persists to `localStorage("raidic-lang")`;
  root auto-redirects first-time visitors by browser language
  (`?lang=en` escape hatch)
- CJK font stacks: PingFang TC (zh), Hiragino Sans (ja),
  Apple SD Gothic Neo (ko)
- Steel-blue palette, light/dark via `prefers-color-scheme`
