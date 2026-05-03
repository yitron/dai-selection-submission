# Module 01 - Test System

## Running Tests

### Quick Test (structure and imports)
```bash
cd module-01
./tests/test_runner.sh
```

This checks:
- Pydantic usage
- Code structure
- Tool definition
- Security

### Full Test (with API calls)
```bash
cd module-01
API_KEY=your_api_key ./tests/test_runner.sh
```

This runs all tests including:
- Actual tool execution
- Multiple operations
- LLM integration

## Expected Output Formats

### Math Question (with tool call)
See `expected_output_with_tool.txt`:
```
[Tool Call] calculator
Arguments: operation=add, a=25.0, b=17.0
Result: 42.0

[Final Answer]
The answer is 42.
```

### Non-Math Question (no tool call)
See `expected_output_no_tool.txt`:
```
[No Tool Call]

[Final Answer]
The capital of France is Paris.
```

## Manual Testing

### Test Tool Execution
```bash
# Addition
API_KEY=your_key python agent_with_tool.py "What is 25 + 17?"

# Subtraction
API_KEY=your_key python agent_with_tool.py "What is 50 - 20?"

# Multiplication
API_KEY=your_key python agent_with_tool.py "What is 6 times 7?"

# Division
API_KEY=your_key python agent_with_tool.py "What is 100 divided by 4?"
```

### Test No Tool Call
```bash
API_KEY=your_key python agent_with_tool.py "What is the capital of France?"
```

Should respond without calling the calculator tool.

## Testing Pydantic Model

Test your schema generation:
```bash
python3 << 'EOF'
from agent_with_tool import CalculatorInput
import json
print(json.dumps(CalculatorInput.model_json_schema(), indent=2))
EOF
```

Expected output should include:
```json
{
  "type": "object",
  "properties": {
    "operation": {
      "type": "string",
      "description": "..."
    },
    "a": {
      "type": "number",
      "description": "..."
    },
    "b": {
      "type": "number",
      "description": "..."
    }
  },
  "required": ["operation", "a", "b"]
}
```

## Diff Comparison

Compare your output format:

```bash
# Test math question
API_KEY=your_key python agent_with_tool.py "What is 25 + 17?" 2>&1 | \
  head -n 4 | \
  diff - <(head -n 4 tests/expected_output_with_tool.txt)
```

Should show no differences in the format (content may vary slightly).

## Pass Criteria

- ✅ Pydantic model correctly defined
- ✅ JSON schema generation works
- ✅ Tool sent in API request
- ✅ Tool calls detected and executed
- ✅ Results returned to LLM
- ✅ At least 70% of tests pass

## Common Issues

### Issue: "ModuleNotFoundError: No module named 'pydantic'"
**Fix**: Install dependencies
```bash
pip install pydantic requests
```

### Issue: Tool never called
**Fix**: Check that:
1. Tool definition is sent in API request under "tools" key
2. Model supports function calling (use gpt-4, gpt-3.5-turbo, llama-3.1+)

### Issue: "JSON decode error"
**Fix**: Parse arguments string
```python
import json
args_dict = json.loads(tool_call["function"]["arguments"])
```

### Issue: Validation error
**Fix**: Make sure types match Pydantic model
```python
# Use Pydantic to validate
args = CalculatorInput(**args_dict)
```

## Debugging

Enable verbose output:
```python
# Add debug prints
print(f"Tool calls: {response_json.get('choices', [{}])[0].get('message', {}).get('tool_calls')}")
```

## Bonus Testing

### Multiple Operations
```bash
API_KEY=your_key python agent_with_tool.py "What is 10 + 5 and then multiply by 2?"
```

Should show two tool calls.

### Validators
Modify code to send invalid operation and verify Pydantic catches it.

### Multiple Tools
Test with different tool types:
```bash
API_KEY=your_key python agent_with_tool.py "What is the current date?"
API_KEY=your_key python agent_with_tool.py "What is 5 + 5?"
```

---

Good luck! 🚀
