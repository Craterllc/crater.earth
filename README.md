# crater.earth

The public website for Crater LLC (Brownsville, Texas). One static page: `index.html` + `assets/`.
Hosted free on Render (static site `crater.earth`, from `main` of the public repo Craterllc/crater.earth,
no build command, publish directory `./`). DNS at Squarespace Domains points crater.earth (A 216.24.57.1)
and www (CNAME crater-earth.onrender.com) there; www redirects to crater.earth. GitHub Pages is still on
but no longer serves the domain. Email DNS (MX/SPF/DKIM, Google Workspace) is separate — never change it.

- Preview: `python3 -m http.server 8765 --directory ~/Developer/CraterWebsite` → http://127.0.0.1:8765
- Screenshot: `swift tools/snapshot.swift http://127.0.0.1:8765/ previews/phone.png 390 dark`
- Publish: commit on `main`, `git push`, then check https://crater.earth. GitHub isn't connected to Render,
  so a push may also need Manual Deploy → Deploy latest commit in Render's dashboard.
- Render's free limit: 5 GB of traffic a month. Past that, the site can go offline until the next month.
- Keep the repo public: Render builds from the public URL, and email signatures load
  `assets/email/crater-signature-logo.png` from raw.githubusercontent.com.
- Content rules (Preston): low-key, factual; business is in Brownsville; no sales/wholesaler language;
  never say where Preston or Hughes live. The local `drafts` branch is old history: never push it.
