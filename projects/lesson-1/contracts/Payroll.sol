pragma solidity ^0.4.14;

contract Payroll {
    uint salary = 1 ether;
    address owner;
    address employee = 0xca35b7d915458ef540ade6068dfe2f44e8fa733c;
    uint constant payDuration = 30 days;
    uint lastPayday = now;

    function Payroll() {
        owner = msg.sender;
    }

    function addFund() payable returns (uint) {
        return this.balance;
    }

    function calculateRunway() returns (uint) {
        return this.balance / salary;
    }

    function hasEnoughFund() returns (bool) {
        return calculateRunway() > 0;
    }

    function getSalary() returns (uint) {
        return salary;
    }

    function getEmployeeAddress() returns (address) {
        return employee;
    }

    function updateEmployeeAddress(address e) {
        require(msg.sender == owner);

        employee = e;
    }

    function updateEmployeeSalary(uint s) {
        require(msg.sender == owner);

        salary = s * 1 ether;
    }


    function getPaid() {
        require(msg.sender == employee);

        uint nextPayDay = lastPayday + payDuration;
        require(nextPayDay <= now);

        lastPayday = nextPayDay;
        employee.transfer(salary);
    }
}
