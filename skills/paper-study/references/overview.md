# Overview Mode

Use when the user first engages with a paper and asks something like "이 논문이 뭔지", "뭘 주장하는 건지", "한 줄 요약해줘", or shares a paper without a specific question.

## Goal

Give the user a mental map before they dive in — not a summary, but a frame. After reading this, they should know: what problem the paper attacks, what the core bet is, and whether the result holds up.

## Structure

**1. The problem (1–2 sentences)**
What situation or limitation motivates this paper? Be concrete — name the bottleneck, not just the field.

**2. The core idea (1–3 sentences)**
What is the paper's bet? What do they do differently? This is the contribution at its sharpest — not the full method, just the key move.

**3. How they know it works (1–2 sentences)**
What kind of evidence? (benchmark, ablation, user study, theoretical proof) Calibrate confidence — "shows strong results on X" vs "suggests".

**4. The catch (1 sentence, optional but usually honest)**
What's the main limitation or assumption? Scope restriction, compute cost, narrow eval set, etc. If obvious from the abstract/intro, mention it here.

**5. Suggested next (1 line)**
Which section would be most valuable to look at first, given the user's apparent interest.

## Example tone

> "이 논문은 dense video captioning — 영상에서 여러 사건을 동시에 찾아 설명하는 문제를 다룬다. 기존 방법들은 사건 탐지와 캡션 생성을 따로 학습했는데, 이 논문의 핵심 베팅은 둘을 하나의 트랜스포머로 같이 풀면 서로가 서로를 도울 수 있다는 것이다. ActivityNet Captions에서 SOTA를 찍으면서 그 주장이 실험으로 뒷받침된다. 다만 긴 영상에서는 아직 약하다고 스스로 인정한다."

## Notes

- Don't mention every section or dataset name in the overview — it creates noise before the user has context.
- If the user has domain expertise, skip the field-level explanation and go straight to the novelty.
- If the paper has an unusual structure (position paper, survey, dataset paper), adapt: replace "core idea" with the paper's actual contribution type.
