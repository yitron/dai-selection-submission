# Module 00 - Test System

## Running Tests

### Quick Test (no API calls)
```bash
cd module-00
./tests/test_runner.sh
```

This will check:
- File structure
- Error handling
- Security (no hardcoded API keys)
- Code patterns

### Full Test (with API calls)
```bash
cd module-00
API_KEY=your_api_key ./tests/test_runner.sh
```

This runs all tests including actual API calls.

## Expected Output Format

Your program should produce output matching `expected_output_format.txt`:

```
[LLM Response]
<response text>
```

## Expected Error Messages

- **No argument**: See `expected_error_no_arg.txt`
- **No API key**: See `expected_error_no_key.txt`

## Manual Testing

Test these scenarios manually:

1. **Success case**:
   ```bash
   API_KEY=your_key python hello_llm.py "What is 2+2?"
   ```

2. **No argument**:
   ```bash
   python hello_llm.py
   ```

3. **No API key**:
   ```bash
   API_KEY="" python hello_llm.py "test"
   ```

## Diff Comparison

To compare your output with expected:

```bash
# Test error message
python hello_llm.py 2>&1 | diff - tests/expected_error_no_arg.txt

# Test output format (check header only)
API_KEY=your_key python hello_llm.py "Say hello" | head -n 1 | diff - <(echo "[LLM Response]")
```

## Pass Criteria

- ✅ All security checks pass
- ✅ Error handling works correctly
- ✅ Output format matches specification
- ✅ At least 70% of tests pass

## Debugging Failed Tests

If tests fail:

1. **Read the error message carefully**
2. **Check the expected output files** in this directory
3. **Run your program manually** with the same inputs
4. **Compare** your output to the expected output
5. **Fix** and re-run tests

## Test File Descriptions

- `test_runner.sh` - Main test script
- `expected_output_format.txt` - Template for output format
- `expected_error_no_arg.txt` - Expected error when no argument
- `expected_error_no_key.txt` - Expected error when API key missing
- `README.md` - This file

Good luck! 🚀
