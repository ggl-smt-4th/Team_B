pragma solidity ^0.4.14;

contract Payroll {

    struct Employee {
        address id;
        uint salary;
        uint lastPayDay;
    }

    uint constant payDuration = 30 days;

    address owner;
    Employee[] employees;
    uint sumSalary;

    function Payroll() payable public {
        owner = msg.sender;
    }

    function _partialPaid(Employee employee) private {
        uint payment = employee.salary * (now - employee.lastPayDay) / payDuration;
        employee.id.transfer(payment);
    }

    function _findEmployee(address employeeId) private returns (Employee, uint) {
        for (uint i = 0; i < employees.length; i++) {
            if (employees[i].id == employeeId) {
                return (employees[i], i);
            }
        }
    }

    function addEmployee(address employeeAddress, uint salary) public {
        require(msg.sender == owner);

        var (employee, index) = _findEmployee(employeeAddress);
        assert(employee.id == 0x0);

        uint currentSalary = salary * 1 ether;
        employees.push(Employee(employeeAddress, currentSalary, now));
        sumSalary += currentSalary;
    }

    function removeEmployee(address employeeId) public {
        require(msg.sender == owner);

        var (employee, index) = _findEmployee(employeeId);
        assert(employee.id != 0x0);

        _partialPaid(employee);
        sumSalary -= employee.salary;
        delete employees[index];
        employees[index] = employees[employees.length - 1];
        employees.length -= 1;
    }

    function updateEmployee(address employeeAddress, uint salary) public {
        require(msg.sender == owner);

        var (employee, index) = _findEmployee(employeeAddress);
        assert(employee.id != 0x0);

        _partialPaid(employee);
        uint newSalary = salary * 1 ether;
        sumSalary = sumSalary - employee.salary + newSalary;
        employee.salary = newSalary;
        employee.lastPayDay = now;
    }

    function addFund() payable public returns (uint) {
        return address(this).balance;
    }

    function calculateRunway() public view returns (uint) {
        // uint totalSalary = 0;
        // for (uint i = 0; i < employees.length; i++) {
        //    totalSalary += employees[i].salary;
        // }
        return this.balance / sumSalary;
    }

    function hasEnoughFund() public view returns (bool) {
        return calculateRunway() > 0;
    }

    function getPaid() public {
        var (employee, index) = _findEmployee(msg.sender);
        assert(employee.id != 0x0);

        uint nextPayDay = employee.lastPayDay + payDuration;
        assert(nextPayDay <= now);

        employee.lastPayDay = nextPayDay;
        employee.id.transfer(employee.salary);
    }
}
