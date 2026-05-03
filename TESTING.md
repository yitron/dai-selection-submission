# Automated Testing Guide

**Hybrid testing approach with graceful degradation**

---

## Overview

This project uses a **hybrid testing strategy** that combines:
1. **Bash-based validation** (works out-of-the-box, no dependencies)
2. **Node.js functional tests** (optional, enhanced testing if available)

The tests gracefully degrade - they'll run maximum possible tests with whatever tools are available.

---

## Quick Start

### Run All Tests
```bash
./test.sh
```

### Run Individual Prototype Tests
```bash
# Prototype 1
cd prototype-1-geocities-aidai && ./test.sh

# Prototype 2
cd prototype-2-lms-agents && ./test.sh
```

---

## Test Coverage

### Prototype 1: Geocities Revival (32+ checks)

#### File Existence (4 checks)
- ✓ index.html, style.css, script.js, README.md

#### HTML Validation (9 checks)
- ✓ HTML5 doctype
- ✓ Lang attribute
- ✓ Character encoding
- ✓ Viewport meta tag
- ✓ Semantic HTML tags (nav, main, footer)
- ✓ Single h1 tag (SEO best practice)
- ✓ No deprecated tags (marquee, blink, font)

#### CSS Validation (4+ checks)
- ✓ File not empty
- ✓ CSS animations defined
- ✓ Media queries present
- ✓ Syntax validation (if csslint available)

#### JavaScript Validation (5+ checks)
- ✓ File not empty
- ✓ Modern ES6+ syntax
- ✓ localStorage usage (hit counter)
- ✓ Error handling (try/catch)
- ✓ Syntax validation (if Node.js available)

#### Content Validation (3 checks)
- ✓ Hit counter element present
- ✓ Internal navigation links
- ✓ AI DAI program content

#### Accessibility (3+ checks)
- ✓ Alt attributes on images
- ✓ ARIA labels
- ✓ Skip link (recommended)

#### Link Validation
- ✓ All internal link targets exist

#### Functional Tests (if Node.js + Puppeteer)
- Browser automation testing
- Hit counter functionality
- Navigation interaction
- Console error detection

---

### Prototype 2: LMS Module (37+ checks)

#### File Existence (5 checks)
- ✓ index.html, style.css, script.js, lessons/lessons.js, README.md

#### HTML Validation (9 checks)
- ✓ HTML5 doctype
- ✓ Lang attribute
- ✓ Character encoding
- ✓ Viewport meta tag
- ✓ Semantic HTML tags (nav, main, aside)
- ✓ Single h1 tag
- ✓ Skip-to-content link

#### CSS Validation (5+ checks)
- ✓ File not empty
- ✓ CSS variables (modern practice)
- ✓ CSS Grid/Flexbox
- ✓ Media queries (responsive)
- ✓ Transitions/animations
- ✓ Syntax validation (if csslint available)

#### JavaScript Validation (7+ checks)
- ✓ Files not empty
- ✓ Modern ES6+ syntax
- ✓ localStorage usage
- ✓ State management
- ✓ Syntax validation for both files

#### Content Validation (4 checks)
- ✓ 3+ lessons present
- ✓ 2+ quizzes (per AGENTS.md requirement)
- ✓ 3+ diagrams (per AGENTS.md requirement)
- ✓ Glossary data present

#### Accessibility (4 checks)
- ✓ ARIA labels
- ✓ Navigation ARIA roles
- ✓ Keyboard navigation support
- ✓ Alt text on images (if any)

#### Responsive Design (3 checks)
- ✓ Mobile breakpoints (≤768px)
- ✓ Tablet breakpoints (optional)
- ✓ Flexible layout patterns

#### Functional Tests (if Node.js available)
- ✓ Lessons data validation
- ✓ Quiz count verification
- ✓ Diagram count verification
- ✓ Glossary data validation

#### Browser Tests (if Puppeteer available)
- Sidebar rendering
- Content area rendering
- Console error detection
- Interactive element testing

---

## Dependencies & Installation

### Zero Dependencies (Default)
Tests run out-of-the-box with:
- ✅ Bash shell (standard on macOS/Linux)
- ✅ grep, find, wc (standard utilities)
- ✅ Node.js (for syntax checking, probably already installed)

**Result:** ~70% of tests run automatically

### Enhanced Testing (Optional)

#### Install csslint (CSS validation)
```bash
npm install -g csslint
```
**Adds:** CSS syntax validation

#### Install Puppeteer (Browser automation)
```bash
npm install -g puppeteer
```
**Adds:** Full browser functional testing, screenshot testing, console error detection

**Result:** 100% of tests run with enhanced validation

---

## Test Output Format

### Color-Coded Results
- 🟢 **Green ✓** = Test passed
- 🔴 **Red ✗** = Test failed
- 🟡 **Yellow ⊘** = Test skipped (dependency not available)
- 🟡 **Yellow ℹ** = Informational message

### Example Output
```
==========================================
PROTOTYPE 1 - AUTOMATED TEST SUITE
==========================================

1. Checking Required Files...
-------------------------------------------
✓ index.html exists
✓ style.css exists
✓ script.js exists
✓ README.md exists

...

==========================================
TEST SUMMARY
==========================================

Passed:  32
Failed:  0
Skipped: 2

Success Rate: 100%

✓ All tests passed!
```

---

## Continuous Integration

These tests can run in CI/CD pipelines (GitHub Actions, GitLab CI, etc.):

### Example GitHub Actions Workflow
```yaml
name: Test Prototypes

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-node@v2
        with:
          node-version: '18'
      - name: Install optional dependencies
        run: npm install -g csslint puppeteer
      - name: Run tests
        run: ./test.sh
```

---

## Manual Testing Checklist

Automated tests cover most cases, but manual validation is still recommended:

### Prototype 1
- [ ] Open index.html in browser
- [ ] Verify all neon colors display correctly
- [ ] Test hit counter increments on page load
- [ ] Test navigation links scroll to correct sections
- [ ] Try Konami code easter egg (↑↑↓↓←→←→BA)
- [ ] Check animations (blink, glow, rainbow) work
- [ ] Test in Chrome, Firefox, Safari

### Prototype 2
- [ ] Open index.html in browser
- [ ] Navigate through all 3 lessons
- [ ] Complete quizzes on each lesson
- [ ] Verify correct/incorrect answer feedback
- [ ] Check progress tracking persists after refresh
- [ ] Open and close glossary panel
- [ ] Test responsive design (resize browser window)
- [ ] Test keyboard navigation (Tab through interface)
- [ ] Complete all lessons to see completion modal

---

## Troubleshooting

### Tests won't run
```bash
# Make sure test.sh is executable
chmod +x test.sh
chmod +x prototype-1-geocities-aidai/test.sh
chmod +x prototype-2-lms-agents/test.sh
```

### "Node.js not found"
- Tests will skip Node.js-dependent checks
- Install Node.js from https://nodejs.org if you want enhanced testing

### "Puppeteer not found"
- Tests will skip browser automation
- Install with: `npm install -g puppeteer`

### CSS/JS syntax errors
- Check the specific file mentioned in error output
- Run Node.js syntax check manually: `node -c script.js`

---

## Test Development

### Adding New Tests

To add a new test to a prototype:

1. Edit the appropriate test.sh file
2. Follow the pattern:
```bash
if [ condition ]; then
    pass "Test description"
else
    fail "Error message"
fi
```

3. Use skip() for optional tests:
```bash
if command -v tool &> /dev/null; then
    # Run test
else
    skip "Test name (tool not installed)"
fi
```

### Test Functions
- `pass(message)` - Mark test as passed (green ✓)
- `fail(message)` - Mark test as failed (red ✗)
- `skip(message)` - Mark test as skipped (yellow ⊘)
- `info(message)` - Display informational message (yellow ℹ)

---

## Performance

### Test Execution Time
- **Prototype 1:** ~2-5 seconds (basic tests)
- **Prototype 1:** ~10-15 seconds (with Puppeteer)
- **Prototype 2:** ~3-7 seconds (basic tests)
- **Prototype 2:** ~15-20 seconds (with Puppeteer)
- **Total:** ~5-40 seconds depending on available tools

---

## Test Philosophy

These tests follow the principle of **progressive enhancement**:

1. **Works everywhere** - Basic validation runs with zero dependencies
2. **Better with tools** - Enhanced validation if tools are installed
3. **Best with full suite** - Complete browser automation if Puppeteer available
4. **Never blocks** - Missing dependencies cause skips, not failures

This ensures the tests are useful in all environments:
- ✅ Local development (quick feedback)
- ✅ CI/CD pipelines (full validation)
- ✅ Review environments (no setup needed)
- ✅ Student machines (works with minimal tools)

---

## Contributing

When contributing, ensure:
1. All existing tests still pass
2. New features have corresponding tests
3. Tests follow the graceful degradation pattern
4. Test output is clear and actionable

---

**Questions?** See README.md or docs/WIKI.md for more information.
