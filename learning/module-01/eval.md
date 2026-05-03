# Module 01 - Evaluation Sheet

## Student Information
- **Evaluator**: ___________________________
- **Student**: ___________________________
- **Date**: ___________________________
- **Start Time**: ___________________________
- **End Time**: ___________________________

---

## Preliminary Checks (If any fail, evaluation stops)

- [ ] Files present: `agent_with_tool.py`, `requirements.txt`
- [ ] Student can explain what a "tool" is in agent programming
- [ ] Student can explain why Pydantic is used for tools
- [ ] Student has a valid API key ready for testing

**If any preliminary check fails, stop here. Grade: 0/100**

---

## Mandatory Part (100 points)

### 1. Pydantic Model Definition (20 points)

Ask the student to show their Pydantic model for the calculator tool.

**Check for:**
```python
class CalculatorInput(BaseModel):
    operation: str = Field(description="...")
    a: float = Field(description="...")
    b: float = Field(description="...")
```

**Evaluation:**
- [ ] (5 pts) Uses `BaseModel` from Pydantic
- [ ] (5 pts) Has correct fields: operation, a, b
- [ ] (5 pts) Uses `Field()` with descriptions
- [ ] (5 pts) Correct types (str for operation, float for numbers)

**Score: ___ / 20**

**Notes:**
```



```

---

### 2. JSON Schema Generation (15 points)

Ask: "How do you convert your Pydantic model to JSON schema?"

Expected answer should mention: `model_json_schema()`

**Test:**
```python
python -c "from agent_with_tool import CalculatorInput; print(CalculatorInput.model_json_schema())"
```

**Evaluation:**
- [ ] (5 pts) Uses `model_json_schema()` method
- [ ] (5 pts) Schema includes all fields
- [ ] (5 pts) Schema includes descriptions

**Score: ___ / 15**

**Notes:**
```



```

---

### 3. Tool Definition in API Request (15 points)

Check that tools are sent in the API request:

```python
data = {
    "model": "...",
    "messages": [...],
    "tools": [tool_definition]  # Must be here
}
```

**Evaluation:**
- [ ] (5 pts) Tool definition created in correct format
- [ ] (5 pts) Tool includes "type": "function"
- [ ] (5 pts) Tool sent in API request under "tools" key

**Score: ___ / 15**

**Notes:**
```



```

---

### 4. Tool Call Detection (15 points)

Test with a math question:
```bash
python agent_with_tool.py "What is 15 + 27?"
```

Verify the program detects when LLM wants to call the tool.

**Evaluation:**
- [ ] (5 pts) Checks for "tool_calls" in response
- [ ] (5 pts) Extracts function name
- [ ] (5 pts) Extracts function arguments

**Score: ___ / 15**

**Output observed:**
```



```

---

### 5. Tool Execution (20 points)

Verify the tool is executed correctly:

```bash
# Test addition
python agent_with_tool.py "What is 10 + 5?"

# Test subtraction
python agent_with_tool.py "What is 20 - 8?"

# Test multiplication
python agent_with_tool.py "What is 6 times 7?"

# Test division
python agent_with_tool.py "What is 100 divided by 4?"
```

**Evaluation:**
- [ ] (5 pts) Parses arguments JSON string
- [ ] (5 pts) Validates arguments with Pydantic model
- [ ] (5 pts) Calls calculator function
- [ ] (5 pts) Returns correct result

**Score: ___ / 20**

**Test Results:**
```
Addition: ___________
Subtraction: ___________
Multiplication: ___________
Division: ___________
```

---

### 6. Result Sent Back to LLM (15 points)

Verify that tool results are sent back to the LLM in the correct format:

```python
{
    "role": "tool",
    "tool_call_id": "...",
    "content": "result"
}
```

**Evaluation:**
- [ ] (5 pts) Creates tool result message
- [ ] (5 pts) Includes correct tool_call_id
- [ ] (5 pts) Sends updated message history to LLM

**Score: ___ / 15**

**Notes:**
```



```

---

## Mandatory Part Total: ___ / 100

**Pass threshold: 70/100**

---

## Bonus Part (45 points max)

### Bonus 1: Multiple Operations (15 points)

Test:
```bash
python agent_with_tool.py "What is 5 + 3 and then multiply by 2?"
```

**Evaluation:**
- [ ] (5 pts) Handles multiple tool calls
- [ ] (5 pts) Executes in correct order
- [ ] (5 pts) Final answer uses both results

**Score: ___ / 15**

---

### Bonus 2: Input Validation (10 points)

Check for Pydantic validators:

```python
@field_validator('operation')
def validate_operation(cls, v):
    # validation logic
```

**Test invalid input:**
```bash
# Manually modify code to send invalid operation
```

**Evaluation:**
- [ ] (5 pts) Uses `@field_validator`
- [ ] (5 pts) Validates operation is in allowed list

**Score: ___ / 10**

---

### Bonus 3: Additional Tools (20 points)

Check if student implemented another tool (e.g., get_date, weather, etc.)

**Evaluation:**
- [ ] (5 pts) Second Pydantic model defined
- [ ] (5 pts) Second tool function implemented
- [ ] (5 pts) Both tools sent to LLM
- [ ] (5 pts) Program can use either tool based on question

**Test:**
```bash
# Test both tools work
```

**Score: ___ / 20**

---

## Bonus Total: ___ / 45

---

## Final Score Calculation

- **Mandatory**: ___ / 100
- **Bonus**: ___ / 45
- **Final Score**: ___ / 100 (max 125 with bonuses)

**Result**: [ ] PASS (≥70) [ ] FAIL (<70)

---

## Code Quality Assessment

- **Pydantic Usage**: [ ] Excellent [ ] Good [ ] Needs Improvement
- **Error Handling**: [ ] Excellent [ ] Good [ ] Needs Improvement
- **Code Organization**: [ ] Excellent [ ] Good [ ] Needs Improvement

**Positive Aspects:**
```



```

**Areas for Improvement:**
```



```

---

## Defense Questions (Ask 3-4 of these)

Verify understanding:

1. **"Why do we use Pydantic for tool definitions?"**
   - Expected: Type validation, schema generation, documentation

2. **"What is a JSON schema and why does the LLM need it?"**
   - Expected: Describes the tool's parameters so LLM knows how to call it

3. **"What happens if you don't send the tool result back to the LLM?"**
   - Expected: LLM can't generate final answer, conversation incomplete

4. **"Show me where in the code you validate the tool arguments."**
   - Expected: Points to Pydantic model instantiation

5. **"What's the difference between 'user', 'assistant', and 'tool' messages?"**
   - Expected:
     - user = human input
     - assistant = LLM response or tool call
     - tool = result of tool execution

6. **"Could you add a new tool for... [suggest something]? What would you need to do?"**
   - Expected: Create Pydantic model, implement function, add to tools list

**Defense Notes:**
```




```

---

## Overall Feedback

**Strengths:**
```



```

**What to work on:**
```



```

**Advice for next module:**
```



```

---

## Signatures

**Evaluator**: ___________________________  Date: ___________

**Student**: ___________________________  Date: ___________

---

**Evaluation Complete** ✓
