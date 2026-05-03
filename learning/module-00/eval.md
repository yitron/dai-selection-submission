# Module 00 - Evaluation Sheet

## Student Information
- **Evaluator**: ___________________________
- **Student**: ___________________________
- **Date**: ___________________________
- **Start Time**: ___________________________
- **End Time**: ___________________________

---

## Preliminary Checks (If any fail, evaluation stops)

- [ ] Git repository is clean (no API keys committed)
- [ ] Turn-in files are present: `hello_llm.py`
- [ ] Student can explain what an LLM is
- [ ] Student has a valid API key ready for testing

**If any preliminary check fails, stop here. Grade: 0/100**

---

## Mandatory Part (100 points)

### 1. Command-Line Argument Handling (10 points)

Test the program with different inputs:

```bash
# Test 1: With argument
python hello_llm.py "What is 2+2?"

# Test 2: No argument
python hello_llm.py

# Test 3: Multiple words
python hello_llm.py "Tell me a short joke"
```

**Evaluation:**
- [ ] (5 pts) Program accepts command-line argument
- [ ] (5 pts) Shows error/usage message when no argument provided

**Score: ___ / 10**

**Notes:**
```



```

---

### 2. API Request (30 points)

Ask the student to show you the API request code.

**Evaluation:**
- [ ] (10 pts) Uses correct HTTP method (POST)
- [ ] (5 pts) Sets Authorization header with API key
- [ ] (5 pts) Sets Content-Type header to application/json
- [ ] (5 pts) Sends message in correct format (role: user, content: ...)
- [ ] (5 pts) Sets temperature parameter

**Score: ___ / 30**

**Code Quality Notes:**
```



```

---

### 3. JSON Response Parsing (20 points)

Test the program and verify it extracts the response correctly.

```bash
python hello_llm.py "Say exactly: Hello World"
```

**Evaluation:**
- [ ] (10 pts) Correctly parses JSON response
- [ ] (10 pts) Extracts the assistant's message from `choices[0].message.content`

**Score: ___ / 20**

**Notes:**
```



```

---

### 4. Output Formatting (20 points)

Check the output format matches the specification:

Expected format:
```
[LLM Response]
<the actual response>
```

**Evaluation:**
- [ ] (10 pts) Includes "[LLM Response]" header
- [ ] (10 pts) Displays the LLM's answer cleanly (no extra JSON, no debug output)

**Score: ___ / 20**

**Notes:**
```



```

---

### 5. Error Handling (20 points)

Test error scenarios:

```bash
# Test 1: No API key
API_KEY="" python hello_llm.py "test"

# Test 2: Invalid API key
API_KEY="invalid123" python hello_llm.py "test"

# Test 3: Network error (disconnect internet or use invalid URL)
```

**Evaluation:**
- [ ] (7 pts) Handles missing API key gracefully
- [ ] (7 pts) Handles API errors (4xx, 5xx) gracefully
- [ ] (6 pts) Shows meaningful error messages (not just stack traces)

**Score: ___ / 20**

**Notes:**
```



```

---

## Mandatory Part Total: ___ / 100

**Pass threshold: 70/100**

---

## Bonus Part (45 points max)

### Bonus 1: Token Counter (10 points)

```bash
python hello_llm.py "What is AI?"
```

**Evaluation:**
- [ ] (5 pts) Displays input token count
- [ ] (5 pts) Displays output token count

**Score: ___ / 10**

---

### Bonus 2: Multi-turn Conversation (15 points)

Run the program in interactive mode (if implemented):

```bash
python hello_llm.py
# Try multiple questions and verify context is maintained
```

**Evaluation:**
- [ ] (5 pts) Accepts multiple questions in a loop
- [ ] (5 pts) Maintains conversation history
- [ ] (5 pts) Exits cleanly when user types "exit"

**Score: ___ / 15**

---

### Bonus 3: Streaming Response (20 points)

Test streaming functionality:

```bash
python hello_llm.py "Tell me a story"
```

**Evaluation:**
- [ ] (10 pts) Response appears word-by-word (not all at once)
- [ ] (10 pts) Properly handles streaming API response format

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

## Code Quality Assessment (Not graded, for feedback only)

- **Readability**: [ ] Excellent [ ] Good [ ] Needs Improvement
- **Error Messages**: [ ] Clear and helpful [ ] Basic [ ] Poor
- **Code Organization**: [ ] Well structured [ ] Acceptable [ ] Messy

**Positive Aspects:**
```



```

**Areas for Improvement:**
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

## Defense Questions (Ask 2-3 of these)

Use these to verify understanding:

1. "What does the temperature parameter do?"
2. "Why do we send messages as a list instead of a single string?"
3. "What's the difference between a user message and an assistant message?"
4. "What happens if you don't set the Authorization header?"
5. "Why shouldn't you commit your API key to git?"
6. "What would happen if you sent 100,000 tokens to the API?"

**Defense Notes:**
```




```

---

**Evaluation Complete** ✓
