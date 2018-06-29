pragma solidity 0.4.19;

import "./SafeMath.sol";
import "./Ownable.sol";


// solhint-disable not-rely-on-time
contract Payroll is Ownable {

    using SafeMath for uint;

    struct Employee {
        address addr;
        uint salary;
        uint lastPayday;
    }

    uint public constant PAY_DURATION = 30 days;
    uint public constant SALARY_BASE = 1 ether;
    uint public totalSalary = 0;

    mapping (address => Employee) public employeeS;

    modifier onlyEmployee() {
        require(hasEmployee(msg.sender));
        _;
    }

    modifier mustHaveEmployee(address _addr) {
        require(hasEmployee(_addr));
        _;
    }

    event OnAddEmployee(address employee, uint salary);
    event OnRemoveEmployee(address employee);
    event OnUpdateAddress(address oldAddress, address newAddress);
    event OnUpdateSalary(address employee, uint salary);
    event OnAddFund(uint amount, uint indexed date);
    event OnPay(address indexed employee, uint amount, uint indexed date);

    function Payroll()
    public
    // solhint-disable-next-line no-empty-blocks
    payable {}

    function ()
    public
    payable
    {
        revert();
    }

    function calculateRunway()
    public
    view
    returns (uint)
    {
        return address(this).balance.div(totalSalary);
    }

    function hasEnoughFund()
    public
    view
    returns (bool)
    {
        return calculateRunway() > 0;
    }

    function addEmployee(address _addr, uint _salary)
    public
    onlyOwner
    {
        require(!hasEmployee(_addr));
        require(_addr != 0x0 && _salary > 0);

        uint salary = _salary.mul(SALARY_BASE);
        employeeS[_addr] = Employee(_addr, salary, now);
        totalSalary = totalSalary.add(salary);

        OnAddEmployee(_addr, salary);
    }

    function removeEmployee(address _addr)
    public
    onlyOwner
    mustHaveEmployee(_addr)
    {
        Employee memory employee = employeeS[_addr];
        totalSalary = totalSalary.sub(employee.salary);
        delete employeeS[_addr];

        uint months = unpaidMonths(employee.lastPayday);
        if (months > 0) {
            pay(employee, months);
        }

        OnRemoveEmployee(_addr);
    }

    function changePaymentAddress(address oldAddr, address newAddr)
    public
    onlyOwner
    mustHaveEmployee(oldAddr)
    {
        require(newAddr != 0x0);

        Employee storage employee = employeeS[oldAddr];
        employee.addr = newAddr;
        employeeS[newAddr] = employee;
        delete employeeS[oldAddr];

        OnUpdateAddress(oldAddr, newAddr);
    }

    function updateEmployee(address _addr, uint _salary)
    public
    onlyOwner
    mustHaveEmployee(_addr)
    {
        require(_salary > 0);

        Employee memory employee = employeeS[_addr];
        uint salary = _salary.mul(SALARY_BASE);

        totalSalary = totalSalary.sub(employee.salary).add(salary);
        employeeS[_addr].salary = salary;

        uint months = unpaidMonths(employee.lastPayday);
        if (months > 0) {
            employeeS[_addr].lastPayday = now;
            pay(employee, months);
        }

        OnUpdateSalary(_addr, salary);
    }

    function addFund()
    public
    payable
    onlyOwner
    returns (uint)
    {
        OnAddFund(msg.value, now);
        return address(this).balance;
    }

    function getPaid()
    public
    onlyEmployee()
    {
        uint months = unpaidMonths(employeeS[msg.sender].lastPayday);
        require(months > 0);

        employeeS[msg.sender].lastPayday = now;
        pay(employeeS[msg.sender], months);
    }

    function hasEmployee(address _addr)
    private
    view
    returns (bool)
    {
        return employeeS[_addr].addr != 0x0;
    }

    function unpaidMonths(uint lastPayday)
    private
    view
    returns (uint)
    {
        return now.sub(lastPayday).div(PAY_DURATION);
    }

    function pay(Employee employee, uint months)
    private
    {
        if (months > 0) {
            uint amount = employee.salary.mul(months);
            employee.addr.transfer(amount);

            OnPay(employee.addr, amount, now);
        }
    }
}
