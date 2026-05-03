# Module 01 - Your First Tool: Teaching the LLM to Take Action

## Table of Contents
- [Objectives](#objectives)
- [Introduction](#introduction)
- [General Instructions](#general-instructions)
- [Mandatory Part](#mandatory-part)
- [Bonus Part](#bonus-part)
- [Turn-in](#turn-in)
- [Evaluation](#evaluation)

---

## Objectives

By the end of this module, you will:
- Understand what a "tool" is in agent programming
- Define a tool using Pydantic models
- Generate JSON schemas that LLMs can understand
- Parse tool calls from LLM responses
- Execute tools and return results
- Complete a full agent loop: LLM → Tool → LLM

**Estimated Time**: 4-6 hours

---

## Introduction

In Module 00, you learned to talk to an LLM. But the LLM could only respond with text. What if we want it to:
- Perform calculations
- Look up information in a database
- Send emails
- Control smart home devices

This is where **tools** come in!

### What is a Tool?

A tool is a function that:
1. The LLM knows exists (via a schema)
2. The LLM can decide to call
3. Your code executes
4. Returns results back to the LLM

Think of it like this:
- **Without tools**: LLM is a smart person in a room with no hands
- **With tools**: LLM is a smart person who can ask you to do things

### The Pydantic Pattern

Modern agent frameworks (Claude Code, LangChain, etc.) use **Pydantic** for tools because:

```python
from pydantic import BaseModel, Field

class CalculatorInput(BaseModel):
    """Input for calculator tool"""
    operation: str = Field(description="Operation: add, subtract, multiply, divide")
    a: float = Field(description="First number")
    b: float = Field(description="Second number")
```

This Pydantic model automatically:
- ✅ Validates inputs
- ✅ Generates JSON schema for the LLM
- ✅ Documents parameters
- ✅ Provides type safety

**This is the pattern you'll learn in this module.**

---

## General Instructions

### Prerequisites
- Completed Module 00
- Understand basic Python functions
- API key from LLM provider (same as Module 00)

### Required Libraries
```bash
pip install requests pydantic
```

### Allowed Libraries
- `requests` - HTTP requests
- `pydantic` - Model validation and schema generation
- `json`, `os`, `sys` - Built-in libraries

### Forbidden
- ❌ No AI frameworks (LangChain, LlamaIndex, etc.)
- ❌ No pre-built agent libraries
- ❌ No OpenAI/Anthropic SDKs (we're learning the raw API)
- ❌ No async/await yet

---

## Mandatory Part

### Exercise 01: Calculator Tool

Create a program `agent_with_tool.py` that implements a calculator tool using Pydantic.

#### Requirements

Your program must:

1. **Define a tool using Pydantic** that can perform basic math operations

2. **Generate a JSON schema** from your Pydantic model

3. **Send the tool definition to the LLM** along with the user's request

4. **Detect when the LLM wants to call the tool**

5. **Execute the tool** with the LLM's parameters

6. **Return the result to the LLM** and display the final answer

#### The Tool Definition (Pydantic)

```python
from pydantic import BaseModel, Field

class CalculatorInput(BaseModel):
    """Perform basic arithmetic operations"""
    operation: str = Field(
        description="The operation to perform: 'add', 'subtract', 'multiply', or 'divide'"
    )
    a: float = Field(description="The first number")
    b: float = Field(description="The second number")

def calculator(operation: str, a: float, b: float) -> float:
    """Execute the calculator operation"""
    if operation == "add":
        return a + b
    elif operation == "subtract":
        return a - b
    elif operation == "multiply":
        return a * b
    elif operation == "divide":
        if b == 0:
            raise ValueError("Cannot divide by zero")
        return a / b
    else:
        raise ValueError(f"Unknown operation: {operation}")
```

#### Generating JSON Schema

You need to convert your Pydantic model to JSON schema:

```python
tool_definition = {
    "type": "function",
    "function": {
        "name": "calculator",
        "description": "Perform basic arithmetic operations",
        "parameters": CalculatorInput.model_json_schema()
    }
}
```

This creates:
```json
{
  "type": "function",
  "function": {
    "name": "calculator",
    "description": "Perform basic arithmetic operations",
    "parameters": {
      "type": "object",
      "properties": {
        "operation": {
          "type": "string",
          "description": "The operation to perform: 'add', 'subtract', 'multiply', or 'divide'"
        },
        "a": {
          "type": "number",
          "description": "The first number"
        },
        "b": {
          "type": "number",
          "description": "The second number"
        }
      },
      "required": ["operation", "a", "b"]
    }
  }
}
```

#### API Request with Tools

```python
data = {
    "model": "meta-llama/llama-3.1-8b-instruct:free",
    "messages": [
        {"role": "user", "content": "What is 25 + 17?"}
    ],
    "tools": [tool_definition],  # Send your tool definition here
    "temperature": 0.7
}
```

#### Detecting Tool Calls

The LLM's response will look like this when it wants to use a tool:

```json
{
  "choices": [{
    "message": {
      "role": "assistant",
      "content": null,
      "tool_calls": [{
        "id": "call_123",
        "type": "function",
        "function": {
          "name": "calculator",
          "arguments": "{\"operation\": \"add\", \"a\": 25, \"b\": 17}"
        }
      }]
    }
  }]
}
```

#### The Agent Loop

```
1. User asks: "What is 25 + 17?"
2. Send to LLM with tool definition
3. LLM responds with tool_call for calculator(operation="add", a=25, b=17)
4. Execute: calculator("add", 25, 17) → 42
5. Send result back to LLM as a tool message
6. LLM responds: "The answer is 42"
7. Display to user
```

#### Expected Program Behavior

```bash
$ python agent_with_tool.py "What is 25 + 17?"
[Tool Call] calculator
Arguments: operation=add, a=25.0, b=17.0
Result: 42.0

[Final Answer]
The answer is 42.

$ python agent_with_tool.py "Calculate 100 divided by 5"
[Tool Call] calculator
Arguments: operation=divide, a=100.0, b=5.0
Result: 20.0

[Final Answer]
100 divided by 5 equals 20.

$ python agent_with_tool.py "What is the capital of France?"
[No Tool Call]

[Final Answer]
The capital of France is Paris.
```

#### Full Implementation Flow

1. **Parse command-line argument** (user's question)

2. **Send first request** to LLM with:
   - User's message
   - Tool definition

3. **Check if LLM wants to call a tool**:
   - If `tool_calls` exists in response → Execute tool
   - If no `tool_calls` → Display answer and exit

4. **Execute the tool**:
   - Parse `arguments` JSON string
   - Validate with Pydantic model
   - Call your calculator function
   - Capture result

5. **Send tool result back to LLM**:
   ```python
   messages = [
       {"role": "user", "content": "What is 25 + 17?"},
       {"role": "assistant", "content": None, "tool_calls": [...]},  # LLM's tool call
       {"role": "tool", "tool_call_id": "call_123", "content": "42"}  # Your result
   ]
   ```

6. **Get final answer** from LLM and display

---

## Bonus Part

### Bonus 1: Multiple Operations (+ 15 points)

Support multiple operations in one question:

```bash
$ python agent_with_tool.py "What is 10 + 5 and then multiply by 2?"
[Tool Call] calculator
Arguments: operation=add, a=10.0, b=5.0
Result: 15.0

[Tool Call] calculator
Arguments: operation=multiply, a=15.0, b=2.0
Result: 30.0

[Final Answer]
First we add 10 + 5 to get 15, then multiply by 2 to get 30.
```

Hint: LLM might make multiple tool calls in sequence.

### Bonus 2: Input Validation (+ 10 points)

Use Pydantic's validators to ensure valid operations:

```python
from pydantic import BaseModel, Field, field_validator

class CalculatorInput(BaseModel):
    operation: str = Field(...)
    a: float = Field(...)
    b: float = Field(...)

    @field_validator('operation')
    def validate_operation(cls, v):
        allowed = ['add', 'subtract', 'multiply', 'divide']
        if v not in allowed:
            raise ValueError(f'operation must be one of {allowed}')
        return v
```

### Bonus 3: More Tools (+ 20 points)

Add a second tool for a different purpose:

```python
class GetDateInput(BaseModel):
    """Get the current date and time"""
    timezone: str = Field(
        default="UTC",
        description="Timezone (UTC, EST, PST, etc.)"
    )
```

The LLM should be able to choose between calculator and get_date.

---

## Turn-in

### Directory Structure
```
module-01/
├── agent_with_tool.py      # Your implementation
├── requirements.txt        # pip dependencies
└── .env.example           # Example environment file
```

### Turn-in Files
- `agent_with_tool.py` - Main program
- `requirements.txt` - List: `requests`, `pydantic`

### Testing Before Turn-in

```bash
# Test math question
python agent_with_tool.py "What is 50 + 32?"

# Test non-math question (should not call tool)
python agent_with_tool.py "What is Python?"

# Test division
python agent_with_tool.py "What is 100 divided by 4?"
```

---

## Evaluation

See `eval.md` for the peer evaluation sheet.

### Grading Breakdown

**Mandatory Part**: 100 points
- Pydantic model defined correctly (20 pts)
- JSON schema generation (15 pts)
- Tool sent in API request (15 pts)
- Tool call detection (15 pts)
- Tool execution (20 pts)
- Result sent back to LLM (15 pts)

**Bonus**: Up to 45 points
- Multiple operations (15 pts)
- Input validation (10 pts)
- Additional tools (20 pts)

**Pass threshold**: 70/100

---

## Key Concepts

### Why Pydantic?

```python
# Without Pydantic - manual validation
def calculator(operation, a, b):
    if not isinstance(operation, str):
        raise TypeError("operation must be string")
    if not isinstance(a, (int, float)):
        raise TypeError("a must be number")
    # ... etc

# With Pydantic - automatic validation
class CalculatorInput(BaseModel):
    operation: str
    a: float
    b: float

# Pydantic does all validation automatically!
```

### JSON Schema Generation

```python
# Manual schema (error-prone)
schema = {
    "type": "object",
    "properties": {
        "operation": {"type": "string", "description": "..."},
        # ... write everything manually
    }
}

# Pydantic schema (automatic, always correct)
schema = CalculatorInput.model_json_schema()
```

### Type Safety

```python
# Runtime validation
try:
    args = CalculatorInput(operation="add", a=10, b=20)
    result = calculator(args.operation, args.a, args.b)
except ValidationError as e:
    print(f"Invalid arguments: {e}")
```

---

## Common Pitfalls

1. **Forgetting to send tools in API request**
   ```python
   # Wrong
   data = {"model": "...", "messages": [...]}

   # Correct
   data = {"model": "...", "messages": [...], "tools": [tool_def]}
   ```

2. **Not parsing arguments JSON**
   ```python
   # Wrong
   args = tool_call["function"]["arguments"]  # This is a string!

   # Correct
   args_dict = json.loads(tool_call["function"]["arguments"])
   args = CalculatorInput(**args_dict)
   ```

3. **Not sending tool result back**
   - LLM needs the tool result to give a final answer
   - Must send as `{"role": "tool", "content": "...", "tool_call_id": "..."}`

---

## Resources

- [Pydantic Documentation](https://docs.pydantic.dev/)
- [Pydantic JSON Schema](https://docs.pydantic.dev/latest/concepts/json_schema/)
- [OpenAI Function Calling](https://platform.openai.com/docs/guides/function-calling)
- [JSON Schema Reference](https://json-schema.org/understanding-json-schema/)

---

## Tips

1. **Start small**: First, just generate the JSON schema and print it. Make sure it looks right.

2. **Test tool execution separately**: Make sure your calculator function works before integrating with LLM.

3. **Debug the LLM response**: Print the full response to see the structure of `tool_calls`.

4. **Validate with Pydantic**: Let Pydantic catch errors before they reach your function.

5. **Read error messages**: Both Pydantic and the LLM API give helpful error messages.

---

## Next Module

Once complete, move to:

**Module 02 - Conversational Memory**: Learn to maintain context across multiple turns! 🧠

---

**Good luck!** 🚀

You're now learning the core pattern used by every modern agent framework!
