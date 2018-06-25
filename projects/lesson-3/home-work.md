# Lesson 3

## C3 Linearization

Question:

```solidity
contract O
contract A is O
contract B is O
contract C is O
contract K1 is A, B
contract K2 is A, C
contract Z is K1, K2
```

Answer:

L(A) := [A] + (L(O), [O]) = [A, O]

L(B) := [B] + (L(O), [O]) = [B, O]

L(C) := [C] + (L(O), [O]) = [C, O]

L(K1):= [K1] + (L(A), L(B), [A, B])
= [K1] + ([A, O], [B, O], [A, B])
= [K1, A] + ([O], [B, O], [B])
= [K1, A, B] + ([O], [O])
= [K1, A, B, O]

L(K2):= [K2] + (L(A), L(C), [A, C])
= [K2] + ([A, O], [C, O], [A, C])
= [K2, A] + ([O], [C, O], [C])
= [K2, A, C] + ([O], [O])
= [K2, A, C, O]

L(Z) := [Z] + (L(K1), L(K2))
= [Z] + ([K1, A, B, O], [K2, A, C, O], [K1, K2])
= [Z, K1] + ([A, B, O], [K2, A, C, O], [K2])
= [Z, K1, K2] + ([A, B, O], [A, C, O])
= [Z, K1, K2, A] + ([B, O], [C, O])
= [Z, K1, K2, A, B] + ([O], [C, O])
= [Z, K1, K2, A, B, C] + ([O], [O])
= [Z, K1, K2, A, B, C, O]
