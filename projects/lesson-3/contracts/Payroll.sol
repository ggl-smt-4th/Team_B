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

    uint constant payDuration = 30 days;
    uint public totalSalary = 0;
    mapping(address => Employee) public employees;

    modifier employeeExist(address employeeId){
        require(employees[employeeId].id != 0x0);
        _;
    }

    modifier employeeNotExist(address employeeId){
        require(employees[employeeId].id == 0x0);
        _;
    }

    function Payroll() payable public {
    }

    function addEmployee(address employeeId, uint salary)
    public
    onlyOwner
    employeeNotExist(employeeId)
    {
        employees[employeeId] = Employee(employeeId, salary.mul(1 ether), now);
        totalSalary = totalSalary.add(employees[employeeId].salary);
    }

    function removeEmployee(address employeeId)
    public
    onlyOwner
    employeeExist(employeeId)
    {
        _partialPaid(employees[employeeId]);
        delete employees[employeeId];
    }

    function changePaymentAddress(address oldAddress, address newAddress)
    public
    onlyOwner
    employeeExist(oldAddress)
    employeeNotExist(newAddress)
    {
        employees[newAddress] = Employee(newAddress, employees[oldAddress].salary, employees[oldAddress].lastPayday);
        delete employees[oldAddress];
    }

    function updateEmployee(address employeeId, uint salary) public {

        _partialPaid(employees[employeeId]);

        totalSalary = totalSalary.sub(employees[employeeId].salary);
        employees[employeeId].salary = salary.mul(1 ether);
        totalSalary = totalSalary.add(employees[employeeId].salary);
    }

    function addFund() payable public returns (uint) {
        return address(this).balance;
    }

    function calculateRunway() public view returns (uint) {
        return address(this).balance.div(totalSalary);
    }

    function hasEnoughFund() public view returns (bool) {
        return calculateRunway() > 0;
    }

    function getPaid() public employeeExist(msg.sender) {
        uint nextPayday = employees[msg.sender].lastPayday + payDuration;
        require(nextPayday < now);

        employees[msg.sender].lastPayday = nextPayday;
        msg.sender.transfer(employees[msg.sender].salary);
    }

    function _partialPaid(Employee storage employee) private employeeExist(employee.id) {
        uint payment = employee.salary.mul(now.sub(employee.lastPayday)).div(payDuration);
        employee.lastPayday = now;
        employee.id.transfer(payment);
    }
}
