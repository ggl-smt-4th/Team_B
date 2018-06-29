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

    mapping(address => Employee) employees;
    uint constant payDuration = 30 days;
    uint public totalSalary = 0;

    modifier employeeExist(address employeeId) {
        Employee employee = employees[employeeId];
        assert(employee.id != 0x0);
        _;
    }

    modifier employeeNotExist(address employeeId) {
        Employee employee = employees[employeeId];
        assert(employee.id == 0x0);
        _;
    }

    function _partialPaid(Employee employee) private {
        uint payment = employee.salary.mul(now.sub(employee.lastPayday)).div(payDuration);
        employee.id.transfer(payment);
    }

    function Payroll() payable public {
        owner = msg.sender;
    }

    function addEmployee(address employeeId, uint salary) onlyOwner employeeNotExist(employeeId) public {
        employees[employeeId] = Employee(employeeId, salary.mul(1 ether), now);
        totalSalary = totalSalary.add(salary.mul(1 ether));
    }

    function removeEmployee(address employeeId) onlyOwner employeeExist(employeeId) public {
        var employee = employees[employeeId];
        _partialPaid(employee);
        totalSalary = totalSalary.sub(employees[employeeId].salary);
        delete(employees[employeeId]);
    }

    function changePaymentAddress(address oldAddress, address newAddress)
        onlyOwner
        employeeExist(oldAddress)
        employeeNotExist(newAddress)
        public {
        employees[newAddress] = Employee(newAddress, employees[oldAddress].salary, employees[oldAddress].lastPayday);
        delete employees[oldAddress];
    }

    function updateEmployee(address employeeId, uint salary) onlyOwner employeeExist(employeeId) public {
        var employee = employees[employeeId];
        _partialPaid(employee);
        uint newSalary = salary.mul(1 ether);
        totalSalary = totalSalary.sub(employees[employeeId].salary).add(newSalary);
        employees[employeeId].salary = newSalary;
        employees[employeeId].lastPayday = now;
    }

    function addFund() payable public returns (uint) {
        return address(this).balance;
    }

    function calculateRunway() public view returns (uint) {
        return this.balance.div(totalSalary);
    }

    function hasEnoughFund() public view returns (bool) {
        return calculateRunway() > 0;
    }

    function getPaid() employeeExist(msg.sender) public {
        Employee employee = employees[msg.sender];
        uint nextPayday = employee.lastPayday.add(payDuration);
        assert(nextPayday <= now);

        employees[msg.sender].lastPayday = nextPayday;
        employee.id.transfer(employee.salary);
    }
}
