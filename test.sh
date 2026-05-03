#!/bin/bash

# Root Test Runner for DAI Selection Submission
# Executes automated validation for both prototypes

echo "=========================================="
echo "DAI SELECTION SUBMISSION - TEST SUITE"
echo "=========================================="
echo ""
echo "Running automated tests for both prototypes..."
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Track overall results
PROTOTYPE_1_RESULT=0
PROTOTYPE_2_RESULT=0

# Test Prototype 1
echo "=========================================="
echo "PROTOTYPE 1: Geocities Revival Homepage"
echo "=========================================="
echo ""

if [ -d "prototype-1-geocities-aidai" ]; then
    cd prototype-1-geocities-aidai

    if [ -f "test.sh" ]; then
        chmod +x test.sh
        if ./test.sh; then
            PROTOTYPE_1_RESULT=0
        else
            PROTOTYPE_1_RESULT=1
        fi
    else
        echo -e "${RED}❌ Error: test.sh not found in prototype-1-geocities-aidai/${NC}"
        PROTOTYPE_1_RESULT=1
    fi

    cd ..
else
    echo -e "${RED}❌ Error: prototype-1-geocities-aidai/ directory not found${NC}"
    PROTOTYPE_1_RESULT=1
fi

echo ""
echo ""

# Test Prototype 2
echo "=========================================="
echo "PROTOTYPE 2: LMS Module - How Agents Work"
echo "=========================================="
echo ""

if [ -d "prototype-2-lms-agents" ]; then
    cd prototype-2-lms-agents

    if [ -f "test.sh" ]; then
        chmod +x test.sh
        if ./test.sh; then
            PROTOTYPE_2_RESULT=0
        else
            PROTOTYPE_2_RESULT=1
        fi
    else
        echo -e "${RED}❌ Error: test.sh not found in prototype-2-lms-agents/${NC}"
        PROTOTYPE_2_RESULT=1
    fi

    cd ..
else
    echo -e "${RED}❌ Error: prototype-2-lms-agents/ directory not found${NC}"
    PROTOTYPE_2_RESULT=1
fi

echo ""
echo ""

# Overall Summary
echo "=========================================="
echo "OVERALL TEST SUMMARY"
echo "=========================================="
echo ""

if [ $PROTOTYPE_1_RESULT -eq 0 ]; then
    echo -e "${GREEN}✓${NC} Prototype 1: PASSED"
else
    echo -e "${RED}✗${NC} Prototype 1: FAILED"
fi

if [ $PROTOTYPE_2_RESULT -eq 0 ]; then
    echo -e "${GREEN}✓${NC} Prototype 2: PASSED"
else
    echo -e "${RED}✗${NC} Prototype 2: FAILED"
fi

echo ""
echo "=========================================="
echo ""

if [ $PROTOTYPE_1_RESULT -eq 0 ] && [ $PROTOTYPE_2_RESULT -eq 0 ]; then
    echo -e "${GREEN}🎉 All prototypes passed automated testing!${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. View prototypes in browser"
    echo "  2. Manual testing for visual/UX validation"
    echo "  3. Review documentation in docs/ folder"
    echo "  4. Commit changes to git"
    echo ""
    exit 0
else
    echo -e "${RED}⚠️  Some tests failed. Please review errors above.${NC}"
    echo ""
    echo "To run tests individually:"
    echo "  cd prototype-1-geocities-aidai && ./test.sh"
    echo "  cd prototype-2-lms-agents && ./test.sh"
    echo ""
    exit 1
fi
