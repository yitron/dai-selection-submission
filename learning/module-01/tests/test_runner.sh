#!/bin/bash
# Module 01 Test Runner
# Tests the agent_with_tool.py implementation

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

# Check if agent_with_tool.py exists
echo "========================================"
echo "Module 01 - Test Runner"
echo "========================================"
echo ""

if [ ! -f "agent_with_tool.py" ]; then
    echo -e "${RED}Error: agent_with_tool.py not found!${NC}"
    echo "Make sure you're running this from the module-01 directory"
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

# Test 1: Pydantic is imported and used
echo "Test 1: Pydantic usage"
if grep -q "from pydantic import\|import pydantic" agent_with_tool.py 2>/dev/null; then
    print_result "Imports Pydantic" 0
else
    print_result "Imports Pydantic" 1
fi

if grep -q "BaseModel\|pydantic.BaseModel" agent_with_tool.py 2>/dev/null; then
    print_result "Uses BaseModel" 0
else
    print_result "Uses BaseModel" 1
fi

if grep -q "Field" agent_with_tool.py 2>/dev/null; then
    print_result "Uses Field for descriptions" 0
else
    print_result "Uses Field for descriptions" 1
fi

# Test 2: Schema generation
echo ""
echo "Test 2: JSON Schema generation"
if grep -q "model_json_schema\|schema()" agent_with_tool.py 2>/dev/null; then
    print_result "Generates JSON schema from Pydantic" 0
else
    print_result "Generates JSON schema from Pydantic" 1
fi

# Test 3: Tool definition structure
echo ""
echo "Test 3: Tool definition"
if grep -q '"type".*"function"\|"function".*"name"' agent_with_tool.py 2>/dev/null; then
    print_result "Creates tool definition structure" 0
else
    print_result "Creates tool definition structure" 1
fi

# Test 4: Calculator function
echo ""
echo "Test 4: Calculator implementation"

# Test if Python code is syntactically valid
python3 -m py_compile agent_with_tool.py 2>/dev/null

if [ $? -eq 0 ]; then
    print_result "Code is syntactically valid" 0
else
    print_result "Code is syntactically valid" 1
fi

# Test 5: API tests (only if API_KEY is set)
if [ -n "$API_KEY" ]; then
    echo ""
    echo "Test 5: Tool execution with LLM"

    # Test addition
    output=$(timeout 60 python agent_with_tool.py "What is 25 + 17?" 2>&1)
    exit_code=$?

    if [ $exit_code -eq 0 ]; then
        print_result "Program runs without error" 0
    else
        print_result "Program runs without error" 1
        echo "  Exit code: $exit_code"
    fi

    # Test 6: Tool call detection
    echo ""
    echo "Test 6: Tool call detection and display"

    if echo "$output" | grep -q "\[Tool Call\]\|\[TOOL\]\|Tool:"; then
        print_result "Shows tool call information" 0
    else
        print_result "Shows tool call information" 1
    fi

    # Test 7: Correct result
    if echo "$output" | grep -q "42"; then
        print_result "Calculates correct result (25+17=42)" 0
    else
        print_result "Calculates correct result (25+17=42)" 1
    fi

    # Test 8: Final answer display
    if echo "$output" | grep -q "\[Final Answer\]\|\[Answer\]\|Answer:"; then
        print_result "Shows final answer section" 0
    else
        print_result "Shows final answer section" 1
    fi

    # Test 9: Different operations
    echo ""
    echo "Test 9: Different calculator operations"

    # Subtraction
    output_sub=$(timeout 60 python agent_with_tool.py "What is 50 minus 20?" 2>&1)
    if echo "$output_sub" | grep -q "30"; then
        print_result "Subtraction works (50-20=30)" 0
    else
        print_result "Subtraction works (50-20=30)" 1
    fi

    # Multiplication
    output_mul=$(timeout 60 python agent_with_tool.py "What is 6 times 7?" 2>&1)
    if echo "$output_mul" | grep -q "42"; then
        print_result "Multiplication works (6*7=42)" 0
    else
        print_result "Multiplication works (6*7=42)" 1
    fi

    # Division
    output_div=$(timeout 60 python agent_with_tool.py "What is 100 divided by 4?" 2>&1)
    if echo "$output_div" | grep -q "25"; then
        print_result "Division works (100/4=25)" 0
    else
        print_result "Division works (100/4=25)" 1
    fi

    # Test 10: Non-math question (should not call tool)
    echo ""
    echo "Test 10: Non-math questions"

    output_nomath=$(timeout 60 python agent_with_tool.py "What is the capital of France?" 2>&1)
    if ! echo "$output_nomath" | grep -q "\[Tool Call\]"; then
        print_result "Doesn't call tool for non-math questions" 0
    else
        print_result "Doesn't call tool for non-math questions" 1
    fi

else
    echo ""
    echo -e "${YELLOW}Skipping API tests (no API_KEY set)${NC}"
    echo "To run full tests: API_KEY=your_key ./tests/test_runner.sh"
fi

# Test security
echo ""
echo "Test 11: Security checks"

if grep -q "sk-[a-zA-Z0-9]\{20,\}" agent_with_tool.py 2>/dev/null; then
    print_result "No hardcoded API keys in code" 1
    echo -e "${RED}  WARNING: Found potential API key in code!${NC}"
else
    print_result "No hardcoded API keys in code" 0
fi

# Bonus tests (check if implemented)
echo ""
echo "Bonus Features (optional):"

# Check for multiple operations support
if grep -q "while.*tool_call\|for.*tool_call\|multiple.*tool" agent_with_tool.py 2>/dev/null; then
    echo -e "${GREEN}✓${NC} Multiple operations appears to be supported"
else
    echo -e "${YELLOW}○${NC} Multiple operations not found (bonus feature)"
fi

# Check for validators
if grep -q "@field_validator\|@validator" agent_with_tool.py 2>/dev/null; then
    echo -e "${GREEN}✓${NC} Pydantic validators implemented"
else
    echo -e "${YELLOW}○${NC} Pydantic validators not found (bonus feature)"
fi

# Check for additional tools
tool_count=$(grep -c "class.*Input(BaseModel)" agent_with_tool.py 2>/dev/null)
if [ "$tool_count" -gt 1 ] 2>/dev/null; then
    echo -e "${GREEN}✓${NC} Multiple tools implemented ($tool_count tools)"
else
    echo -e "${YELLOW}○${NC} Only one tool found (bonus: add more tools)"
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
