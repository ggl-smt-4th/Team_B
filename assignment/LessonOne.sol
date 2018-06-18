pragma solidity 0.4.24;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";


contract Payroll {
    using SafeMath for uint256;

    uint public constant PAY_DURATION = 30 days;

    address public owner;
    address public employee;
    bytes32 public employeeName;
    uint public salary;
    uint public lastPayday;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier onlyEmployee() {
        require(msg.sender == employee);
        _;
    }

    event OnUpdateEmployee(address employee);
    event OnUpdateSalary(uint salary);
    event OnAddFund(uint fund, uint indexed date);
    event OnPay(address employee, uint amount, uint indexed date);
    event OnWithdraw(uint amount, uint indexed date);

    constructor(address _employee, bytes32 _employeeName, uint _salary)
    public {
        require(_employee != 0x0 && _employeeName != "" && _salary > 0);

        owner = msg.sender;
        employee = _employee;
        employeeName = _employeeName;
        salary = _salary.mul(1 finney);
        // solhint-disable-next-line not-rely-on-time
        lastPayday = now;
    }

    function ()
    public payable {
        revert();
    }

    function addFund()
    external payable
    onlyOwner
    returns (uint) {
        // solhint-disable-next-line not-rely-on-time
        emit OnAddFund(msg.value, now);
        return address(this).balance;
    }

    function getPaid()
    external
    onlyEmployee
    {
        uint nextPayday = lastPayday.add(PAY_DURATION);
        // solhint-disable-next-line not-rely-on-time
        require(nextPayday < now);

        lastPayday = nextPayday;
        employee.transfer(salary);

        // solhint-disable-next-line not-rely-on-time
        emit OnPay(employee, salary, now);
    }

    function updateEmployeeAndSalary(
        address _employee,
        bytes32 _employeeName,
        uint _salary
    )
    external
    onlyOwner {
        address lastEmployee = employee;
        /* solhint-disable not-rely-on-time */
        uint payment = salary.mul(now.sub(lastPayday).div(PAY_DURATION));
        lastPayday = now;
        /* solhint-enable not-rely-on-time */

        updateEmployee(_employee, _employeeName);
        updateSalary(_salary);

        if (payment > 0) {
            lastEmployee.transfer(payment);
            // solhint-disable-next-line not-rely-on-time
            emit OnPay(lastEmployee, payment, now);
        }
    }

    function withdraw(uint amount)
    external
    onlyOwner {
        require(amount <= address(this).balance);

        owner.transfer(amount);
        // solhint-disable-next-line not-rely-on-time
        emit OnWithdraw(amount, now);
    }

    function updateEmployee(address _employee, bytes32 _employeeName)
    public
    onlyOwner {
        require(_employee != 0x0 && _employeeName != "");

        employee = _employee;
        employeeName = _employeeName;

        emit OnUpdateEmployee(_employee);
    }

    function updateSalary(uint _salary)
    public
    onlyOwner {
        require(_salary > 0);

        // ether base is too big
        salary = _salary.mul(1 finney);
        

        emit OnUpdateSalary(_salary);
    }

    function calculateRunway()
    public view
    returns (uint) {
        return address(this).balance / salary;
    }

    function hasEnoughFund()
    public view
    returns (bool) {
        return calculateRunway() > 0;
    }
}
