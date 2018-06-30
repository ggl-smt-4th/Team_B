pragma solidity ^0.4.14;


import './SafeMath.sol';
import './Ownable.sol';


contract Payroll is Ownable {

    using SafeMath for uint;

    struct Employee {
        address id;
        uint salary;
        uint lastPayday;
    }

    //所有员工的mapping
    mapping (address => Employee) public employees;

    // uint constant payDuration = 10 seconds;    //test
    //定值，支付薪水的时间间隔
    uint constant payDuration = 30 days;

    //员工合计的工资数，在add、update、remove的时候进行修改，优化calculateRunway方法调用gas消耗
    uint public totalSalary = 0;

    //构造函数
    function Payroll() payable {
    }

    //内部函数，清算支付某员工之前所有的薪水
    function _patialPaied(Employee employee) private {
        var payment = employee.salary.mul((now.sub(employee.lastPayday))).div(payDuration);
        employee.id.transfer(payment);
    }

    //修饰语，员工存在于公司的员工的mapping
    modifier employeeExist(address employeeId) {
        var employee = employees[employeeId];
        assert(employee.id != 0x0);
        _;
    }

    //修饰语，员工不存在于公司的员工的mapping
    modifier employeeNotExist(address employeeId) {
        var employee = employees[employeeId];
        assert(employee.id == 0x0);
        _;
    }

    //向员工mapping中添加员工的地址、薪水等信息
    function addEmployee(address employeeId, uint salary) public onlyOwner employeeNotExist(employeeId) {
        employees[employeeId] = Employee(employeeId, salary.mul(1 ether), now);
        totalSalary = totalSalary.add(salary.mul(1 ether));
    }

    //从员工mapping中删除某个ID的员工
    function removeEmployee(address employeeId) public onlyOwner employeeExist(employeeId) {
        var employee = employees[employeeId];
        totalSalary = totalSalary.sub(employee.salary);
        _patialPaied(employee);
        delete employees[employeeId];
    }

    //修改员工接收薪水的地址，仅限合约创建者修改
    function changePaymentAddress(address oldAddress, address newAddress) public onlyOwner employeeExist(oldAddress) {
        var employee = employees[oldAddress];
        employees[newAddress] = Employee(newAddress, employee.salary, employee.lastPayday);
        delete employees[oldAddress];
    }

    //更新某员工的数据，根据ID（地址）更新薪水和上次支付时间，需要先根据以前的工资水平清算支付以前的工资
    function updateEmployee(address employeeId, uint salary) public onlyOwner employeeExist(employeeId) {
        var employee = employees[employeeId];

        totalSalary = totalSalary.add((salary.mul(1 ether)).sub(employee.salary));
        employees[employeeId].salary = salary.mul(1 ether);
        employees[employeeId].lastPayday = now;
        _patialPaied(employee);
    }

    //设置value，通过外部账户向合约账户中添加ether
    function addFund() payable public returns (uint) {
        return address(this).balance;
    }

    //计算合约地址中的ether还可以支付所有员工多少次工资
    function calculateRunway() public view returns (uint) {
        return address(this).balance.div(totalSalary);
    }

    //合约地址中是否有足够的钱支付员工工资
    function hasEnoughFund() public view returns (bool) {
        return calculateRunway() > 0;
    }

    //根据当前登录的员工的地址判断是否可以支付，以及支付该员工相对应数量ether的工资
    function getPaid() public employeeExist(msg.sender) {
        var employee = employees[msg.sender];

        uint nextPayday = employee.lastPayday.add(payDuration);

        assert(nextPayday < now);
        employee.lastPayday = nextPayday;
        employee.id.transfer(employee.salary);
    }
}
