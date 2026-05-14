---
name: deep-explain
description: 'Deep concept explanation mode for genuinely hard concepts — architecture, algorithms, mathematical formulations, or any mechanism where a flat explanation fails. Delivers a structured walkthrough: problem origin → structural overview → causal chain → concrete example → stuck points. All responses in Korean.'
argument-hint: 'the concept, mechanism, or term to explain deeply'
---

# Deep Explain

Use this skill when a concept is genuinely hard — not just unfamiliar, but structurally complex. The goal is not to list what a concept *is*, but to build an understanding of *why it had to exist* and *how its pieces connect causally*. By the end, the user should be able to explain it back.

## Procedure

Follow these five steps in order. Do not skip or reorder them.

---

### 1. Problem origin (2–4 sentences)

Start here. Do not introduce the concept yet.

Describe the world *before* this concept existed: what problem was unsolvable, what limitation kept appearing, what broke down when people tried the obvious thing. Frame it concretely — a specific scenario, not a general "there was a challenge."

> "이 개념이 없었을 때 어떤 상황이었냐면..." 으로 시작한다. 개념 이름은 2단계까지 미룬다.

Why: A concept without its problem is a word without meaning. The problem is what gives the concept its shape — it explains every design decision that follows.

---

### 2. One-sentence structural overview

Now name the concept and give the top-level answer in a single sentence.

This is the map before the terrain. It should be short enough to hold in one breath and concrete enough that the user could repeat it to someone else.

> 예: "Attention mechanism은 '입력 전체를 평균내는 대신, 각 위치가 다른 위치를 얼마나 봐야 할지 직접 계산해서 가중합하는' 방식이다."

If the concept has multiple components, name them here in order of dependency (not alphabetical, not importance — *dependency*). This becomes the spine for Step 3.

---

### 3. Causal chain through the components

Work through each component in the dependency order from Step 2. For each:

- **Why this piece**: What failed or was missing before this piece was introduced?
- **How it works**: Mechanism in prose. No bullet lists for sequential logic — write it as a flow, each sentence leading into the next.
- **What it enables**: What does having this piece make possible that wasn't before?

Cross-references between components are required when they interact. "이게 가능한 건 앞에서 X를 이렇게 정의했기 때문이다" — make the dependency explicit.

Length: 2–4 paragraphs per major component. If a concept has 6+ components, group related ones.

---

### 4. Concrete example

Pick the smallest, most familiar scenario where this concept does something visible and different from the naive approach.

Do not use the canonical textbook example if a more intuitive one exists. The example should make the causal chain from Step 3 *tangible* — the user should be able to trace which part of the example corresponds to which piece of the mechanism.

End the example with a one-sentence "이 예시에서 X가 Y를 했기 때문에 Z가 가능했다" — closing the loop.

---

### 5. Stuck points (1–3 items)

Predict where a newcomer would stop and re-read. Pre-explain each in 2–3 sentences.

Format: *"[용어/단계]이 헷갈릴 수 있는데 → [짧은 해소]"*

Choose stuck points that are genuinely non-obvious — not vocabulary, but conceptual knots. Especially useful: places where intuition from a simpler domain leads in the wrong direction.

---

## Output rules

- **Korean throughout.** Technical terms may remain in English if they're used as proper nouns (e.g., softmax, residual connection), but explanatory prose is Korean.
- **Prose over bullets** for any sequential or causal content. Use bullets only for parallel items where order doesn't matter.
- **No summaries at the end.** The structure itself *is* the summary. Adding "요약하면" at the end signals the explanation wasn't clear enough.
- **No hedges like "쉽게 말하면"** before an analogy — just give the analogy directly. Hedging signals that the simpler version might not be accurate; commit to the simplification.
- **Cite the source** if this comes from a paper or specific document: `(§3.2)`, `(Algorithm 1)`, `(논문 밖 — 배경지식)`.

## When the concept has sub-skills

If the user asks to go deeper on a specific component after this walkthrough, treat that follow-up as a new invocation of this skill on the sub-component. Don't append more detail to the original explanation — restart from Step 1 for the narrower scope.
