pragma solidity ^0.4.14;

contract Payroll {

    struct Employee {
        address id;
        uint salary;
        uint lastPayday;
    }

    uint constant payDuration = 30 days;

    address owner;
    Employee[] employees;
    uint totalSalary;

    function Payroll() payable public {
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

    function addEmployee(address employeeAddress, uint salary) public {
        require(msg.sender == owner);
        var (emp, indx) = _findEmployee(employeeAddress);
        
        assert(emp.id == 0x0);
        //emp.salary = sal * 1 ether;
        //emp.lastPayday = now;
        employees.push(Employee(employeeAddress, salary * 1 ether, now));
        totalSalary = totalSalary + salary * 1 ether;
    }

    function removeEmployee(address employeeId) public {
        require(msg.sender == owner);
        var (emp, indx) = _findEmployee(employeeId);
        assert(emp.id != 0x0);
        
        _partialPay(emp);
        delete(employees[indx]);
		employees[indx] = employees[employees.length-1];
		employees.length -= 1;
		totalSalary = totalSalary - emp.salary;
    }

    function updateEmployee(address employeeAddress, uint salary) public {
        require(msg.sender == owner);
        var (emp, indx) = _findEmployee(employeeAddress);
        assert(emp.id != 0x0);
        
        _partialPay(emp);
        employees[indx].salary = salary * 1 ether;
        employees[indx].lastPayday = now;
        totalSalary = totalSalary - emp.salary + salary * 1 ether;
    }

    function addFund() payable public returns (uint) {
        return address(this).balance;
    }

    function calculateRunway() public view returns (uint) {
        //uint totalSalary = 0;
        //for(uint i=0; i<employees.length; i++) {
        //    totalSalary += employees[i].salary;
        //}
        return this.balance / totalSalary;
    }

    function hasEnoughFund() public view returns (bool) {
        return calculateRunway() > 0;
    }

    function getPaid() public {
        var (emp, indx) = _findEmployee(msg.sender);  
        require(emp.id != 0x0);
        employees[indx].lastPayday = now;
        emp.id.transfer(emp.salary);
    }
}
