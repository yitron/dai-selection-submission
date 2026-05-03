#!/bin/bash

# Prototype 1: Geocities Revival - Automated Test Suite
# Hybrid approach: Bash validation + optional Node.js testing

# set -e  # Exit on error for critical checks (disabled to see all errors)

echo "=========================================="
echo "PROTOTYPE 1 - AUTOMATED TEST SUITE"
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

if grep -q "<footer" index.html; then
    pass "Uses <footer> semantic tag"
else
    fail "Missing <footer> semantic tag"
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

# Check for deprecated tags
if grep -q "<marquee" index.html || grep -q "<blink" index.html || grep -q "<font" index.html; then
    fail "Found deprecated HTML tags (marquee/blink/font)"
else
    pass "No deprecated HTML tags found"
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
if grep -q ":root" style.css && grep -q "--" style.css; then
    pass "Uses CSS variables (modern practice)"
else
    info "Not using CSS variables (optional)"
fi

# Check for CSS animations
if grep -q "@keyframes" style.css; then
    pass "CSS animations defined"
else
    fail "No CSS animations found (expected for Geocities style)"
fi

# Check for responsive design
if grep -q "@media" style.css; then
    pass "Media queries present (responsive design)"
else
    info "No media queries (intentional for 90s style)"
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

# Check JS file is not empty
if [ -s "script.js" ]; then
    pass "script.js is not empty"
else
    fail "script.js is empty"
fi

# Check for ES6+ syntax
if grep -q "const\|let\|=>" script.js; then
    pass "Uses modern JavaScript (ES6+)"
else
    info "Uses older JavaScript syntax"
fi

# Check for localStorage usage
if grep -q "localStorage" script.js; then
    pass "Uses localStorage (hit counter requirement)"
else
    fail "No localStorage found (required for hit counter)"
fi

# Check for basic error handling
if grep -q "try\|catch" script.js; then
    pass "Has error handling (try/catch blocks)"
else
    info "No explicit error handling (may be acceptable)"
fi

# Basic JS syntax check with Node.js if available
if command -v node &> /dev/null; then
    if node -c script.js > /dev/null 2>&1; then
        pass "JavaScript syntax valid (Node.js check)"
    else
        fail "JavaScript syntax errors detected"
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

# Check for hit counter element
if grep -q "hitCounter\|hit-counter" index.html; then
    pass "Hit counter element present"
else
    fail "Hit counter element not found"
fi

# Check for navigation
if grep -q "href=\"#" index.html; then
    pass "Internal navigation links present"
else
    fail "No internal navigation links found"
fi

# Check for AI DAI content
if grep -qi "AI DAI\|AI Digital Agents" index.html; then
    pass "Contains AI DAI program content"
else
    fail "Missing AI DAI program content"
fi

echo ""

# ============================================
# 6. ACCESSIBILITY CHECKS
# ============================================

echo "6. Accessibility Checks..."
echo "-------------------------------------------"

# Check for alt attributes on images
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

# Check for ARIA labels
if grep -q "aria-label\|role=" index.html; then
    pass "Uses ARIA labels for accessibility"
else
    info "No ARIA labels found (may be acceptable for simple site)"
fi

# Check for skip link
if grep -q "skip-link\|skip-to-content" index.html; then
    pass "Skip-to-content link present"
else
    info "No skip link (recommended for accessibility)"
fi

echo ""

# ============================================
# 7. LINK VALIDATION
# ============================================

echo "7. Link Validation..."
echo "-------------------------------------------"

# Extract internal links and check if targets exist
internal_links=$(grep -o 'href="#[^"]*"' index.html | cut -d'"' -f2 | sort -u)
if [ -n "$internal_links" ]; then
    link_errors=0
    while IFS= read -r link; do
        target=${link#\#}
        if grep -q "id=\"$target\"" index.html; then
            pass "Internal link target exists: $link"
        else
            fail "Internal link target missing: $link"
            ((link_errors++))
        fi
    done <<< "$internal_links"

    if [ $link_errors -eq 0 ]; then
        pass "All internal links valid"
    fi
else
    info "No internal links to validate"
fi

echo ""

# ============================================
# 8. FUNCTIONAL TESTS (if Node.js available)
# ============================================

echo "8. Functional Tests..."
echo "-------------------------------------------"

if command -v node &> /dev/null && [ -d "node_modules/puppeteer" ] || command -v npx &> /dev/null; then
    info "Node.js detected - attempting browser automation tests..."

    # Create temporary test script
    cat > /tmp/test_prototype1.js << 'EOF'
const puppeteer = require('puppeteer');

(async () => {
    const browser = await puppeteer.launch({ headless: true });
    const page = await browser.newPage();

    try {
        // Load page
        await page.goto('file://' + process.cwd() + '/index.html', { waitUntil: 'networkidle0' });

        // Check hit counter exists
        const hitCounter = await page.$('#hitCounter');
        if (hitCounter) {
            console.log('✓ Hit counter element found');
        } else {
            console.log('✗ Hit counter element not found');
        }

        // Check navigation works
        const navLinks = await page.$$('nav a');
        console.log(`✓ Found ${navLinks.length} navigation links`);

        // Check for console errors
        page.on('console', msg => {
            if (msg.type() === 'error') {
                console.log('✗ Console error:', msg.text());
            }
        });

        await browser.close();
        process.exit(0);
    } catch (error) {
        console.log('✗ Browser test error:', error.message);
        await browser.close();
        process.exit(1);
    }
})();
EOF

    if node /tmp/test_prototype1.js 2>&1 | grep -q "Cannot find module 'puppeteer'"; then
        skip "Browser automation tests (Puppeteer not installed)"
        info "To enable: npm install -g puppeteer"
    elif node /tmp/test_prototype1.js 2>&1; then
        pass "Browser automation tests completed"
    else
        fail "Browser automation tests failed"
    fi

    rm -f /tmp/test_prototype1.js
else
    skip "Browser automation tests (Puppeteer not installed)"
    info "To enable: npm install -g puppeteer"
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
