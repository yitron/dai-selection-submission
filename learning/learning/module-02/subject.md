# Module 02 - Conversational Memory: Multi-Turn Agents

## Objectives
- Understand message history and context
- Implement multi-turn conversations
- Manage token limits
- Build a stateful agent

**Estimated Time**: 3-4 hours

---

## Introduction

So far, your agents have been "stateless" - they forget everything after each question. Real agents need **memory** to have conversations.

In this module, you'll learn to:
- Maintain message history across turns
- Keep context for the LLM
- Handle tools across multiple turns
- Manage growing conversation length

---

## Mandatory Part

### Exercise 02: Conversational Calculator

Build `conversational_agent.py` that:

1. **Maintains conversation history**
   - User messages
   - Assistant responses
   - Tool calls and results

2. **Supports multi-turn interactions**
   ```bash
   You: What is 10 + 5?
   Agent: The answer is 15.

   You: Multiply that by 2
   Agent: 15 multiplied by 2 is 30.

   You: And add 10 more
   Agent: 30 plus 10 equals 40.

   You: exit
   ```

3. **Sends full history to LLM each turn**
   ```python
   messages = [
       {"role": "user", "content": "What is 10 + 5?"},
       {"role": "assistant", "content": None, "tool_calls": [...]},
       {"role": "tool", "content": "15", "tool_call_id": "..."},
       {"role": "assistant", "content": "The answer is 15."},
       {"role": "user", "content": "Multiply that by 2"},  # New turn
       # ... and so on
   ]
   ```

4. **Track token usage**
   - Display total tokens used per turn
   - Warn when approaching limits

### Requirements

- Interactive loop (REPL style)
- Exit on "exit", "quit", or Ctrl+C
- Maintain context across turns
- Clear display of user/agent messages
- Token counter showing cumulative usage

---

## Bonus Part

### Bonus 1: Conversation Summary (+ 15 pts)
Show conversation stats at exit:
```
Session Summary:
- Total turns: 5
- Total tokens: 1,250
- Tools called: 3
- Session duration: 2m 15s
```

### Bonus 2: Context Window Management (+ 20 pts)
Trim old messages when approaching token limit (e.g., 4000 tokens):
- Keep system message
- Keep last N messages
- Show warning when trimming

### Bonus 3: Save/Load Conversations (+ 15 pts)
Save conversation to JSON file:
```bash
python conversational_agent.py --save my_session.json
python conversational_agent.py --load my_session.json
```

---

## Turn-in
- `conversational_agent.py`
- `requirements.txt`

**Pass threshold**: 70/100

---

## Key Concepts

### Message History
Every message must be preserved in order:
1. User input
2. Assistant response (possibly with tool calls)
3. Tool results
4. Assistant final response
5. Next user input...

### Context Length
- Models have token limits (usually 4k-128k)
- Each turn adds tokens
- Must manage history to stay under limits

### Stateful vs Stateless
- **Stateless**: Each request independent (Module 00)
- **Stateful**: Maintains context across requests (this module)

---

*Full implementation details, tests, and evaluation sheet coming soon...*
