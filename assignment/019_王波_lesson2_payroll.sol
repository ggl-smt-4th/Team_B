pragma solidity ^0.4.24;

contract Payroll {
    uint constant payDuration = 10 seconds;
    address owner;
    
    struct Employee {
        address id;
        uint salary;
        uint lastPayday;
    }
    
    Employee [] employees;
    
    function Payroll() {
        owner = msg.sender;
    } 
    
    function _findEmployee(address addr) private returns (Employee, uint) {
        for(uint i=0; i<employees.length; i++) {
            if(employees[i].id == addr) {
                return (employees[i], i);
            }
        }
    }
    
    function _partialPay(Employee emp) private {
        emp.lastPayday = now;
        uint payMount = emp.salary * (now - emp.lastPayday) / payDuration;
        emp.id.transfer(payMount);        
    }
    
    function updateEmployee(address addr, uint sal) {
        require(msg.sender == owner);
        var (emp, indx) = _findEmployee(addr);
        assert(emp.id != 0x0);
        
        _partialPay(emp);
        employees[indx].salary = sal * 1 ether;
        employees[indx].lastPayday = now;
    }
    
    function addEmployee(address addr, uint sal) {
        require(msg.sender == owner);
        var (emp, indx) = _findEmployee(addr);
        
        assert(emp.id == 0x0);
        //emp.salary = sal * 1 ether;
        //emp.lastPayday = now;
        employees.push(Employee(addr, sal * 1 ether, now));
    }
    
    function removeEmployee(address addr) {
        require(msg.sender == owner);
        var (emp, indx) = _findEmployee(addr);
        assert(emp.id != 0x0);
        
        _partialPay(emp);
        delete(employees[indx]);
		employees[indx] = employees[employees.length-1];
		employees.length -= 1;       
    }
    
    function addFund() payable returns (uint) {
        return address(this).balance;
    }
    
    function calRunway() returns (uint) {
        uint totalSalary = 0;
        for(uint i=0; i<employees.length; i++) {
            totalSalary += employees[i].salary;
        }
        return this.balance / totalSalary;
    }
    
    function hasEnoughFund() returns (bool) {
        return calRunway() > 0;
    }
    
    function getPaid() {
        var (emp, indx) = _findEmployee(msg.sender);  
        require(emp.id != 0x0);
        employees[indx].lastPayday = now;
        emp.id.transfer(emp.salary);
    }
}