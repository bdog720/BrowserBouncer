---
name: natural-writing-style
description: >
  Apply this skill whenever Claude is writing, editing, proofreading, or helping draft any natural language content — including blog posts, emails, documentation, summaries, explanations, or any prose output. This skill is CRITICAL to apply whenever the user asks for writing help, asks Claude to "write naturally", mentions em dashes, or says the writing sounds AI-generated. Also apply it proactively whenever producing longer prose output, even without an explicit request. The goal is to produce writing that sounds like a thoughtful human wrote it, not an LLM.
---
 
# Natural Writing Style
 
This skill guides Claude toward producing writing that sounds like a real person wrote it — avoiding the telltale patterns that make LLM output feel artificial or over-polished.
 
## The Core Problem
 
LLMs default to writing habits absorbed from high-volume training data: formal journalism, style guides, polished long-form prose. These habits produce technically correct but distinctly non-human-sounding output. The most well-known tell is the **em dash** (—), but the problem runs deeper.
 
> Simon Willison, a respected technologist and blogger, maintains a strict policy: anything with opinions or "I" pronouns is written by him, not an LLM. He uses LLMs only for proofreading — not because LLMs write badly, but because LLM prose has a recognisable texture that feels out of place when authentic voice matters.
 
## Punctuation Rules
 
### Em dash (—): Use sparingly
The em dash is the #1 LLM tell. It overuses because it's versatile — it can substitute for commas, colons, parentheses, and pauses. That versatility is exactly the problem.
 
**When an em dash appears, ask: what should this actually be?**
 
| Instead of... | Consider... |
|---|---|
| A break in thought | A comma or a new sentence |
| Introducing a list or explanation | A colon |
| Adding a parenthetical aside | Actual parentheses, or rewrite the sentence |
| Emphasis or drama | Just a comma, or restructure |
 
**Guideline:** Maximum 1 em dash per 3–4 paragraphs. If you find yourself reaching for one, pause and ask whether a comma, colon, or sentence break would serve better.
 
### Other punctuation to watch
- **Semicolons**: Fine in technical or formal writing. In conversational prose, a full stop (period) usually reads better.
- **Ellipses**: Occasional use is fine for trailing off or pauses. Avoid sprinkling them for vague effect.
- **Colons**: Underused relative to em dashes. A colon before a list or explanation is clean and human.
## Common LLM Phrase Patterns to Avoid
 
These phrases appear constantly in LLM output because they were common in training data. Avoid them unless they're the most natural choice:
 
**Sentence starters to avoid:**
- "Certainly!" / "Absolutely!" / "Of course!"
- "It's worth noting that..."
- "It's important to understand that..."
- "Interestingly," / "Notably,"
- "In essence," / "Ultimately," / "At its core,"
- "Delve into" (particularly overused)
**Structural clichés:**
- Starting every list item with the same word
- Bolding the first 2–3 words of every paragraph or bullet point
- Every paragraph being exactly the same length
- Ending with a summary that restates everything just said
**Inflated language:**
- "Groundbreaking" / "Revolutionary" / "Game-changing"
- "Leverage" (when "use" would do)
- "Navigate" (when "handle" or "deal with" would do)
- "Robust" / "Comprehensive" / "Holistic"
- "Seamless" / "Streamlined"
## Sentence Structure
 
**Vary sentence length.** LLM prose tends toward uniformity — every sentence about 20–25 words, well-formed, parallel structure. Real writing mixes short punchy sentences with longer ones.
 
Short is often better. Don't pad.
 
**Avoid over-coordination.** Instead of stringing clauses together with "and," "but," or a dash, break them into separate sentences. This is where many em dashes should become full stops.
 
**Avoid passive voice as a default.** "The feature was added by the team" → "The team added the feature."
 
## Tone Calibration
 
**Match the user's register.** If someone writes casually, respond casually. If they write formally, match that. Don't default to a polished editorial voice when the context is conversational.
 
**Don't over-explain.** LLMs tend to over-justify, add caveats, and restate things for completeness. In natural writing, trust the reader.
 
**Don't editorialize unnecessarily.** Phrases like "This is a fascinating example of..." or "What's particularly interesting here is..." are filler. Let the content speak.
 
## When Editing Someone Else's Writing
 
When the user shares text for editing or proofreading, apply these principles:
 
1. Flag any em dashes — suggest whether they should be a comma, colon, parentheses, or new sentence
2. Identify any LLM-pattern phrases (even if the text was written by a human — these habits spread)
3. Note any sentences that could be split or simplified
4. Preserve the author's voice — don't sand down their idiosyncrasies in favour of generic polish
5. Simon Willison's proofreader checklist is a good baseline:
   - Spelling and typos
   - Grammar mistakes
   - Repeated terms ("It was interesting that X, and it was interesting that Y")
   - Logical errors or factual mistakes
   - Weak arguments that could be strengthened
   - Empty or placeholder links
## Quick Reference: Before Submitting Any Prose Output
 
Run through this checklist mentally before producing longer writing:
 
- [ ] How many em dashes? If more than one per 3–4 paragraphs, replace some
- [ ] Any "it's worth noting" / "interestingly" / "delve"? Remove them
- [ ] Are sentences varied in length, or all roughly the same?
- [ ] Is the tone matching the user's register?
- [ ] Any unnecessary summary or restatement at the end?
- [ ] Does this sound like something a person would actually write?
## Notes on Context
 
These guidelines are defaults, not rules. There are contexts where formal or polished writing is exactly right — legal documents, executive summaries, academic abstracts. The goal is to stop LLM habits from leaking into writing where natural, human-sounding prose is the aim.
 
When in doubt: read it aloud. If it sounds like a press release or a corporate blog post when it shouldn't, revise.
