#!/bin/bash
# Module 00 Test Runner
# Tests the hello_llm.py implementation

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counter
PASSED=0
FAILED=0
TOTAL=0

# Function to print test result
print_result() {
    local test_name=$1
    local result=$2
    TOTAL=$((TOTAL + 1))

    if [ "$result" -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $test_name"
        PASSED=$((PASSED + 1))
    else
        echo -e "${RED}✗${NC} $test_name"
        FAILED=$((FAILED + 1))
    fi
}

# Check if hello_llm.py exists
echo "========================================"
echo "Module 00 - Test Runner"
echo "========================================"
echo ""

if [ ! -f "hello_llm.py" ]; then
    echo -e "${RED}Error: hello_llm.py not found!${NC}"
    echo "Make sure you're running this from the module-00 directory"
    exit 1
fi

# Check if API key is set
if [ -z "$API_KEY" ]; then
    echo -e "${YELLOW}Warning: API_KEY not set${NC}"
    echo "Some tests will be skipped"
    echo "Set API_KEY environment variable to run all tests"
    echo ""
fi

echo "Running tests..."
echo ""

# Test 1: Program exists and is executable
echo "Test 1: File structure"
python -c "import sys; sys.exit(0)" 2>/dev/null
print_result "Python is available" $?

# Test 2: No argument handling
echo ""
echo "Test 2: No argument handling"
output=$(python hello_llm.py 2>&1)
exit_code=$?

if [ $exit_code -ne 0 ] && echo "$output" | grep -qi "error\|usage"; then
    print_result "Shows error when no argument provided" 0
else
    print_result "Shows error when no argument provided" 1
fi

# Test 3: Check for hardcoded API keys (security check)
echo ""
echo "Test 3: Security checks"
if grep -q "sk-[a-zA-Z0-9]\{20,\}" hello_llm.py 2>/dev/null; then
    print_result "No hardcoded API keys in code" 1
    echo -e "${RED}  WARNING: Found potential API key in code!${NC}"
else
    print_result "No hardcoded API keys in code" 0
fi

# Test 4: Uses environment variable for API key
if grep -q "os.getenv\|os.environ" hello_llm.py 2>/dev/null; then
    print_result "Uses environment variable for API key" 0
else
    print_result "Uses environment variable for API key" 1
fi

# Test 5-8: API call tests (only if API_KEY is set)
if [ -n "$API_KEY" ]; then
    echo ""
    echo "Test 5: Simple API call"

    output=$(timeout 30 python hello_llm.py "Say exactly: Test123" 2>&1)
    exit_code=$?

    if [ $exit_code -eq 0 ]; then
        print_result "Program runs without error" 0
    else
        print_result "Program runs without error" 1
        echo "  Exit code: $exit_code"
    fi

    # Test 6: Output format
    echo ""
    echo "Test 6: Output format"

    if echo "$output" | grep -q "\[LLM Response\]"; then
        print_result "Contains [LLM Response] header" 0
    else
        print_result "Contains [LLM Response] header" 1
    fi

    # Test 7: Response content
    if echo "$output" | grep -qi "test123"; then
        print_result "Contains expected response content" 0
    else
        print_result "Contains expected response content" 1
    fi

    # Test 8: No JSON in output
    if echo "$output" | grep -q '"choices"\|"message"\|{.*}'; then
        print_result "Output is clean (no raw JSON)" 1
    else
        print_result "Output is clean (no raw JSON)" 0
    fi

    # Test 9: Different question
    echo ""
    echo "Test 9: Multiple questions work"
    output2=$(timeout 30 python hello_llm.py "What is 2+2?" 2>&1)
    exit_code=$?

    if [ $exit_code -eq 0 ] && echo "$output2" | grep -q "[LLM Response]"; then
        print_result "Can answer different questions" 0
    else
        print_result "Can answer different questions" 1
    fi

else
    echo ""
    echo -e "${YELLOW}Skipping API tests (no API_KEY set)${NC}"
    echo "To run full tests: API_KEY=your_key ./tests/test_runner.sh"
fi

# Bonus tests (check if implemented)
echo ""
echo "Bonus Features (optional):"

# Check for token counting
if grep -q "token\|usage" hello_llm.py 2>/dev/null; then
    echo -e "${GREEN}✓${NC} Token counting appears to be implemented"
else
    echo -e "${YELLOW}○${NC} Token counting not found (bonus feature)"
fi

# Check for streaming
if grep -q "stream" hello_llm.py 2>/dev/null; then
    echo -e "${GREEN}✓${NC} Streaming appears to be implemented"
else
    echo -e "${YELLOW}○${NC} Streaming not found (bonus feature)"
fi

# Check for multi-turn
if grep -q "while\|for.*input\|conversation" hello_llm.py 2>/dev/null; then
    echo -e "${GREEN}✓${NC} Multi-turn conversation appears to be implemented"
else
    echo -e "${YELLOW}○${NC} Multi-turn not found (bonus feature)"
fi

# Summary
echo ""
echo "========================================"
echo "Test Summary"
echo "========================================"
echo -e "Passed: ${GREEN}$PASSED${NC} / $TOTAL"
echo -e "Failed: ${RED}$FAILED${NC} / $TOTAL"

if [ $TOTAL -gt 0 ]; then
    PERCENTAGE=$((PASSED * 100 / TOTAL))
    echo "Success Rate: $PERCENTAGE%"
fi

echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}All tests passed! ✓${NC}"
    exit 0
elif [ $PASSED -ge $((TOTAL * 70 / 100)) ]; then
    echo -e "${YELLOW}Passed (≥70%)${NC}"
    exit 0
else
    echo -e "${RED}Failed (<70%)${NC}"
    exit 1
fi
