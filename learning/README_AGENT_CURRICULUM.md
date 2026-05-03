# Agent Programming Curriculum

**Learn to build AI agents from first principles - 42 School style**

> _"The best way to learn is by doing."_

---

## 🎯 Quick Start

1. **Prerequisites**: Python 3.8+, API key from [OpenRouter](https://openrouter.ai/) or [Groq](https://console.groq.com/)
2. **Install**: `pip install requests pydantic`
3. **Start**: `cd module-00 && cat subject.md`

---

## 📚 What's Inside

### Complete Modules (Ready to Use)
- ✅ **Module 00** - Hello World: Your First LLM Call
- ✅ **Module 01** - Your First Tool: Pydantic Interface

### Coming Soon
- 📝 **Module 02** - Conversational Memory
- 📝 **Module 03** - Tool Orchestration
- 📝 **Module 04** - Error Handling & Retries
- 📝 **Module 05** - Session Persistence
- 📝 **Module 06** - Permissions & Safety
- 📝 **Module 07** - Advanced Tools
- 📝 **Module 08** - Multi-Provider Failover
- 📝 **Module 09** - Final Project

---

## 📖 Full Documentation

**Read the complete curriculum**: [`CURRICULUM.md`](./CURRICULUM.md)

Includes:
- Learning methodology
- All module descriptions
- Evaluation system
- Progress tracking
- Tips and resources

---

## 🎓 42 School Pedagogy

This curriculum follows 42's proven learning model:

### No Teachers
Learn by doing, not listening to lectures.

### Peer-to-Peer
Students help each other, peer evaluations.

### Project-Based
Build real code, not toy examples.

### Gamified
Clear progression, pass thresholds, bonuses.

### Automated Testing
Instant feedback, before peer evaluation.

---

## 📁 Directory Structure

```
learning/
├── CURRICULUM.md              # Full curriculum guide (start here!)
├── README_AGENT_CURRICULUM.md # This file
│
├── module-00/                 # Hello World
│   ├── subject.md            # Assignment
│   ├── eval.md               # Peer evaluation sheet
│   └── tests/                # Automated tests
│       ├── test_runner.sh
│       ├── expected_*.txt
│       └── README.md
│
├── module-01/                 # Your First Tool
│   ├── subject.md
│   ├── eval.md
│   └── tests/
│
├── module-02/                 # Conversational Memory (outline)
├── module-03/                 # Tool Orchestration (outline)
├── module-04/                 # Error Handling (outline)
├── module-05/                 # Session Persistence (outline)
├── module-06/                 # Permissions & Safety (outline)
├── module-07/                 # Advanced Tools (outline)
├── module-08/                 # Multi-Provider (outline)
└── module-09/                 # Final Project (outline)
```

---

## 🚀 Learning Path

### Week 1-2: Core Foundations
- Module 00: Hello World (2-3 hours)
- Module 01: Your First Tool (4-6 hours)

**Outcome**: Understand LLM APIs and Pydantic tool pattern

### Week 3-4: Stateful Agents
- Module 02: Conversational Memory (3-4 hours)
- Module 03: Tool Orchestration (4-5 hours)

**Outcome**: Build multi-turn agents with parallel execution

### Week 5-6: Production Ready
- Module 04: Error Handling (3-4 hours)
- Module 05: Session Persistence (3-4 hours)
- Module 06: Permissions & Safety (4-5 hours)

**Outcome**: Robust, secure, production-grade agents

### Week 7-9: Advanced & Final Project
- Module 07: Advanced Tools (5-6 hours)
- Module 08: Multi-Provider (4-5 hours)
- Module 09: Final Project (8-12 hours)

**Outcome**: Portfolio-ready agent project

---

## 🎯 What You'll Learn

### Core Skills
- LLM API integration
- Pydantic tool interfaces
- Message history management
- Tool orchestration
- Error handling strategies
- Multi-provider failover

### Production Patterns
- Industry-standard tool design
- Parallel execution
- Session persistence
- Permission systems
- Audit logging
- Safety sandboxing

### Real-World Tools
- File operations
- Web search
- Bash execution
- Code search
- OCR/Vision
- And more...

---

## 🧪 Testing System

Every complete module includes:

### 1. Automated Tests
```bash
cd module-XX
./tests/test_runner.sh           # Quick tests
API_KEY=xxx ./tests/test_runner.sh  # Full tests
```

### 2. Expected Outputs
- `expected_*.txt` files for diff comparison
- Format validation
- Content verification

### 3. Peer Evaluation
- `eval.md` with grading rubric
- Defense questions
- Pass threshold: 70/100

---

## 📊 Grading System

Each module:
- **Mandatory Part**: 100 points
- **Bonus Part**: 0-45 points
- **Pass Threshold**: 70/100
- **Max Score**: 125 (100 + bonuses)

---

## 💡 Key Insight: The Pydantic Pattern

**You identified the core pattern!** 🎯

Modern agent frameworks (Claude Code, LangChain, CrewAI) all use Pydantic for tools:

```python
from pydantic import BaseModel, Field

class CalculatorInput(BaseModel):
    """Perform arithmetic operations"""
    operation: str = Field(description="add, subtract, multiply, divide")
    a: float = Field(description="First number")
    b: float = Field(description="Second number")

# This automatically:
# ✅ Generates JSON schema for LLM
# ✅ Validates inputs
# ✅ Documents parameters
# ✅ Provides type safety
```

**This curriculum teaches this pattern from Module 01 onward.**

---

## 🎓 Learning Principles

### 1. Build from First Principles
No frameworks - understand the fundamentals.

### 2. Learn by Struggling
The challenge is part of the learning.

### 3. Peer-to-Peer
Teach others to reinforce your knowledge.

### 4. Project-Based
Build real, working code every module.

### 5. Progressive Complexity
Each module builds on the previous.

---

## 🛠️ Tools You'll Master

By Module 09, you'll have built:

- **Calculator Tool** (Module 01)
- **Conversational Agent** (Module 02)
- **Parallel Executor** (Module 03)
- **Robust Error Handler** (Module 04)
- **Session Manager** (Module 05)
- **Permission System** (Module 06)
- **File Operations** (Module 07)
- **Web Search** (Module 07)
- **Bash Tool** (Module 07)
- **Multi-Provider System** (Module 08)
- **Complete Agent** (Module 09)

---

## ⚠️ Important Notes

### No Cheating
- Don't copy code from internet
- Write everything yourself
- Learn by struggling!

### Peer Evaluation
- Be honest and thorough
- Ask defense questions
- Give constructive feedback

### Tests Are Your Friend
- Run tests frequently
- Fix issues before evaluation
- Use tests to debug

---

## 📚 Resources

### Documentation
- **Full Curriculum**: [CURRICULUM.md](./CURRICULUM.md)
- **Pydantic Docs**: https://docs.pydantic.dev/
- **OpenRouter API**: https://openrouter.ai/docs
- **Groq API**: https://console.groq.com/docs

### Inspiration
- **Claude Code**: Production agent patterns
- **42 School**: Peer-learning pedagogy
- **LangChain**: Tool interface designs

---

## 🎯 Current Status

### ✅ Complete (Ready for Students)
- Module 00: Full subject, evaluation sheet, test system
- Module 01: Full subject, evaluation sheet, test system

### 📝 In Progress
- Modules 02-09: Subject outlines created, full content coming soon

---

## 🚀 Get Started Now

Ready to begin your journey?

```bash
# Read the full curriculum
cat CURRICULUM.md

# Start Module 00
cd module-00
cat subject.md

# Happy learning!
```

---

## 🙏 Acknowledgments

- **42 School** - Pedagogy and learning methodology
- **Claude Code** - Production agent patterns
- **Pydantic** - Beautiful validation and schemas
- **Open Source Community** - Standing on shoulders of giants

---

## 📄 License

Open source curriculum - free for educational use.

---

**Start your agent programming journey today!** 🚀

_Questions? Read CURRICULUM.md for complete details._
