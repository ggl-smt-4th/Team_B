### 作业

1. 完成今天所开发的合约产品化内容
代码请查看Payroll.sol
运行各函数截图见019-王波-wngbob-lesson3-函数调用截图.docx

2. 增加 `changePaymentAddress()` 函数，更改员工的薪水支付地址，思考一下能否使用 modifier 整合某个功能
changePaymentAddress() 见Payroll.sol
使用modifier整合了_partialPay函数功能，具体实现请查看Payroll.sol

3. 加分题：自学 C3 Linearization, 求以下 contract Z 的继承线
Given：
class O
class A extends O
class B extends O
class C extends O
class K1 extends A, B
class K2 extends A, C
class Z extends K1, K2

the linearization of Z is computed as：
L(O)  := [O]                                              

L(A)  := [A] + merge(L(O), [O])                           
       = [A] + merge([O], [O])
       = [A, O]                                             

L(B)  := [B, O]                                             
L(C)  := [C, O]

L(K1) := [K1] + merge(L(A), L(B), [A, B])          
       = [K1] + merge([A, O], [B, O], [A, B])    
       = [K1, A] + merge([O], [B, O], [B])       
       = [K1, A, B] + merge([O], [O])                        
       = [K1, A, B, O]

L(K2) := [K2] + merge(L(A), L(C), [A, C])          
       = [K2] + merge([A, O], [C, O], [A, C])    
       = [K2, A] + merge([O], [C, O], [C])       
       = [K2, A, C] + merge([O], [O])                        
       = [K2, A, C, O]

L(Z)  := [Z] + merge(L(K1), L(K2), [K1, K2])
       = [Z] + merge([K1, A, B, O], [K2, A, C, O], [K1, K2])   
       = [Z, K1] + merge([A, B, O], [K2, A, C, O], [K2])
       = [Z, K1, K2] + merge([A, B, O], [A, C, O])
	   = [Z, K1, K2, A] + merge([B, O], [C, O])	   
	   = [Z, K1, K2, A, B, C] + merge([O], [O])
	   = [Z, K1, K2, A, B, C, O]   

