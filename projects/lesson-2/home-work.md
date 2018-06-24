Gas Consumption Tracking:

 每次所用的gas会更加， 因为每次 增加员工都会用到_findEmployee方程，这个方程每次所需要便利的员工数组长度会增加。
 calculateRunway 也是每次需要便利员工数组，数组长度每次都会增加。

添加100ETH
 transaction cost 	21921 gas 
 execution cost 	649 gas 

 adding 1st employee:
"0x14723a09acff6d2a60dcdf7aa4aff308fddc160c",1
transaction cost 	104834 gas 
 execution cost 	81962 gas

calculateRunway():
transaction cost 	22974 gas 
 execution cost 	1702 gas


 adding 2nd employee:
"0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2db",1
 transaction cost 	90675 gas 
 execution cost 	67803

calculateRunway():
 transaction cost 	23755 gas 
 execution cost 	2483 gas 


  adding 3rd employee:
"0x583031d1113ad414f02576bd6afabfb302140225",1
 transaction cost 	91516 gas 
 execution cost 	68644 gas

calculateRunway():
 transaction cost 	24536 gas (Cost only applies when called by a contract)
 execution cost 	3264 gas (Cost only applies when called by a contract)



  adding 4th employee:
"0xdd870fa1b7c4700f2bd7f44238821c26f7392148",1
transaction cost 	92357 gas 
 execution cost 	69485 gas 

calculateRunway():
transaction cost 	25317 gas (Cost only applies when called by a contract)
 execution cost 	4045 gas (Cost only applies when called by a contract)


 adding 5th employee:
"0x89b5ea0ca8f7856feae957819f667ab5c134f6f3",1
 transaction cost 	93198 gas 
 execution cost 	70326 gas

calculateRunway():
 transaction cost 	26098 gas (Cost only applies when called by a contract)
 execution cost 	4826 gas (Cost only applies when called by a contract)


  adding 6th employee:
"0x5aeb875aacddc0578d2e3dc1736fb02835aee6fc",1
 transaction cost 	94039 gas 
 execution cost 	71167 gas 

calculateRunway():
transaction cost 	26879 gas (Cost only applies when called by a contract)
 execution cost 	5607 gas


  adding 7th employee:
"0xb18988700f665962004a55ed2290589600c72d71",1
 transaction cost 	94752 gas 
 execution cost 	72008 gas 

calculateRunway():
 transaction cost 	27660 gas (Cost only applies when called by a contract)
 execution cost 	6388 gas 

   adding 8th employee:
"0xdbbb3e0750aa090c0d6b800b5b6caddd5a4ea589",1
transaction cost 	95721 gas 
 execution cost 	72849 gas

calculateRunway():
 transaction cost 	28441 gas (Cost only applies when called by a contract)
 execution cost 	7169 gas 


   adding 9th employee:
"0x164a18f058f6d8f8a5df9ca64b1eb36550c037d5",1
transaction cost 	96562 gas 
 execution cost 	73690 gas

calculateRunway():
 transaction cost 	29222 gas (Cost only applies when called by a contract)
 execution cost 	7950 gas 

   adding 10th employee:
"0x21267fbb60903d3798f801e5d296c175d6777571",1
transaction cost 	97403 gas 
 execution cost 	74531 gas 

calculateRunway():
 transaction cost 	30003 gas (Cost only applies when called by a contract)
 execution cost 	8731 gas 


优化calculateRunway函数：
把totalSalary作为状态变量，在每次 updateEmployee 和addEmployee的时候都计算员工们所需要的所有的工资，这样计算计算calculateRunway()
的时候就不需要便利所有员工的工资来计算totalSalary. 



