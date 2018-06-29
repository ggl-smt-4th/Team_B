pragma solidity ^0.4.14;

import './SafeMath.sol';
import './Ownable.sol';

contract Payroll is Ownable{
    struct Employee {
        address id;
        uint salary;
        uint lastPayday;
    }
    
    uint constant payDuration = 10 seconds;

    uint totalSalary;    
    address owner;
    mapping(address => Employee) public employees;
    
    modifier employeeExist(address employeeId) {
        var employee = employees[employeeId]; 
        assert(employee.id != 0x0);
        _;
    }
    
    
    function _partialPaid(Employee employee) private {
        uint payment = employee.salary * (now - employee.lastPayday) / payDuration;
        employee.id.transfer(payment);
    }
    
    function addEmployee(address employeeId,uint salary) onlyOwner {
        var employee = employees[employeeId];
        assert(employee.id == 0x0);
        
        totalSalary += salary * 1 ether;
        employees[employeeId] = Employee(employeeId,salary * 1 ether,now);
    }
    
    function removeEmployee(address employeeId) onlyOwner employeeExist(employeeId) {
        var employee = employees[employeeId]; 
        
        _partialPaid(employee);
        totalSalary -= employees[employeeId].salary;
        delete employees[employeeId];
        
    }

    function updateEmployee(address employeeId,uint salary) onlyOwner employeeExist(employeeId) {
        var employee = employees[employeeId];
        
        _partialPaid(employee);
        
        totalSalary -= employees[employeeId].salary;
        employees[employeeId].salary = salary * 1 ether;
        totalSalary += employees[employeeId].salary;
        employees[employeeId].lastPayday = now;
    }
    
        function changePaymentAddress(address oldAddress, address newAddress) public onlyOwner employeeExist(oldAddress) {
        var employee = employees[oldAddress];
        uint salary = SafeMath.div(employee.salary, 1 ether);
        removeEmployee(oldAddress);
        addEmployee(newAddress, salary);
    }
    
    function addFund() payable returns(uint) {
        return this.balance;
    }
    
    function calculateRunway() returns(uint) {
        return this.balance / totalSalary;
    }
    
    function hasenoughFund() returns (bool) {
        return calculateRunway() > 0;
    }
    
    function getPaid() employeeExist(msg.sender) {
        var employee = employees[msg.sender];
        
        uint nextPayday = employee.lastPayday + payDuration;
        assert(nextPayday < now);
        
        employees[msg.sender].lastPayday = nextPayday;
        employee.id.transfer(employee.salary);
    }
}
