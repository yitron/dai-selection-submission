# Knowledge Map

**Visual representation of component relationships and dependencies**

---

## Repository Structure

```
dai-selection-submission/
├── docs/                           # Knowledge artifacts
│   ├── BUILD_LOG.md               # Chronological action log
│   ├── KNOWLEDGE_MAP.md           # This file - relationship graph
│   ├── AI_USAGE_TRACKER.md        # AI interaction details
│   └── WIKI.md                    # Final synthesis for submission
│
├── learning/                       # Source material (read-only)
│   ├── modules/                   # 9 scaffolded agent modules
│   └── html/                      # Enterprise architecture docs
│
├── prototype-1-geocities-aidai/   # Geocities homepage
│   ├── index.html                 # Entry point
│   ├── style.css                  # 90s aesthetic + animations
│   ├── script.js                  # Hit counter, interactions
│   ├── test.sh                    # Manual validation checklist
│   └── README.md                  # AI usage documentation
│
├── prototype-2-lms-agents/        # LMS module
│   ├── index.html                 # LMS shell
│   ├── style.css                  # Modern responsive layout
│   ├── script.js                  # SPA routing, quiz, progress
│   ├── lessons/
│   │   └── lessons.js             # Lesson data from /learning/
│   ├── test.sh                    # Manual validation checklist
│   └── README.md                  # AI usage + source documentation
│
├── test.sh                         # Root test orchestrator
├── README.md                       # Project overview
├── AGENTS.md                       # Requirements specification
└── LICENSE                         # MIT License
```

---

## Component Relationships

### Data Flow: Prototype 2

```
/learning/modules/
  └─> Module 00 (LLM API Communication)
  └─> Module 01 (Pydantic Pattern)
  └─> Module 02 (Conversational Memory)
       │
       ├─> EXTRACT CONTENT
       │
       ▼
  lessons/lessons.js
       │
       ├─> CONSUMED BY
       │
       ▼
  script.js (LMS navigation & rendering)
       │
       ├─> RENDERS TO
       │
       ▼
  index.html (DOM)
       │
       ├─> USER INTERACTIONS
       │
       ▼
  localStorage (progress, quiz scores, completion)
```

### Dependency Graph

```
AGENTS.md (spec)
  │
  ├──> Prototype 1 Requirements
  │      │
  │      └──> index.html
  │            ├──> style.css (visual)
  │            ├──> script.js (behavior)
  │            └──> localStorage (hit counter)
  │
  └──> Prototype 2 Requirements
         │
         ├──> /learning/ (source material)
         │      │
         │      └──> lessons.js (extracted data)
         │            │
         │            └──> script.js (consumes)
         │                  ├──> index.html (renders)
         │                  ├──> style.css (visual)
         │                  └──> localStorage (state)
         │
         └──> 3+ SVG/CSS diagrams (visual aids)
```

### Testing Hierarchy

```
./test.sh (root)
  │
  ├──> cd prototype-1-geocities-aidai && ./test.sh
  │      │
  │      └──> Manual checklist:
  │            - HTML validation (W3C)
  │            - CSS lint
  │            - JS syntax check
  │            - Visual inspection
  │            - Link validation
  │            - Accessibility audit
  │
  └──> cd prototype-2-lms-agents && ./test.sh
         │
         └──> Manual checklist:
               - HTML validation (W3C)
               - CSS lint
               - JS syntax check
               - Quiz logic validation
               - Navigation testing
               - Progress persistence
               - Diagram rendering
               - Accessibility audit
```

### Documentation Flow

```
Actions During Development
  │
  ├──> BUILD_LOG.md (chronological)
  │      │
  │      ├──> What was done
  │      ├──> Tools used
  │      ├──> Decisions made
  │      └──> Relationships discovered
  │
  ├──> AI_USAGE_TRACKER.md
  │      │
  │      ├──> Prompts given
  │      ├──> AI responses
  │      ├──> Code generated
  │      └──> Human modifications
  │
  └──> KNOWLEDGE_MAP.md (this file)
         │
         └──> Component relationships
               │
               ├──> Data flows
               ├──> Dependencies
               └──> Testing hierarchy
                     │
                     └──> SYNTHESIZE INTO
                           │
                           ▼
                        WIKI.md (final submission doc)
                           │
                           └──> Consumed by: Reviewers/Evaluators
```

---

## Cross-Cutting Concerns

### Accessibility
- **Applies to:** Both prototypes
- **Implementation:**
  - Semantic HTML5 tags
  - ARIA labels where needed
  - Keyboard navigation support
  - Color contrast compliance (WCAG AA)
  - Alt text for visual elements

### Responsiveness
- **Applies to:** Prototype 2 (Prototype 1 is intentionally fixed-width 90s style)
- **Implementation:**
  - CSS Grid/Flexbox layouts
  - Media queries for mobile
  - Touch-friendly interactions

### State Persistence
- **Technology:** localStorage (client-side)
- **Prototype 1:** Hit counter value
- **Prototype 2:** Progress, quiz scores, lesson completion, current lesson

### No Build Dependencies
- **Constraint:** Opens directly in browser (file:// or http://)
- **Impact:**
  - No npm/yarn
  - No transpilation (modern browsers only)
  - No module bundling
  - Inline or separate vanilla JS files only

---

## Key Interfaces

### Prototype 1: Hit Counter API
```javascript
// script.js exports (conceptual)
HitCounter {
  increment(): number
  get(): number
  store(value): void
  load(): number
}
```

### Prototype 2: LMS Core APIs
```javascript
// lessons.js exports
lessons[] = [
  {
    id: string,
    title: string,
    content: string (HTML),
    quiz: {
      questions: [],
      answers: []
    },
    diagram: string (SVG or CSS ID)
  }
]

// script.js exports (conceptual)
Navigation {
  goToLesson(id): void
  nextLesson(): void
  prevLesson(): void
}

ProgressTracker {
  markComplete(lessonId): void
  getProgress(): { completed: [], current: string }
  save(): void
  load(): void
}

QuizEngine {
  checkAnswer(questionId, answer): boolean
  calculateScore(): number
  recordScore(lessonId, score): void
}
```

---

## Future Extension Points

If the project were to grow beyond prototype phase:

1. **Prototype 1:** Add actual working links to AI tools, multi-page navigation
2. **Prototype 2:**
   - Add all 9 modules + enterprise HTML docs
   - Backend for persistent user accounts
   - Social features (peer discussions)
   - Code sandbox for trying agent patterns
   - Certificate generation on completion

---

## Glossary of Terms

- **TDD:** Test-Driven Development (RED → GREEN → REFACTOR)
- **SPA:** Single-Page Application (JS-driven navigation)
- **localStorage:** Browser API for client-side data persistence
- **Semantic HTML:** Using tags that convey meaning (nav, article, section vs div)
- **ARIA:** Accessible Rich Internet Applications (accessibility attributes)
- **WCAG:** Web Content Accessibility Guidelines
- **SVG:** Scalable Vector Graphics (XML-based images)
