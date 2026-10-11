# Changelog

All notable changes to this project are documented here.
The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [1.0.0] — 2026-10-11

### Added
- Responsive shell: a bottom bar carrying the website's seven top-nav items on phones, and a website-style
  top nav on windows ≥ 900 px.
- One section per screen, adapted from the public SideKix site: hero + keyword band (Home), "Three moves"
  (How it works), pricing tiers with a monthly/yearly toggle (Membership), flip cards (Advisors),
  affiliate/partner/sponsor tracks (Partners), browse-by-state events (Events) and a filterable resource
  grid (Resources).
- **Kix AI chat** — streaming replies, a "listen first" clarifying question, an inline Journey Map whose
  steps can be ticked off, and advisor suggestions. Floats over every screen; a full-screen page on phones
  and a floating panel on desktop.
- Clean Architecture (domain / data / presentation) with BLoC + Cubit, GetIt + injectable, Freezed and fpdart.
- Unit, bloc and responsive widget tests (including overflow checks at phone, tablet and desktop widths).
- Autonomously recorded iOS demo and a 20-shot iOS screenshot set (every screen, its interactive states, and each stage of a Kix conversation), driven by `integration_test`.
