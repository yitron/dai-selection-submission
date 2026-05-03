# Module 00 - Hello World: Your First LLM Call

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
- Understand what an LLM API is and how to call it
- Make your first API request to an LLM provider
- Handle JSON responses from the API
- Display formatted output to the user
- Learn basic error handling for API calls

**Estimated Time**: 2-3 hours

---

## Introduction

Welcome to your first step in building AI agents! In this module, you'll learn the most fundamental skill: talking to a Large Language Model (LLM).

An **agent** is a program that uses an LLM to:
1. Understand what a user wants
2. Think about how to help
3. Take actions or respond with helpful information

Before we can build agents, we need to learn how to communicate with LLMs. Think of it like learning to use a phone before you can have a conversation.

### What You'll Build

A simple Python program that:
- Takes user input
- Sends it to an LLM API
- Displays the LLM's response

It's that simple! But this is the foundation of everything.

---

## General Instructions

### Prerequisites
- Python 3.8 or higher installed
- A text editor (VS Code, Sublime, vim, etc.)
- Internet connection
- API key from one of these providers (choose one):
  - **OpenRouter** (recommended for beginners) - https://openrouter.ai/
  - **Groq** - https://console.groq.com/
  - **OpenAI** - https://platform.openai.com/

### Allowed Libraries
- `requests` - for making HTTP requests
- `json` - for parsing JSON (built-in)
- `os` - for environment variables (built-in)
- `sys` - for command line arguments (built-in)

### Forbidden
- ❌ No AI frameworks (LangChain, LlamaIndex, etc.)
- ❌ No pre-built agent libraries
- ❌ No `openai` Python SDK (we're learning the raw API)
- ❌ No `anthropic` Python SDK
- ❌ No async/await (we haven't learned it yet)

**Why?** We're learning the fundamentals. Libraries hide important details.

---

## Mandatory Part

### Exercise 00: Hello LLM

Create a file called `hello_llm.py` that implements the following:

#### Requirements

1. **Take user input** from the command line:
   ```bash
   python hello_llm.py "What is the capital of France?"
   ```

2. **Make an API request** to an LLM provider with:
   - Model: Any chat model (e.g., `gpt-3.5-turbo`, `llama-3.1-8b-instant`)
   - Message: The user's question
   - Temperature: 0.7

3. **Parse the response** and extract the assistant's reply

4. **Display the result** in this exact format:
   ```
   [LLM Response]
   <the actual response text>
   ```

5. **Handle errors** gracefully:
   - Missing API key → Show error message
   - Network error → Show connection error
   - API error → Show API error message
   - Exit with status code 1 on error, 0 on success

#### API Request Format

Your API request should follow this structure (example for OpenRouter):

```python
import requests
import json

url = "https://openrouter.ai/api/v1/chat/completions"
headers = {
    "Authorization": f"Bearer {api_key}",
    "Content-Type": "application/json"
}
data = {
    "model": "meta-llama/llama-3.1-8b-instruct:free",
    "messages": [
        {"role": "user", "content": "Your user's question here"}
    ],
    "temperature": 0.7
}

response = requests.post(url, headers=headers, json=data)
```

The response will be JSON like this:
```json
{
  "choices": [
    {
      "message": {
        "role": "assistant",
        "content": "The capital of France is Paris."
      }
    }
  ]
}
```

#### Expected Behavior

```bash
$ python hello_llm.py "What is 2+2?"
[LLM Response]
2 + 2 equals 4.

$ python hello_llm.py
Error: Please provide a question as an argument
Usage: python hello_llm.py "your question here"

$ API_KEY="" python hello_llm.py "test"
Error: API key not found. Set the API_KEY environment variable.
```

---

## Bonus Part

If you completed the mandatory part perfectly, try these bonuses:

### Bonus 1: Token Counter (+ 10 points)
Display the number of tokens used in the request and response.

```bash
$ python hello_llm.py "What is AI?"
[LLM Response]
AI stands for Artificial Intelligence...

[Token Usage]
Input tokens: 12
Output tokens: 45
Total tokens: 57
```

Hint: Most API responses include `usage` data.

### Bonus 2: Multi-turn Conversation (+ 15 points)
Keep asking questions until the user types "exit":

```bash
$ python hello_llm.py
You: What is the capital of France?
LLM: The capital of France is Paris.

You: What about Germany?
LLM: The capital of Germany is Berlin.

You: exit
Goodbye!
```

Hint: You'll need to keep a list of messages and send the full history each time.

### Bonus 3: Streaming Response (+ 20 points)
Display the response word-by-word as it arrives (like ChatGPT does).

```bash
$ python hello_llm.py "Tell me a joke"
[LLM Response]
Why did the chicken... cross the... road? To get... to the... other side!
```

Hint: Look for `stream=True` in the API documentation.

---

## Turn-in

### Directory Structure
```
module-00/
├── hello_llm.py        # Your implementation
└── .env.example        # Example environment file (no real keys!)
```

### Turn-in Files
- `hello_llm.py` - Your main program
- `.env.example` - Example showing which environment variables are needed

### How to Submit
```bash
cd module-00
# Make sure your files are here
ls -la
# Test your program
python hello_llm.py "test question"
```

---

## Evaluation

Your peer evaluator will use the evaluation sheet in `eval.md`.

### Grading Breakdown
- **Mandatory Part**: 100 points
  - Program takes command-line argument (10 pts)
  - Makes API request (30 pts)
  - Parses JSON response correctly (20 pts)
  - Displays in correct format (20 pts)
  - Error handling works (20 pts)

- **Bonus**: Up to 45 points
  - Token counter (10 pts)
  - Multi-turn conversation (15 pts)
  - Streaming response (20 pts)

**Pass threshold**: 70/100

---

## Tips

1. **Start small**: First, just get the API to respond. Then add formatting and error handling.

2. **Test with different questions**: Make sure your program works with:
   - Short questions ("Hi")
   - Long questions (full paragraphs)
   - Questions with special characters ("What's 2+2?")

3. **Read error messages**: If the API returns an error, it will tell you what's wrong.

4. **Use environment variables**: Never hardcode API keys in your code!
   ```python
   import os
   api_key = os.getenv("API_KEY")
   ```

5. **Check HTTP status codes**:
   ```python
   if response.status_code != 200:
       print(f"Error: API returned status {response.status_code}")
   ```

---

## Resources

- [OpenRouter API Docs](https://openrouter.ai/docs)
- [Groq API Docs](https://console.groq.com/docs/quickstart)
- [OpenAI API Reference](https://platform.openai.com/docs/api-reference)
- [Python requests library](https://requests.readthedocs.io/)
- [JSON in Python](https://docs.python.org/3/library/json.html)

---

## Next Module

Once you've completed this module and had it evaluated, move on to:

**Module 01 - Your First Tool**: Learn how to give your agent superpowers! 🛠️

---

**Good luck!** 🚀

Remember: Every expert was once a beginner. Take your time, read the error messages, and don't be afraid to experiment.
