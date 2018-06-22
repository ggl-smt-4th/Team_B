2.
transaction execution 
23307       2035
24071       2799
24835       3563
25599       4327
26363       5091
27127       5855
27891       6619
28655       7383
29419       8147
30183       8911
随着员工的变多， transaction gas和execution gas都在上升，这是因为每一次caculate run way的时候， 我们都会整个遍历一遍整个员工数组，随着员工数量增加，消耗的资源将会线性增加。

3.设计一个全局变量叫total， 每次add员工或者update salary的时候同时update这个total变量，使得其等于总的员工salary，然后再caculatRunWay的时候，我们直接调用这个变量就好，而不用遍历整个数组求salary之和
