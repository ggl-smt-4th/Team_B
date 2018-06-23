pragma solidity ^0.4.14;


contract Payroll {

    struct Employee {
    address id;
    uint salary;
    uint lastPayday;
    }

    //定值，支付薪水的时间间隔，
    uint constant payDuration = 30 days;

    //合约创建者的地址
    address owner;
    //员工合计的工资数，在add、update、remove的时候进行修改，优化calculateRunway方法调用gas消耗
    uint totalSalary;

    //所有员工的数组
    Employee[] employees;

    //构造函数，将合约创建人赋值给owner
    function Payroll() {
        owner = msg.sender;
    }

    //内部函数，清算支付某员工之前所有的薪水
    function _partialPaid(Employee employee) private {
        uint payment = employee.salary * (now - employee.lastPayday) / payDuration;
        employee.id.transfer(payment);
    }

    //从员工数组中找出指定ID（地址）的员工，没有找到则返回的Employee中的ID为0x0
    function _findEmployee(address employeeId) private returns (Employee, uint) {
        for (uint i = 0; i < employees.length; i++) {
            if (employees[i].id == employeeId) {
                return (employees[i], i);
            }
        }
    }

    //向员工数组中添加员工的地址、薪水等信息
    function addEmployee(address employeeAddress, uint salary) public {
        require(msg.sender == owner);

        var (employee, index) = _findEmployee(employeeAddress);

        assert(employee.id == 0x0);
        employees.push(Employee(employeeAddress, salary * 1 ether, now));
        totalSalary += salary * 1 ether;
    }

    //删除某个ID的员工
    function removeEmployee(address employeeId) public {
        require(msg.sender == owner);

        var (employee, index) = _findEmployee(employeeId);

        assert(employee.id != 0x0);
        _partialPaid(employee);
        totalSalary -= employees[index].salary;
        delete employees[index];
        employees[index] = employees[employees.length - 1];
        employees.length -= 1;
        return;

    }

    //更新某员工的数据，根据ID（地址）更新薪水和上次支付时间，需要先根据以前的工资水平清算支付以前的工资
    function updateEmployee(address employeeId, uint salary) public {
        require(msg.sender == owner);

        var (employee, index) = _findEmployee(employeeId);

        assert(employee.id != 0x0);
        _partialPaid(employee);
        totalSalary += salary * 1 ether - employees[index].salary;
        employees[index].salary = salary * 1 ether;
        employees[index].lastPayday = now;
        return;
    }

    //设置value，通过外部账户向合约账户中添加ether
    function addFund() payable public returns (uint) {
        return this.balance;
    }

    //计算合约地址中的ether还可以支付所有员工多少次工资：
    //优化前：通过遍历计算所有的员工的工资的和，然后除合约地址中的ether
    //优化后：通过状态变量totalSalary记录所有的工资的和，在add、update、remove的时候修改totalSalary的值
    function calculateRunway() public view returns (uint) {
        // uint totalSalary;
        // for (uint i = 0; i < employees.length; i++) {
        //     totalSalary += employees[i].salary;
        // }

        return address(this).balance / totalSalary;
    }

    //合约地址中是否有足够的钱支付员工工资
    function hasEnoughFund() public view returns (bool) {
        return calculateRunway() > 0;
    }

    //根据当前登录的员工的地址判断是否可以支付，以及支付该员工相对应数量ether的工资
    function getPaid() public {
        var (employee, index) = _findEmployee(msg.sender);

        assert(employee.id != 0x0);

        uint nextPayday = employee.lastPayday + payDuration;

        //当下次支付日期小于当前日期时才能执行支付代码
        assert(nextPayday < now);

        employee.lastPayday = nextPayday;
        employee.id.transfer(employee.salary);
    }
}

