# Agent Programming Curriculum

**Learn to build AI agents from first principles**

A hands-on, project-based curriculum for learning agent programming - inspired by 42 School's pedagogy.

---

## 🎯 What You'll Learn

By completing this curriculum, you will master:

- **Core Concepts**: LLM APIs, tool calling, message history, context management
- **Pydantic Pattern**: Industry-standard tool interface design
- **Tool Orchestration**: Parallel execution, batching, dependencies
- **Production Skills**: Error handling, retries, failover, permissions
- **Real-World Tools**: File operations, web search, bash execution, OCR
- **Architecture**: Build production-ready agents from scratch

**No frameworks, no black boxes - just fundamental agent architecture.**

---

## 📚 Curriculum Structure

### Module 00: Hello World - Your First LLM Call
**Time**: 2-3 hours | **Difficulty**: ⭐☆☆☆☆

Learn the fundamentals of talking to an LLM:
- Make your first API request
- Parse JSON responses
- Handle errors gracefully
- Display formatted output

**Status**: ✅ Complete (subject, eval, tests)

---

### Module 01: Your First Tool - Pydantic Interface
**Time**: 4-6 hours | **Difficulty**: ⭐⭐☆☆☆

Master the industry-standard pattern for tools:
- Define tools with Pydantic models
- Generate JSON schemas
- Detect and execute tool calls
- Complete the agent loop

**Key Insight**: This is how Claude Code, LangChain, and all modern frameworks define tools.

**Status**: ✅ Complete (subject, eval, tests)

---

### Module 02: Conversational Memory
**Time**: 3-4 hours | **Difficulty**: ⭐⭐☆☆☆

Build stateful agents with memory:
- Maintain message history
- Multi-turn conversations
- Context management
- Token tracking

**Status**: 📝 Subject outline created

---

### Module 03: Tool Orchestration - Parallel Execution
**Time**: 4-5 hours | **Difficulty**: ⭐⭐⭐☆☆

Execute multiple tools efficiently:
- Detect tool safety (read-only vs write)
- Batch execution strategies
- Parallel vs serial execution
- Handle dependencies

**Status**: 📝 Subject outline created

---

### Module 04: Error Handling & Retries
**Time**: 3-4 hours | **Difficulty**: ⭐⭐⭐☆☆

Build robust, fault-tolerant agents:
- Classify errors (auth, rate limit, server)
- Exponential backoff
- Circuit breaker pattern
- Graceful degradation

**Status**: 📝 Subject outline created

---

### Module 05: Session Persistence
**Time**: 3-4 hours | **Difficulty**: ⭐⭐☆☆☆

Save and manage agent memory:
- JSONL session format
- Load previous conversations
- Conversation compaction
- Multi-user isolation

**Status**: 📝 Subject outline created

---

### Module 06: Tool Permissions & Safety
**Time**: 4-5 hours | **Difficulty**: ⭐⭐⭐☆☆

Implement governance and security:
- Permission systems
- Input validation
- Dangerous operation detection
- Audit logging

**Status**: 📝 Subject outline created

---

### Module 07: Advanced Tools
**Time**: 5-6 hours | **Difficulty**: ⭐⭐⭐⭐☆

Build real-world capabilities:
- File operations (read, write, edit)
- Web search and fetch
- Bash execution (safe)
- Code search (glob, grep)

**Status**: 📝 Subject outline created

---

### Module 08: Multi-Provider Failover
**Time**: 4-5 hours | **Difficulty**: ⭐⭐⭐⭐☆

Ensure reliability with multiple providers:
- Provider abstraction
- Capability-based routing
- Automatic failover
- Cost optimization

**Status**: 📝 Subject outline created

---

### Module 09: Final Project - Complete Agent
**Time**: 8-12 hours | **Difficulty**: ⭐⭐⭐⭐⭐

Build a production-ready agent:
- Integrate all learned concepts
- Choose a real-world use case
- Production-quality code
- Live demonstration

**Options**:
- Code Assistant Agent
- Research Assistant Agent
- Data Analysis Agent

**Status**: 📝 Subject outline created

---

## 🎓 Learning Methodology (42 School Style)

### 1. Peer-to-Peer Learning
- No teachers, no lectures
- Learn by doing
- Help your peers
- Collaborate and discuss

### 2. Project-Based
- Every module is a hands-on project
- Build real, working code
- No multiple-choice quizzes

### 3. Peer Evaluation
- Every module includes an evaluation sheet
- Students evaluate each other
- Defense questions test understanding
- Pass threshold: 70/100

### 4. Automated Testing
- Each module has a test suite
- Run tests locally before evaluation
- Diff-based output validation
- Immediate feedback

### 5. No Solutions
- You write all code from scratch
- No copy-paste solutions
- Learn by struggling (then succeeding!)

---

## 🚀 Getting Started

### Prerequisites

**Required Knowledge**:
- Python basics (variables, functions, loops, dictionaries)
- How to use the command line
- Basic understanding of APIs

**No Need to Know**:
- ❌ Async/await (we'll teach you)
- ❌ LLMs or agents (that's what you'll learn)
- ❌ AI frameworks (we're building from scratch)

### Setup

1. **Install Python 3.8+**:
   ```bash
   python3 --version  # Should be 3.8 or higher
   ```

2. **Get an API key**:
   - [OpenRouter](https://openrouter.ai/) (recommended - easiest to start)
   - [Groq](https://console.groq.com/) (fast, free tier)
   - [OpenAI](https://platform.openai.com/) (most capable, costs money)

3. **Install dependencies**:
   ```bash
   pip install requests pydantic
   ```

4. **Set your API key**:
   ```bash
   export API_KEY="your_api_key_here"
   ```

5. **Start Module 00**:
   ```bash
   cd module-00
   cat subject.md  # Read the assignment
   ```

---

## 📋 How to Use This Curriculum

### For Each Module:

1. **Read `subject.md`**
   - Understand the objectives
   - Read the introduction
   - Review requirements

2. **Write your code**
   - Start small, build incrementally
   - Test frequently
   - No copy-paste from internet!

3. **Run the tests**
   ```bash
   ./tests/test_runner.sh
   ```

4. **Fix issues until tests pass** (≥70%)

5. **Find a peer evaluator**
   - Book an evaluation slot
   - Have them use `eval.md`
   - Answer defense questions
   - Get feedback

6. **Pass** (≥70%) → Move to next module

7. **Didn't pass?**
   - Review feedback
   - Fix issues
   - Re-evaluate

---

## 🧪 Testing System

Each module includes:

### 1. Automated Tests (`tests/test_runner.sh`)
```bash
cd module-XX
./tests/test_runner.sh  # Quick tests (no API calls)
API_KEY=xxx ./tests/test_runner.sh  # Full tests
```

### 2. Expected Outputs (`tests/expected_*.txt`)
- Use `diff` to compare your output
- Format must match exactly
- Content can vary slightly

### 3. Test README (`tests/README.md`)
- How to run tests
- Manual testing steps
- Common issues and fixes

---

## 📊 Evaluation System

### Peer Evaluation Process

1. **Evaluator opens `eval.md`**
2. **Preliminary checks** (if fail → stop, grade: 0)
3. **Run through test cases** (mandatory part)
4. **Check bonus features** (optional)
5. **Ask defense questions** (verify understanding)
6. **Calculate score** (mandatory + bonus)
7. **Pass/Fail**: ≥70 = Pass, <70 = Fail
8. **Provide feedback** (strengths, improvements)
9. **Both sign** the evaluation sheet

### Grading

- **Mandatory Part**: 0-100 points
- **Bonus Part**: 0-45 points
- **Final Score**: min(125, mandatory + bonus)
- **Pass Threshold**: 70/100

**Note**: You must complete mandatory part to get bonus points.

---

## 🎯 Learning Path

### Beginner Track (Modules 00-03)
**Time**: 2-3 weeks

Learn the core concepts:
1. Module 00: Hello World
2. Module 01: Tools with Pydantic
3. Module 02: Conversational Memory
4. Module 03: Parallel Execution

**After this**: You can build basic working agents!

---

### Intermediate Track (Modules 04-06)
**Time**: 2-3 weeks

Production-ready skills:
1. Module 04: Error Handling
2. Module 05: Session Persistence
3. Module 06: Permissions & Safety

**After this**: Your agents are robust and safe!

---

### Advanced Track (Modules 07-09)
**Time**: 3-4 weeks

Real-world capabilities:
1. Module 07: Advanced Tools
2. Module 08: Multi-Provider Failover
3. Module 09: Final Project

**After this**: You have a production-ready agent and deep understanding!

---

## 📈 Progress Tracking

Track your journey:

```
[ ] Module 00 - Hello World
[ ] Module 01 - Your First Tool
[ ] Module 02 - Conversational Memory
[ ] Module 03 - Tool Orchestration
[ ] Module 04 - Error Handling
[ ] Module 05 - Session Persistence
[ ] Module 06 - Permissions & Safety
[ ] Module 07 - Advanced Tools
[ ] Module 08 - Multi-Provider Failover
[ ] Module 09 - Final Project
```

---

## 🏆 What You'll Build

By the end, you'll have:

1. **Portfolio Project** (Module 09)
   - Production-ready agent
   - Clean, well-tested code
   - Real-world application

2. **Deep Understanding**
   - How agents actually work
   - No black-box frameworks
   - Fundamental patterns

3. **Practical Skills**
   - Pydantic for tool design
   - Error handling strategies
   - Multi-provider systems
   - Production best practices

4. **Foundation for Advanced Topics**
   - Multi-agent systems
   - Vector databases
   - Streaming responses
   - Advanced orchestration

---

## 💡 Key Concepts You'll Master

### 1. The Pydantic Pattern
```python
class ToolInput(BaseModel):
    param: str = Field(description="...")

# Auto-generates JSON schema for LLMs
# Auto-validates inputs
# Industry standard
```

### 2. The Agent Loop
```
User → LLM → Tool Call → Execute → Result → LLM → Response → User
```

### 3. Tool Orchestration
```
Detect safety → Batch by type → Execute parallel/serial → Return results
```

### 4. Message History
```
[user, assistant, tool, assistant, user, ...]
```

### 5. Error Classification
```
Transient (retry) vs Permanent (fail) vs Auth (user action)
```

---

## 🛠️ Tech Stack

You'll learn by building with:

- **Python 3.8+** - Modern Python
- **Pydantic** - Data validation and schemas
- **Requests** - HTTP client
- **JSON** - Data interchange
- **JSONL** - Session storage

**No frameworks** - You'll understand the fundamentals!

---

## 📚 Additional Resources

### Recommended Reading
- [Pydantic Documentation](https://docs.pydantic.dev/)
- [OpenAI Function Calling Guide](https://platform.openai.com/docs/guides/function-calling)
- [Claude Code Source Code](https://github.com/anthropics/claude-code) - See production patterns

### Community
- Find study partners
- Form peer evaluation groups
- Share knowledge (not code!)
- Help each other debug

---

## ⚠️ Important Rules

### Academic Honesty

✅ **Allowed**:
- Reading documentation
- Discussing concepts with peers
- Helping others debug (without giving answers)
- Searching for syntax help

❌ **Not Allowed**:
- Copying code from internet
- Sharing solution files
- Using AI to write your code
- Plagiarism of any kind

**Why?** You learn by struggling and solving problems yourself.

### Evaluation Rules

- **Be honest** in evaluations
- **Ask defense questions** - verify understanding
- **Give constructive feedback**
- **Don't pass plagiarized work**

---

## 🎓 After Graduation

Once you complete all 9 modules, you'll be ready to:

### 1. Build Production Agents
- Enterprise-grade code
- Robust error handling
- Multi-user systems

### 2. Learn Advanced Topics
- Async/await patterns
- Multi-agent orchestration
- Vector databases & RAG
- Streaming responses
- WebSocket connections

### 3. Contribute to Open Source
- Understand agent frameworks
- Contribute to Claude Code, LangChain, etc.
- Build your own framework

### 4. Professional Work
- Build AI products
- Agent consulting
- Technical leadership in AI teams

---

## 📞 Support

### Stuck on a Module?
1. Read the subject again carefully
2. Check the tests README
3. Review error messages
4. Ask peers for conceptual help (not code!)
5. Debug systematically

### Found a Bug?
- Open an issue in the repo
- Suggest improvements
- Contribute fixes

---

## 🗺️ Curriculum Roadmap

### Current Status (April 2026)
- ✅ **Module 00**: Complete (subject, eval, tests)
- ✅ **Module 01**: Complete (subject, eval, tests)
- 📝 **Modules 02-09**: Outlines created, full content coming soon

### Next Steps
1. Complete Module 02 (conversational memory)
2. Complete Module 03 (parallel execution)
3. Add video demonstrations
4. Community building

---

## 🎯 Start Your Journey

Ready to begin? Start here:

```bash
cd module-00
cat subject.md
```

**Good luck, and enjoy the journey!** 🚀

Remember: **The struggle is part of the learning.** Don't give up!

---

## 📄 License

This curriculum is open source and free to use for education.

**Based on**:
- 42 School pedagogy
- Claude Code architecture patterns
- Production agent frameworks

**Created**: April 2026
**Version**: 1.0.0

---

**Happy Learning!** 🎓✨
