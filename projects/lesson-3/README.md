### 作业

1. 完成今天所开发的合约产品化内容

2. 增加 `changePaymentAddress()` 函数，更改员工的薪水支付地址，思考一下能否使用 modifier 整合某个功能

    * **复制 `projects/lesson-3/contracts/Payroll.sol.sample` 到 `projects/lesson-3/contracts/Payroll.sol` 并实现相关 TODO 处的代码**
    * 提交时请修改为 `payDuration = 30 days` 
    * 保持各 public 的函数名不变。

3. 加分题：自学 C3 Linearization, 求以下 contract Z 的继承线

    ```
    contract O
    contract A is O
    contract B is O
    contract C is O
    contract K1 is A, B
    contract K2 is A, C
    contract Z is K1, K2
    ```

对于非 Windows 用户，安装 docker 后，运行 `sh manager.sh run_tests` 可测试合约是否满足基本要求。

---

## 问题回答的非代码部分如下：

2.【思考一下能否使用 modifier 整合某个功能】：已经有“员工存在”的修饰语，同理，也可以有“员工不存在”的修饰语。虽然目前没有其他函数复用这个修饰语，但是依然可以提取出来。

3.在C3 Linearization中，merge操作是C3算法的核心。根据网上资料显示，遍历执行merge操作的序列，如果一个序列的第一个元素，是其他序列中的第一个元素，或不在其他序列出现，则从所有执行merge操作序列中删除这个元素，合并到当前的L中。

由此可得：

L(O) := [O]

L(A) := [A] + merge(L(O) + [O])

​	= [A] + merge([O] + [O])

​	= [A, O]

L(B) := [B, O]

L(C) := [C, O]

L(K1) := [K1] + merge(L(A) + L(B) + [A, B])

​	= [K1] + merge([A, O] + [B, O] + [A, B])

​	= [K1, A] + merge([O] + [B, O] + [B])

​	= [K1, A, B] + merge([O] + [O])

​	= [K1, A, B, O]

L(K2) := [K2] + merge(L(A) + L(C) + [A, C])

​	= [K2] + merge([A, O] + [C, O] + [A, C])

​	= [K2, A, C, O]

L(Z) := [Z] + merge(L(K1) + L(K2) + [K1, K2])

​	= [Z] + merge([K1, A, B, O] + [K2, A, C, O] + [K1, K2])

​	= [Z, K1] + merge([A, B, O] + [K2, A, C, O] + [K2])

​	= [Z, K1, K2] + merge([A, B, O] + [A, C, O])

​	= [Z, K1, K2, A] + merge([B, O] + [C, O])

​	= [Z, K1, K2, A, B] + merge([O] + [C, O])

​	= [Z, K1, K2, A, B, C, O] 