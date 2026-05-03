AGENTS.md — B1 AI DAI Facilitator Selection Prototypes
Context
You are building two prototypes for a facilitator trainee selection process under the AI DAI – B1 initiative (DLCC). The role is a facilitator, not a developer — the projects must demonstrate:

Effective, intentional use of AI tools
Relevance to non-technical SME and public/private sector users
Clean, explainable code with documented AI usage
Submission-ready GitHub repositories

All projects use Vanilla HTML/CSS/JS (no frameworks). Each prototype lives in its own folder with its own README.md explaining AI usage.


Prototype 1 — Geocities Revival: AI DAI Homepage
Folder
/prototype-1-geocities-aidai/
Concept
A fully faithful Geocities-era aesthetic (circa 1996–2002) recreated with a modern vanilla tech stack — applied to the AI DAI program's homepage. The joke is intentional: cutting-edge AI content wrapped in the internet's most chaotic design era. This contrast is the creative statement.
Visual Design Rules (follow strictly)
Aesthetic: Authentic Geocities — tiled backgrounds, neon text on dark backgrounds, animated GIFs (use CSS animations to simulate), marquee text (use CSS scroll animation, NOT the deprecated <marquee> tag), beveled HR dividers, counter widgets, "Under Construction" banners, visitor counters, blinking text (CSS animation: blink), comic sans or courier as body fonts
Color palette: Dark navy or black background, neon yellow/lime/hot pink/cyan accents, white body text
Layout: Table-based layout aesthetic (use CSS Grid/Flexbox to mimic table layouts — do NOT use actual HTML tables for layout)
Typography: 'Courier New' or 'Comic Sans MS' with web-safe fallbacks. Use Google Fonts 'Press Start 2P' for headings to get pixel-era feel
Decorative elements: Star dividers (★ ★ ★), emoji used liberally, fake "Best viewed in Netscape Navigator 4.0" badge, a fake hit counter (hardcoded number like 004,217), animated stars in the background (CSS keyframes), a "WELCOME TO MY PAGE" animated banner
Animations: CSS-only. Blinking cursor, scrolling marquee text, pulsing glow on headings, star twinkle in background
NO modern minimalism. NO clean whitespace. NO sans-serif system fonts. Controlled chaos is the goal.
Content to include (all AI DAI program info)
Structure the page with these sections, in classic Geocities single-scroll format:

Hero Banner — ★ WELCOME TO THE AI DAI HOMEPAGE ★ in blinking neon, with a fake animated GIF border (CSS shimmer)
About Section — What is AI DAI / B1 / DLCC. 2–3 short paragraphs in retro style
What We Do — Bullet list of the program goals (AI-assisted solutions for SMEs, public/private sector)
The Facilitator Role — Explain the guide-not-developer philosophy, prompting, vibe coding, using AI tools
Our Tools — A "My Favourite Links" style section listing AI tools (ChatGPT, Claude, etc.) with fake 88x31px badge buttons (CSS-drawn)
Join Us / Contact — Fake guestbook section and official channel redirect message
Footer — Hit counter, "Last updated: 1997", best viewed in Netscape badge, copyright notice
File Structure
prototype-1-geocities-aidai/

├── index.html

├── style.css

├── script.js          # hit counter increment, any minor JS interactions

└── README.md
README.md must include
What the project is
How AI was used to build it (prompting strategy, what you asked the AI to generate, how you iterated)
What a facilitator can learn from this prototype about using AI creatively


Prototype 2 — LMS Module: How Agents Work
Folder
/prototype-2-lms-agents/
Concept
An interactive learning module that teaches non-technical learners how AI agents work — drawing directly from the architecture documented in your /learning/ directory. The LMS is self-contained in a single HTML file with CSS and JS inline or in companion files. It should feel like a clean, professional e-learning module.
Source Material
Read everything inside /learning/ before building. That directory contains documentation on the agent architecture components. Use it as the source of truth for all learning content. Do not invent agent concepts — derive them from those docs.
Design Rules
Aesthetic: Clean, professional, modern — but NOT generic. Pick a strong accent color (deep teal, electric indigo, or amber) against a near-white or soft dark background. Use 'DM Sans' or 'Instrument Sans' from Google Fonts for body, and 'Syne' or 'Space Mono' for headings/labels
Layout: Single-page app feel. Fixed left sidebar for module navigation, main content area on the right
NO frameworks — pure HTML/CSS/JS only
Responsive: Must work on desktop and tablet
LMS Features to Build
1. Module Navigation (Sidebar)
List of lessons derived from /learning/ docs
Active state highlighting
Progress tracker (e.g. 3 / 7 lessons complete) stored in localStorage
Checkmark on completed lessons
2. Lesson View (Main Content Area)
Each lesson must have:

Title + estimated read time
Concept explanation (prose, derived from /learning/ docs)
Visual diagram — use SVG or CSS-drawn diagrams to illustrate agent components (e.g. memory, tools, planner, executor loop). At least 3 lessons must have a diagram
Key Takeaway box (styled callout at the bottom)
"Mark as Complete" button that updates the sidebar progress
3. Knowledge Check (Quiz)
At least 2 lessons must end with a 2–3 question multiple choice quiz
Show correct/incorrect feedback inline (no page reload)
Track quiz score in localStorage
4. Summary / Completion Screen
Shown when all lessons are marked complete
Displays score, time taken, and a "What's Next" section pointing to real AI tools or next steps
5. Glossary Panel
Slide-out or modal panel accessible from any lesson
Lists key terms from the agent architecture docs with plain-English definitions
File Structure
prototype-2-lms-agents/

├── index.html

├── style.css

├── script.js          # navigation, progress tracking, quiz logic, localStorage

├── lessons/           # optional: one .js or .json file per lesson if you separate content

│   ├── lessons.js     # lesson content as a JS array/object — derive from /learning/ docs

└── README.md
README.md must include
What the project teaches and who it's for
How the /learning/ docs were used as source material
How AI was used in the build process (what was prompted, how content was structured)
How this module reflects the facilitator role (teaching non-technical users about agents)


Repository Structure (Final GitHub Submission)
/

├── AGENTS.md                        ← this file

├── prototype-1-geocities-aidai/

│   ├── index.html

│   ├── style.css

│   ├── script.js

│   └── README.md

├── prototype-2-lms-agents/

│   ├── index.html

│   ├── style.css

│   ├── script.js

│   ├── lessons/

│   │   └── lessons.js

│   └── README.md

└── README.md                        ← root repo overview
Root README.md must include
Your name and role applied for (B1 AI DAI Facilitator Trainee)
Brief description of both prototypes
How to run each prototype (open index.html in browser — no build step)
Reflection: what these projects demonstrate about your approach to AI-assisted work


General Build Rules
No build tools — no npm, no webpack, no bundlers. Everything must open with index.html in a browser
External CDNs allowed — Google Fonts, cdnjs only
No API keys — both prototypes must run fully offline/static
AI usage must be real and documented — the README explanations are part of the submission criteria
Accessibility baseline — semantic HTML, sufficient color contrast, keyboard-navigable where possible
Comments in code — leave meaningful comments explaining non-obvious sections


What the Selection Panel is Evaluating
Criteria
What to show
AI tool usage
Document every prompt, iteration, and decision in README
Facilitator mindset
Content and UX should help non-technical users, not show off dev skill
Creativity
Prototype 1 should be bold and memorable
Practicality
Prototype 2 should be immediately useful to real learners
Professionalism
Clean repo, good READMEs, working code
