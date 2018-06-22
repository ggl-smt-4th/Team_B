pragma solidity ^0.4.14;

contract Payroll {
    uint constant payDuration = 10 seconds;

    address owner;
    uint salary;
    address employee;
    uint lastPayday;

    function Payroll() {
        owner = msg.sender;
    }
    
    /// @dev settle the payment according to the contract before update
    function settlePayment() internal {
        if (employee != 0x0) {
            uint payment = salary * (now - lastPayday) / payDuration;
            employee.transfer(payment);
        }
        lastPayday = now;
    }

    function updateEmployeeSalary(uint s) public {
         require(msg.sender == owner);

         settlePayment();
         salary = s * 1 ether;
    }

    function updateEmployeeAddress(address e) public {
        require(msg.sender == owner);

        settlePayment();
        employee = e;
    }

    function updateEmployee(address e, uint s) {
        require(msg.sender == owner);

        settlePayment();
        employee = e;
        salary = s * 1 ether;
    }

    function addFund() payable returns (uint) {
        return this.balance;
    }

    function calculateRunway() view returns (uint) {
        return this.balance / salary;
    }

    function hasEnoughFund() view returns (bool) {
        return calculateRunway() > 0;
    }

    function getPaid() {
        require(msg.sender == employee);

        uint nextPayday = lastPayday + payDuration;
        require(nextPayday < now);

        lastPayday = nextPayday;
        employee.transfer(salary);
    }
}
