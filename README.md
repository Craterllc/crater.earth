# crater.earth

The public website for Crater LLC (Brownsville, Texas). One static page: `index.html` + `assets/`.
Hosted free on GitHub Pages from `main` (repo Craterllc/crater.earth); DNS at Squarespace Domains
points crater.earth (4 A records) and www (CNAME craterllc.github.io) here. Email DNS (MX/SPF, Google
Workspace) is separate — never change it.

- Preview: `python3 -m http.server 8765 --directory ~/Developer/CraterWebsite` → http://127.0.0.1:8765
- Screenshot: `swift tools/snapshot.swift http://127.0.0.1:8765/ previews/phone.png 390 dark`
- Publish: commit on `main`, `git push` → live in about a minute.
- Content rules (Preston): low-key, factual; business is in Brownsville; no sales/wholesaler language;
  never say where Preston or Hughes live. The local `drafts` branch is old history: never push it.
