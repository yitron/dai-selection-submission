# Module 03 - Tool Orchestration: Parallel Execution

## Objectives
- Execute multiple tools in parallel
- Understand concurrency safety
- Batch tool executions efficiently
- Handle tool dependencies

**Estimated Time**: 4-5 hours

---

## Introduction

Real agents often need to call multiple tools:
- "What's the weather in NYC and Paris?"
- "Calculate 5+5, 10*2, and 50/5"
- "Search for info in file1.txt and file2.txt"

Instead of executing tools one-by-one, we can run them **in parallel** for speed!

---

## Mandatory Part

### Exercise 03: Parallel Tool Execution

Build `parallel_agent.py` that:

1. **Detects multiple tool calls** from a single LLM response

2. **Categorizes tools** by safety:
   - **Read-only** (safe to run in parallel)
   - **Write operations** (must run serially)

3. **Executes tool batches**:
   ```python
   # All read-only tools run at same time
   batch_1 = [calculator(5+5), calculator(10*2), calculator(50/5)]
   results = execute_parallel(batch_1)  # All at once!

   # Write operations run one-by-one
   batch_2 = [write_file("a.txt"), write_file("b.txt")]
   results = execute_serial(batch_2)  # One at a time
   ```

4. **Returns all results** to LLM

### Required Tools

Implement these tools with Pydantic:

1. **Calculator** (read-only, concurrent-safe)
2. **WebSearch** (read-only, concurrent-safe)
3. **FileWrite** (write operation, NOT concurrent-safe)

### Example

```bash
You: Calculate 5+5, 10*2, and search web for "Python"

[Parallel Execution]
Batch 1 (parallel): calculator, calculator, web_search
- calculator(5+5) → 10
- calculator(10*2) → 20
- web_search("Python") → "Python is a programming language..."

Agent: I found that 5+5=10, 10*2=20, and Python is a programming language...
```

---

## Bonus Part

### Bonus 1: Dependency Detection (+ 20 pts)
Detect when tools depend on each other:
```
"Calculate 5+5, then multiply the result by 2"
```
Tool 2 depends on Tool 1's output → Must run serially!

### Bonus 2: Threading (+ 15 pts)
Use Python `concurrent.futures` for true parallel execution:
```python
from concurrent.futures import ThreadPoolExecutor

with ThreadPoolExecutor(max_workers=5) as executor:
    results = executor.map(execute_tool, tool_calls)
```

### Bonus 3: Timeout Handling (+ 10 pts)
Cancel slow tools after timeout:
```
Tool "web_search" timed out after 10s
```

---

## Turn-in
- `parallel_agent.py`
- Tool safety definitions
- Test with 3+ simultaneous tools

**Pass threshold**: 70/100

---

## Key Concepts

### Concurrency Safety
- **Safe**: Reading data, calculations (no side effects)
- **Unsafe**: Writing files, database updates (side effects)

### Batching Strategy
```
Read tools → Parallel
Write tools → Serial
Mixed → Batch by type
```

### Why This Matters
- Speed: 3 parallel tools = 1x time (vs 3x serial)
- Efficiency: Better user experience
- Real-world pattern: All agent frameworks do this

---

*Full implementation details, tests, and evaluation sheet coming soon...*
