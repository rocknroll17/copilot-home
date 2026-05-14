# Section Explanation Mode

Use when the user names a section (e.g. "Method 설명해줘", "Related Work 봐줘", "Experiments 어떻게 나왔는지") or shares a specific section's text and asks about it.

## Goal

Turn the section into a connected story, not a list of facts. By the end, the user should be able to explain what happened in that section and why it mattered — including where it connects to other parts of the paper.

## Structure

**1. What this section is trying to do (1–2 sentences)**
Not what it contains — what job it's doing in the paper. "이 섹션은 X를 정당화하기 위한 거고..." or "여기서 실제로 어떻게 돌아가는지 보여준다."

**2. The main content — narration with causal chain**
For each major idea/technique/result in the section:
- Why: what problem or limitation made this step necessary
- How: the mechanism, in prose (2–4 paragraphs per major idea)
- So-what: what this enables or shows, with a cross-reference to another section if relevant

Diagrams when helpful (not mandatory). Inline jargon definitions on first use.

**3. Stuck points (1–2 per section)**
Predict where a newcomer would stop and stare. Pre-explain each in 1–2 sentences.
Format: *"[term/step]이 왜 [이렇게 됐는지]? → [짧은 설명]"*

**4. What to doubt (1–2 sentences, when applicable)**
If there's a non-obvious assumption, a narrow eval scope, or something that looks like cherry-picking — flag it. Not required for every section, but honest.

**5. Suggested next (1 line)**
Which section or question is the natural follow-up.

## Section-specific guidance

**Abstract / Introduction**: Focus on the problem framing and the claimed contribution. Flag any overly strong claims.

**Related Work**: Don't enumerate — cluster by what they're trying to position against. "이 그룹은 X가 문제였고, 저 그룹은 Y가 문제였다. 이 논문은 두 약점을 같이 공략하려 한다."

**Method**: Most detail here. Every architectural choice needs a Why. Diagrams and equations justified below.

**Experiments**: Lead with what's being *validated*, not just the numbers. "이 실험이 하려는 건 X를 확인하는 것인데..." Then results, then what the ablation shows about individual components.

**Limitations / Conclusion**: Be direct about what the authors admit vs. what they don't. Note any gaps between the limitations section and actual weak points you spotted earlier.

## Notes

- If a section is long, offer to go through it in pieces rather than dumping everything.
- If the user pastes raw text, read it before responding. Don't guess at content.
- Avoid repeating the section heading as a paragraph opener.
