#!/bin/bash

# Prototype 2: LMS Module - Automated Test Suite
# Hybrid approach: Bash validation + optional Node.js testing

# set -e  # Exit on error for critical checks (disabled to see all errors)

echo "=========================================="
echo "PROTOTYPE 2 - AUTOMATED TEST SUITE"
echo "=========================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counters
PASSED=0
FAILED=0
SKIPPED=0

# Helper functions
pass() {
    echo -e "${GREEN}✓${NC} $1"
    ((PASSED++))
}

fail() {
    echo -e "${RED}✗${NC} $1"
    ((FAILED++))
}

skip() {
    echo -e "${YELLOW}⊘${NC} $1"
    ((SKIPPED++))
}

info() {
    echo -e "${YELLOW}ℹ${NC} $1"
}

# ============================================
# 1. FILE EXISTENCE CHECKS
# ============================================

echo "1. Checking Required Files..."
echo "-------------------------------------------"

if [ -f "index.html" ]; then
    pass "index.html exists"
else
    fail "index.html NOT FOUND"
    exit 1
fi

if [ -f "style.css" ]; then
    pass "style.css exists"
else
    fail "style.css NOT FOUND"
    exit 1
fi

if [ -f "script.js" ]; then
    pass "script.js exists"
else
    fail "script.js NOT FOUND"
    exit 1
fi

if [ -f "lessons/lessons.js" ]; then
    pass "lessons/lessons.js exists"
else
    fail "lessons/lessons.js NOT FOUND"
    exit 1
fi

if [ -f "README.md" ]; then
    pass "README.md exists"
else
    fail "README.md NOT FOUND"
fi

echo ""

# ============================================
# 2. HTML VALIDATION
# ============================================

echo "2. HTML Validation..."
echo "-------------------------------------------"

# Check for basic HTML structure
if grep -q "<!DOCTYPE html>" index.html; then
    pass "HTML5 doctype present"
else
    fail "Missing HTML5 doctype"
fi

if grep -q "<html lang=" index.html; then
    pass "HTML lang attribute present"
else
    fail "Missing HTML lang attribute"
fi

if grep -q "<meta charset=" index.html; then
    pass "Character encoding specified"
else
    fail "Missing character encoding"
fi

if grep -q "<meta name=\"viewport\"" index.html; then
    pass "Viewport meta tag present"
else
    fail "Missing viewport meta tag"
fi

# Check for semantic HTML
if grep -q "<nav" index.html; then
    pass "Uses <nav> semantic tag"
else
    fail "Missing <nav> semantic tag"
fi

if grep -q "<main" index.html; then
    pass "Uses <main> semantic tag"
else
    fail "Missing <main> semantic tag"
fi

if grep -q "<aside" index.html; then
    pass "Uses <aside> semantic tag"
else
    info "No <aside> tag (optional)"
fi

# Check heading hierarchy
if grep -q "<h1" index.html; then
    h1_count=$(grep -o "<h1" index.html | wc -l | tr -d ' ')
    if [ "$h1_count" -eq 1 ]; then
        pass "Exactly one <h1> tag (good practice)"
    else
        fail "Found $h1_count <h1> tags (should be exactly 1)"
    fi
else
    fail "No <h1> tag found"
fi

# Check for accessibility skip link
if grep -q "skip-link\|skip-to-content" index.html; then
    pass "Skip-to-content link present"
else
    info "No skip link (recommended for accessibility)"
fi

echo ""

# ============================================
# 3. CSS VALIDATION
# ============================================

echo "3. CSS Validation..."
echo "-------------------------------------------"

# Check CSS file is not empty
if [ -s "style.css" ]; then
    pass "style.css is not empty"
else
    fail "style.css is empty"
fi

# Check for CSS variables
if grep -q ":root" style.css; then
    if grep -q -- "--" style.css; then
        pass "Uses CSS variables (modern practice)"
    else
        fail "CSS :root found but no variables defined"
    fi
else
    fail "Not using CSS variables (expected for modern design)"
fi

# Check for CSS Grid/Flexbox
if grep -q "display: grid\|display: flex" style.css; then
    pass "Uses modern CSS layout (Grid/Flexbox)"
else
    fail "No CSS Grid or Flexbox found (expected for modern layout)"
fi

# Check for responsive design
if grep -q "@media" style.css; then
    pass "Media queries present (responsive design)"
else
    fail "No media queries (required for responsive LMS)"
fi

# Check for transitions/animations
if grep -q "transition\|animation" style.css; then
    pass "Uses CSS transitions/animations"
else
    info "No CSS transitions (optional)"
fi

# Basic CSS syntax check
if command -v csslint &> /dev/null; then
    if csslint --quiet style.css > /dev/null 2>&1; then
        pass "CSS syntax valid (csslint)"
    else
        fail "CSS syntax errors detected"
    fi
else
    skip "CSS validation (csslint not installed)"
fi

echo ""

# ============================================
# 4. JAVASCRIPT VALIDATION
# ============================================

echo "4. JavaScript Validation..."
echo "-------------------------------------------"

# Check JS files are not empty
if [ -s "script.js" ]; then
    pass "script.js is not empty"
else
    fail "script.js is empty"
fi

if [ -s "lessons/lessons.js" ]; then
    pass "lessons.js is not empty"
else
    fail "lessons.js is empty"
fi

# Check for ES6+ syntax
if grep -q "const\|let\|=>" script.js; then
    pass "Uses modern JavaScript (ES6+)"
else
    info "Uses older JavaScript syntax"
fi

# Check for localStorage usage
if grep -q "localStorage" script.js; then
    pass "Uses localStorage (progress tracking requirement)"
else
    fail "No localStorage found (required for progress tracking)"
fi

# Check for state management
if grep -q "state\|State" script.js; then
    pass "Has state management"
else
    info "No explicit state object (may be acceptable)"
fi

# Basic JS syntax check with Node.js if available
if command -v node &> /dev/null; then
    if node -c script.js > /dev/null 2>&1; then
        pass "script.js syntax valid (Node.js check)"
    else
        fail "script.js syntax errors detected"
    fi

    if node -c lessons/lessons.js > /dev/null 2>&1; then
        pass "lessons.js syntax valid (Node.js check)"
    else
        fail "lessons.js syntax errors detected"
    fi
else
    skip "JavaScript validation (Node.js not installed)"
fi

echo ""

# ============================================
# 5. CONTENT VALIDATION
# ============================================

echo "5. Content Validation..."
echo "-------------------------------------------"

# Check for lessons data
lesson_count=$(grep -o "id: 'lesson-" lessons/lessons.js | wc -l | tr -d ' ')
if [ "$lesson_count" -ge 3 ]; then
    pass "Has $lesson_count lessons (minimum 3 required)"
else
    fail "Only $lesson_count lessons found (need at least 3)"
fi

# Check for quiz content
quiz_count=$(grep -o "quiz:" lessons/lessons.js | wc -l | tr -d ' ')
if [ "$quiz_count" -ge 2 ]; then
    pass "Has $quiz_count quizzes (minimum 2 required per AGENTS.md)"
else
    fail "Only $quiz_count quizzes found (need at least 2)"
fi

# Check for diagram content
diagram_count=$(grep -o "diagram:" lessons/lessons.js | wc -l | tr -d ' ')
if [ "$diagram_count" -ge 3 ]; then
    pass "Has $diagram_count diagrams (minimum 3 required)"
else
    fail "Only $diagram_count diagrams found (need at least 3)"
fi

# Check for glossary
if grep -q "glossary\|Glossary" lessons/lessons.js; then
    pass "Glossary data present"
else
    fail "No glossary data found"
fi

echo ""

# ============================================
# 6. ACCESSIBILITY CHECKS
# ============================================

echo "6. Accessibility Checks..."
echo "-------------------------------------------"

# Check for ARIA labels
if grep -q "aria-label\|role=" index.html; then
    pass "Uses ARIA labels for accessibility"
else
    fail "No ARIA labels found (required for interactive LMS)"
fi

# Check for semantic structure in navigation
if grep -q "role=\"navigation\"" index.html; then
    pass "Navigation has proper ARIA role"
else
    info "Navigation missing ARIA role (recommended)"
fi

# Check for keyboard accessibility indicators
if grep -q "tabindex\|:focus" style.css; then
    pass "Has keyboard navigation support"
else
    fail "No keyboard navigation indicators found"
fi

# Check for alt attributes on images (if any)
img_count=$(grep -o "<img " index.html | wc -l | tr -d ' ')
if [ "$img_count" -gt 0 ]; then
    alt_count=$(grep -o "alt=\"" index.html | wc -l | tr -d ' ')
    if [ "$img_count" -eq "$alt_count" ]; then
        pass "All images have alt attributes ($img_count/$img_count)"
    else
        fail "Some images missing alt attributes ($alt_count/$img_count)"
    fi
else
    pass "No images requiring alt text"
fi

echo ""

# ============================================
# 7. RESPONSIVE DESIGN CHECKS
# ============================================

echo "7. Responsive Design Checks..."
echo "-------------------------------------------"

# Check for mobile breakpoints
if grep -q "max-width.*768px\|max-width.*640px" style.css; then
    pass "Has mobile breakpoints (768px or smaller)"
else
    fail "Missing mobile breakpoints (required for responsive design)"
fi

# Check for tablet breakpoints
if grep -q "max-width.*1024px" style.css; then
    pass "Has tablet breakpoints (1024px)"
else
    info "No tablet-specific breakpoints (optional)"
fi

# Check for flexible layouts
if grep -q "flex-wrap\|grid-template-columns.*auto" style.css; then
    pass "Uses flexible layout patterns"
else
    info "Layout may not be fully responsive"
fi

echo ""

# ============================================
# 8. FUNCTIONAL TESTS (if Node.js available)
# ============================================

echo "8. Functional Tests..."
echo "-------------------------------------------"

if command -v node &> /dev/null; then
    info "Node.js detected - running functional tests..."

    # Test 1: Check lessons.js exports data correctly
    cat > /tmp/test_lessons.js << 'EOF'
const fs = require('fs');
const vm = require('vm');

try {
    const lessonsCode = fs.readFileSync('lessons/lessons.js', 'utf8');
    const context = { window: {}, console };
    vm.runInNewContext(lessonsCode, context);

    if (context.window.lessonsData && Array.isArray(context.window.lessonsData)) {
        const lessonCount = context.window.lessonsData.length;
        console.log(`✓ Lessons data loaded: ${lessonCount} lessons`);

        // Check quiz count
        const quizCount = context.window.lessonsData.filter(l => l.quiz).length;
        if (quizCount >= 2) {
            console.log(`✓ Quiz validation: ${quizCount} lessons have quizzes (≥2 required)`);
        } else {
            console.log(`✗ Quiz validation: Only ${quizCount} lessons have quizzes (need ≥2)`);
            process.exit(1);
        }

        // Check diagram count
        const diagramCount = context.window.lessonsData.filter(l => l.diagram).length;
        if (diagramCount >= 3) {
            console.log(`✓ Diagram validation: ${diagramCount} lessons have diagrams (≥3 required)`);
        } else {
            console.log(`✗ Diagram validation: Only ${diagramCount} lessons have diagrams (need ≥3)`);
            process.exit(1);
        }

        // Check glossary
        if (context.window.glossaryData && Array.isArray(context.window.glossaryData)) {
            console.log(`✓ Glossary loaded: ${context.window.glossaryData.length} terms`);
        } else {
            console.log('✗ Glossary data not found');
            process.exit(1);
        }

        process.exit(0);
    } else {
        console.log('✗ Lessons data not properly exported');
        process.exit(1);
    }
} catch (error) {
    console.log('✗ Error loading lessons.js:', error.message);
    process.exit(1);
}
EOF

    if node /tmp/test_lessons.js 2>&1; then
        pass "Lessons data validation completed"
    else
        fail "Lessons data validation failed"
    fi

    rm -f /tmp/test_lessons.js

    # Test 2: Browser automation if Puppeteer available
    if [ -d "node_modules/puppeteer" ] || command -v npx &> /dev/null; then
        cat > /tmp/test_prototype2.js << 'EOF'
const puppeteer = require('puppeteer');

(async () => {
    const browser = await puppeteer.launch({ headless: true });
    const page = await browser.newPage();

    try {
        // Load page
        await page.goto('file://' + process.cwd() + '/index.html', { waitUntil: 'networkidle0', timeout: 10000 });

        // Check sidebar exists
        const sidebar = await page.$('.sidebar');
        if (sidebar) {
            console.log('✓ Sidebar element found');
        } else {
            console.log('✗ Sidebar element not found');
        }

        // Check lesson content area
        const content = await page.$('#lessonContent');
        if (content) {
            console.log('✓ Lesson content area found');
        } else {
            console.log('✗ Lesson content area not found');
        }

        // Check for console errors
        const errors = [];
        page.on('console', msg => {
            if (msg.type() === 'error') {
                errors.push(msg.text());
            }
        });

        await page.waitForTimeout(2000);

        if (errors.length === 0) {
            console.log('✓ No console errors detected');
        } else {
            console.log('✗ Console errors:', errors.join(', '));
        }

        await browser.close();
        process.exit(0);
    } catch (error) {
        console.log('✗ Browser test error:', error.message);
        await browser.close();
        process.exit(1);
    }
})();
EOF

        if node /tmp/test_prototype2.js 2>&1 | grep -q "Cannot find module 'puppeteer'"; then
            skip "Browser automation tests (Puppeteer not installed)"
            info "To enable: npm install -g puppeteer"
        elif node /tmp/test_prototype2.js 2>&1; then
            pass "Browser automation tests completed"
        else
            fail "Browser automation tests failed"
        fi

        rm -f /tmp/test_prototype2.js
    else
        skip "Browser automation tests (Puppeteer not installed)"
        info "To enable: npm install -g puppeteer"
    fi
else
    skip "Functional tests (Node.js not installed)"
    info "To enable: Install Node.js from https://nodejs.org"
fi

echo ""

# ============================================
# TEST SUMMARY
# ============================================

echo "=========================================="
echo "TEST SUMMARY"
echo "=========================================="
echo ""
echo -e "${GREEN}Passed:${NC}  $PASSED"
echo -e "${RED}Failed:${NC}  $FAILED"
echo -e "${YELLOW}Skipped:${NC} $SKIPPED"
echo ""

TOTAL=$((PASSED + FAILED))
if [ $TOTAL -gt 0 ]; then
    PERCENTAGE=$((PASSED * 100 / TOTAL))
    echo "Success Rate: $PERCENTAGE%"
    echo ""
fi

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}✗ Some tests failed. Please review errors above.${NC}"
    exit 1
fi
