# Equation Walkthrough Mode

Use when the user pastes or points to a specific equation and asks what it means, how to read it, or why it's written that way.

## Goal

The user should finish the walkthrough able to: (a) say in one sentence what the equation computes, (b) name every symbol without looking, (c) know when it breaks.

## Structure

**1. What this equation does (1 sentence)**
A plain-language description before showing any math. Not the formal definition — the job it performs.

> "이 식은 예측값과 정답 사이의 거리를 재는데, 단순히 빼는 게 아니라 학습 상황에 따라 가중치를 바꾸면서 잰다."

**2. Symbol table**
One line per symbol: name → what it represents in this paper's context (not the general mathematical definition).

```
α   — 학습률 (learning rate). 각 step에서 가중치를 얼마나 움직일지.
L   — 전체 loss. 낮을수록 예측이 정답에 가깝다.
∇   — 기울기 (gradient). 어느 방향으로 움직여야 L이 줄어드는지.
```

**3. How it flows (optional, for non-trivial equations)**
ASCII diagram showing what goes in, what operation happens, what comes out. Keep it simple — boxes and arrows.

```
[x, y] ─→ [encoder] ─→ z ─→ [식 적용] ─→ loss 값
```

**4. Counterfactual (1–2 sentences)**
What would break or change if one key term were removed or altered? This forces engagement with why each part is there.

> "여기서 log를 빼면 작은 확률에 대한 패널티가 사라진다. 모델이 확신 없이 답해도 loss가 크게 안 올라가니까 학습 신호가 약해진다."

**5. Small numeric example (optional, when concrete numbers help)**
Plug in tiny values to show the computation. Doesn't have to be realistic — just enough to trace through once.

> "x=0.9, y=1이면: loss = −log(0.9) ≈ 0.105. x=0.1이면: loss = −log(0.1) ≈ 2.3. 확신이 낮을수록 패널티가 급격히 커진다."

## Notes

- Steps 3–5 are optional — use judgment. A simple L2 loss doesn't need a 5-block treatment. A custom attention mechanism does.
- If the equation references other equations in the paper, connect them: "이 식의 z는 Eq.(3)에서 나온 거다."
- Don't derive the equation from scratch unless asked. The goal is understanding, not a textbook proof.
- If the equation is from external literature (not derived in the paper), note it: `(논문 밖)` and briefly explain the source context.
