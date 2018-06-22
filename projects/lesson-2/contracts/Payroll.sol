pragma solidity ^0.4.17;

contract Payroll {

    struct Employee {
        address id;
        uint salary;
        uint lastPayDay;
    }

    uint constant payDuration = 30 days;
    uint total = 0;
    address owner;
    Employee[] employees;

    function Payroll() payable public {
        owner = msg.sender;
    }

    function _findEmployee(address target) private returns (int) {
        for(uint i = 0; i < employees.length; i++ ){
            if (target == employees[i].id){
                return int(i);
            }
        }
        return -1;
    }
    
    function _partialPaid(Employee a) private{
        require (a.id != 0x0);
        uint payment = a.salary * ( now - a.lastPayDay) / payDuration;
        a.id.transfer(payment);
    }
    
    function addEmployee(address employeeAddress, uint salary) public {
        require(msg.sender == owner);
        int i = _findEmployee(employeeAddress);
        assert (i == -1);
        employees.push(Employee(employeeAddress, salary * 1 ether, now));
        total += salary * 1 ether;
    }

    function removeEmployee(address employeeId) public {
        require(msg.sender == owner);
        int i = _findEmployee(employeeId);
        assert (i != -1);
        _partialPaid(employees[uint(i)]);
        total -= employees[uint(i)].salary;
        delete employees[uint(i)];
        employees[uint(i)] = employees[employees.length - 1];
        employees.length -= 1;

    }

    function updateEmployee(address employeeAddress, uint salary) public {
        require(msg.sender == owner);
        int i = _findEmployee(employeeAddress);
        assert(i != -1);
        _partialPaid(employees[uint(i)]);
        total -= employees[uint(i)].salary;
        employees[uint(i)].salary = salary * 1 ether;
        employees[uint(i)].lastPayDay = now;
        total += salary * 1 ether;
    }

    function addFund() payable public returns (uint) {
        return address(this).balance;
    }
    
    function calculateRunway() public view returns (uint) {
        require (msg.sender == owner);
        return this.balance / total;
    }

    function hasEnoughFund() public returns (bool) {
        return calculateRunway() > 0;
    }

    function getPaid() public {
        address employee = msg.sender;
        int i = _findEmployee(employee);
        _partialPaid(employees[uint(i)]);
        employees[uint(i)].lastPayDay = now;
    }
}

