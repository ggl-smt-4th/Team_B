### Gas 变化记录


| 员工数量 | 计算消耗 |
| ------- | ------ |
| 1       | 1702   |
| 2       | 2483   |
| 3       | 3264   |
| 4       | 4045   |
| 5       | 4826   |
| 6       | 5607   |
| 7       | 6388   |
| 8       | 7169   |
| 9       | 7950   |
| 10      | 8731   |

### 原因分析
每增加一个员工，便增加一次遍历，每次循环额外消耗781Gas，详情如下

|STEP|OP|GAS消耗|总消耗|
|--|--|-------|----|
1|DUP|3|3|
2|DUP|3|6|
3|PUSH|3|9|
4|ADD|3|12|
5|SWAP|3|15|
6|POP|2|17|
7|POP|2|19|
8|PUSH|3|22|
9|JUMP|8|30|
10|JUMPDEST|1|31|
11|PUSH|3|34|
12|DUP|3|37|
13|SLOAD|200|237|
14|SWAP|3|240|
15|POP|2|242|
16|DUP|3|245|
17|LT|3|248|
18|ISZERO|3|251|
19|PUSH|3|254|
20|JUMPI|10|264|
21|PUSH|3|267|
22|DUP|3|270|
23|DUP|3|273|
24|SLOAD|200|473|
25|DUP|3|476|
26|LT|3|479|
27|ISZERO|3|482|
28|ISZERO|3|485|
29|PUSH|3|488|
30|JUMPI|10|498|
31|JUMPDEST|1|499|
32|SWAP|3|502|
33|PUSH|3|505|
34|MSTORE|3|508|
35|PUSH|3|511|
36|PUSH|3|514|
37|SHA3|36|550|
38|SWAP|3|553|
39|PUSH|3|556|
40|MUL|5|561|
41|ADD|3|564|
42|PUSH|3|567|
43|ADD|3|570|
44|SLOAD|200|770|
45|DUP|3|773|
46|ADD|3|776|
47|SWAP|3|779|
48|POP|2|781|

### 解决方案

维护全局变量 `totalSalary` ，在每次增加删除员工以及薪水变动时更新 `totalSalary`，函数`calculateRunway`中直接使用该变量计算即可

```solidity
function calculateRunway() public view returns (uint) {
	return this.balance / totalSalary;
}
```
