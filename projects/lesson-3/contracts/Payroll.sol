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

    uint constant payDuration = 10 seconds;
    uint public totalSalary = 0;
    address owner;
    mapping(address => Employee) public employees;

    function Payroll() payable public {
        owner = msg.sender;
    }

    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    
    modifier employeeExist(address employeeId){
        var employee = employees[employeeId];
        assert(employee.id != 0x0);
        _;
    }

    function addEmployee(address employeeId, uint salary) public onlyOwner{
        var employee = employees[employeeId];
        assert(employee.id == 0x0);
        employees[employeeId] = Employee(employeeId, SafeMath.mul(salary, 1 ether), now);
        totalSalary += employees[employeeId].salary;
    }

    function _partialPaid(Employee employee) private{
        uint payment = SafeMath.div(SafeMath.mul(employee.salary, SafeMath.sub(now, employee.lastPayday)), payDuration);
        employee.id.transfer(payment);
    }
    
    function removeEmployee(address employeeId) public onlyOwner employeeExist(employeeId){
        var employee = employees[employeeId];
        
        _partialPaid(employee);
        totalSalary = SafeMath.sub(totalSalary, employee.salary);
        delete employees[employeeId];
        
    }

    function changePaymentAddress(address oldAddress, address newAddress) public onlyOwner employeeExist(oldAddress) {
        var employee = employees[oldAddress];
        uint salary = SafeMath.div(employee.salary, 1 ether);
        removeEmployee(oldAddress);
        addEmployee(newAddress, salary);
    }

    function updateEmployee(address employeeId, uint salary) public onlyOwner employeeExist(employeeId){
        var employee = employees[employeeId];
        
        _partialPaid(employee);
        totalSalary = SafeMath.sub(totalSalary, employee.salary);
        employee.salary = SafeMath.mul(salary, 1 ether);
        employee.lastPayday = now;
        totalSalary = SafeMath.add(totalSalary, employee.salary);
        
    }

    function addFund() payable public returns (uint) {
        return address(this).balance;
    }

    function calculateRunway() public view returns (uint) {
        return SafeMath.div(this.balance, totalSalary);
    }

    function hasEnoughFund() public view returns (bool) {
        return calculateRunway() > 0;
    }

    function getPaid() public employeeExist(msg.sender){
        var employee = employees[msg.sender];
        uint nextPayday = SafeMath.add(employee.lastPayday, payDuration);
        assert(nextPayday < now);
        employee.lastPayday = nextPayday;
        employees[msg.sender].id.transfer(employee.salary);
    }
}
