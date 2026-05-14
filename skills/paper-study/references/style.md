# Writing Style

## The core constraint

말하듯이 쓴다. 브리핑 모드 — 잘 준비한 동료가 보고하는 것처럼. 강의가 아니라 대화.

## Prose vs structure

**Default: prose.** Use bullets or tables only when:
- 4+ genuinely parallel items where the parallelism itself is the point
- A direct 2-axis comparison (method A vs method B across dimensions)
- A symbol table (equation walkthrough only)

Everything else: paragraphs.

**Bad:**
> • ViT 사용
> • contrastive loss 적용
> • SOTA 달성

**Good:**
> "ViT(Vision Transformer — 이미지를 패치로 잘라 Transformer에 넣는 구조)로 입력을 인코딩한다. 왜 ViT? convolution은 인접 픽셀만 보지만 attention은 전체를 본다 — 멀리 떨어진 관계가 중요한 이 태스크에 더 맞는다. 여기에 contrastive loss를 얹어 유사한 쌍을 가깝게, 다른 쌍을 멀게 밀어낸다. 결과적으로 기존 SOTA 대비 일관된 개선이 나타난다 (§5, Table 2)."

## Causal chain

모든 주요 주장/기법에 이 3박자를 쓴다:
1. **Why** — 어떤 한계나 문제 때문에 이게 필요했나 (1–2문장)
2. **How** — 메커니즘 (산문, 필요하면 다이어그램 보조)
3. **So-what** — 그래서 뭐가 달라졌나 + 다른 섹션 cross-reference 1번

인과 접속어를 아끼지 말 것: "그래서 / 왜냐하면 / 그 결과 / 따라서 / 만약 ~였다면".

## Jargon

**첫 등장**: 짧은 정의 + 직관적 비유를 인라인으로. 괄호나 대시로.
> "SMAL(동물 3D 형태 모델 — 41종 figurine을 PCA로 압축한 것. β 41개가 각각 '사자 느낌', '말 느낌' 같은 방향을 잡는다)을 기반으로..."

**두 번째부터**: 그냥 쓴다. 재정의 없음.

**논문 밖 개념**: 검색으로 1–2문장 배경 확보 후 `(논문 밖)` 태그.

**금지**: 전문용어 연속 나열. ("ViT encoder와 Transformer decoder와 contrastive loss가...") → 쪼개거나 흐름 속에 묻기.

## Citations

| 위치 | 형식 |
|---|---|
| 논문 내 | `(§3.C)`, `(Eq. 4)`, `(Fig. 2)`, `(Table IV, p.10)` |
| 논문 밖 | `(논문 밖)` + URL 가능하면 추가 |
| 추정 | `[추정]` 명시 |
| 논문에 없는 결과/수식 창작 | **금지** |

## Length

- 150–200 단어 넘으면 소제목으로 분절.
- 복잡한 개념은 점진적으로: 직관 한 문장 → 메커니즘 설명 → 정밀 기술. 모두 필요할 때만.

## Forbidden patterns

- "~에 대해 설명드리겠습니다" 같은 예고 문장
- "정리하자면", "결론적으로"로 문단 시작
- 묻지 않은 내용 여러 문단 추가 (1줄 제안은 OK)
- Bullet-only 서술 (서사 없이 점만 찍기)
- "좋은 질문입니다", "이해했습니다" 같은 서론
- 논문에 없는 결과나 수식 창작
