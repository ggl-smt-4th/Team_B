pragma solidity 0.4.24;

import "./SafeMath.sol";


contract Payroll {
    using SafeMath for uint256;

    uint public constant PAY_DURATION = 30 days;

    address public owner;
    address public employee;
    uint public salary = 1 ether;
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

    constructor()
    public {
        owner = msg.sender;
    }

    function ()
    public
    payable
    {
        revert();
    }

    function addFund()
    external payable
    onlyOwner
    returns (uint)
    {
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

    function updateEmployeeAddress(
        address _newAddress
    )
    external
    onlyOwner
    {
        require(_newAddress != 0x0);

        address lastEmployee = employee;
        employee = _newAddress;
        /* solhint-disable not-rely-on-time */
        if (lastEmployee == 0x0) {
            lastPayday = now;
        } else {
            uint payment = salary.mul(now.sub(lastPayday).div(PAY_DURATION));
            lastPayday = now;

            if (payment > 0) {
                lastEmployee.transfer(payment);
                // solhint-disable-next-line not-rely-on-time
                emit OnPay(lastEmployee, payment, now);
            }
        }
        /* solhint-enable not-rely-on-time */

        emit OnUpdateEmployee(_newAddress);
    }

    function updateEmployeeSalary(
        uint _newSalary
    )
    external
    onlyOwner
    {
        require(_newSalary > 0);
        
        uint unpaidSalary = 0;
        /* solhint-disable not-rely-on-time */
        if (employee != 0x0 && lastPayday != 0) {
            unpaidSalary = salary.mul(now.sub(lastPayday).div(PAY_DURATION));
        }
        salary = _newSalary.mul(1 ether);

        // Pay unpaid salary based on old salary
        if (unpaidSalary > 0) {
            lastPayday = now;
            employee.transfer(unpaidSalary);
            emit OnPay(employee, unpaidSalary, now);
        }
        /* solhint-enable not-rely-on-time */

        emit OnUpdateSalary(_newSalary);
    }

    function withdraw(uint amount)
    external
    onlyOwner
    {
        require(amount <= address(this).balance);

        owner.transfer(amount);
        // solhint-disable-next-line not-rely-on-time
        emit OnWithdraw(amount, now);
    }

    function getEmployee()
    public
    view
    returns (address)
    {
        return employee;
    }

    function getSalary()
    public
    view
    returns (uint)
    {
        return salary;
    }

    function calculateRunway()
    public
    view
    returns (uint)
    {
        return address(this).balance.div(salary);
    }

    function hasEnoughFund()
    public
    view
    returns (bool)
    {
        return calculateRunway() > 0;
    }
}
