pragma solidity ^0.4.14;

contract Payroll {

    struct Employee {
        address id;
        uint salary;
        uint lastPayday;
    }

    uint constant payDuration = 10 seconds;

    address owner;
    Employee[] employees;

    function Payroll() payable public {
        owner = msg.sender;
    }

    function _findEmployee(address employeeAddr) private returns (Employee, uint) {
        for(uint i = 0; i < employees.length; i++) {
            if(employees[i].id == employeeAddr) {
                return (employees[i], i);
            }
        }
    }

    function _partialPaid(Employee employee) private {
        uint partialSalary = employee.salary * (now - employee.lastPayday) / payDuration;
        employee.id.transfer(partialSalary);
    }

    function addEmployee(address employeeAddress, uint salary) public {
        require(msg.sender == owner);
        var (employee, index) = _findEmployee(employeeAddress);
        assert(employee.id == 0x0);
        employees.push(Employee(employeeAddress, salary * 1 ether, now));
    }

    function removeEmployee(address employeeAddr) public {
        require(msg.sender == owner);
         require(msg.sender == owner);
        var (employee, index) = _findEmployee(employeeAddr);
        assert(employee.id != 0x0);
        _partialPaid(employee);
        delete employees[index];
        employees[index] = employees[employees.length - 1];
        employees.length -= 1;
    }

    function updateEmployee(address employeeAddress, uint salary) public {
        require(msg.sender == owner);
        var (employee, index) = _findEmployee(employeeAddress);
        assert(employee.id != 0x0);
        _partialPaid(employee);
        employees[index].salary = salary;
        employees[index].id = employeeAddress;
        employees[index].lastPayday = now;
    }

    function addFund() payable public returns (uint) {
        return address(this).balance;
    }

    function calculateRunway() public view returns (uint) {
        uint totalSalary = 0;
        for (uint i = 0; i < employees.length; i++){
            totalSalary += employees[i].salary;
        }
        return this.balance / totalSalary;
    }

    function hasEnoughFund() public view returns (bool) {
        return calculateRunway() > 0;
    }

    function getPaid() public {
        var (employee, index ) = _findEmployee(msg.sender);

        assert(employee.id != 0x0);
        uint nextPayday = employee.lastPayday + payDuration;
        assert(nextPayday < now);
        employee.lastPayday = nextPayday;
        employee.id.transfer(employee.salary);
    }
}
