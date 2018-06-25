pragma solidity ^0.4.14;

import './SafeMath.sol';
import './Ownable.sol';

contract Payroll is Ownable{
    using SafeMath for uint;
    struct Employee {
        address id;
        uint salary;
        uint lastPayday;
    }

    uint constant payDuration = 30 days;
    //uint constant payDuration = 10 seconds;

    address owner;
    mapping(address => Employee) employees;
	uint totalSalary;

//    function Payroll() payable public {
//        owner = msg.sender;
//    }
    
//    modifier onlyOwner {
//        require(msg.sender == owner); 
//       _;
//    }
    
    modifier empployeeExist(address employeeAddress) {
        Employee storage emp = employees[employeeAddress];
        assert(emp.id != 0x0);
        _;
    }
    
//    function _partialPay(Employee emp) private {
        //emp.lastPayday = now;
//        uint payMount = emp.salary * (now - emp.lastPayday) / payDuration;
//        emp.id.transfer(payMount);        
//    }
    
    modifier partialPay(address employeeAddress) {
        Employee emp = employees[employeeAddress];
        //emp.lastPayday = now;
        //uint payMount = emp.salary * (now - emp.lastPayday) / payDuration;
        uint payMount = emp.salary
            .mul(now.sub(emp.lastPayday))
            .div(payDuration);
        emp.id.transfer(payMount);
        _;
    }

    function addEmployee(address employeeAddress, uint salary) onlyOwner public {
        Employee storage emp = employees[employeeAddress];
        assert(emp.id == 0x0);
        
        employees[employeeAddress] =Employee(employeeAddress, salary.mul(1 ether), now);
        //totalSalary = totalSalary + salary * 1 ether;
        totalSalary = totalSalary
            .add(salary.mul(1 ether));
    }

    function removeEmployee(address employeeAddress) onlyOwner empployeeExist(employeeAddress) partialPay(employeeAddress) public {
        //_partialPay(emp);
        //totalSalary = totalSalary - employees[employeeAddress].salary;
        totalSalary = totalSalary.sub(employees[employeeAddress].salary);
        delete(employees[employeeAddress]);
    }

    function updateEmployee(address employeeAddress, uint salary) onlyOwner empployeeExist(employeeAddress) partialPay(employeeAddress) public {
        //_partialPay(emp);
        employees[employeeAddress].salary = salary.mul(1 ether);
        employees[employeeAddress].lastPayday = now;
        //totalSalary = totalSalary - employees[employeeAddress].salary + salary * 1 ether;
        totalSalary = totalSalary
            .sub(employees[employeeAddress].salary)
            .add(salary.mul(1 ether));
    }
    
    function changePaymentAddress(address oldAddr, address newAddr) onlyOwner empployeeExist(oldAddr) public {
        employees[newAddr] = employees[oldAddr];
        delete employees[oldAddr];
    }

    function addFund() payable public returns (uint) {
        return address(this).balance;
    }

    function calculateRunway() public view returns (uint) {
        //uint totalSalary = 0;
        //for(uint i=0; i<employees.length; i++) {
        //    totalSalary += employees[i].salary;
        //}
        return this.balance.div(totalSalary);
    }

    function hasEnoughFund() public view returns (bool) {
        return calculateRunway() > 0;
    }

    function getPaid() empployeeExist(msg.sender) public {
        Employee storage emp = employees[msg.sender];  
        
        uint nextPayday = emp.lastPayday.add(payDuration);
        assert(nextPayday < now);
        
        employees[msg.sender].lastPayday = nextPayday;
        emp.id.transfer(emp.salary);
    }
}