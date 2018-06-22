依次加入十个employee，运行calculateRunway(),transaction cost gas 和 execution cost gas依次变化为：
22952	1680
23733	2461
24514	3242
25295	4023
26076	4804
26857	5585
27638	6366
28419	7147
29200	7928
29981	8709

calRunway 函数的优化思路：
观察发现，每次运行calRunway 函数，都会重新遍历employees数组，汇总工资。
可以考虑增加一个totalSalary状态变量，保存当前所有员工的工资汇总。
这样运行calRunway 函数的gas会较少，并且gas cost不会随着employees数组变大而变大。
修改之后，一部分gas cost会转移到，新的totalSalary状态变量的存储gas cost，updateEmployee/addEmployee/removeEmployee 中修改totalSalary状态变量的gas cost。
但总体上，gas cost会减少

优化之后，重新测试第一步，依次加入十个employee，运行calculateRunway(),transaction cost gas 和 execution cost gas固定为：
22110	838
