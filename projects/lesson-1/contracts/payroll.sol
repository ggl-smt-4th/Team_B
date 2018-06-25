
pragma solidity ^0.4.14;



contract Payroll {

    uint constant payDuration = 10 seconds;

    address owner;

    uint salary = 3 ether;

    address employee = 0x583031d1113ad414f02576bd6afabfb302140225;

    uint lastPayday = now;



    function Payroll() {

        owner = msg.sender;

    }

    function updateEmployee(address e, uint s) {
        require(msg.sender == owner);

        if (employee != 0x0) {

            uint payment = salary * (now - lastPayday) / payDuration;
            address exemployee = employee;

        }

        employee = e;

        salary = s * 1 ether;

        lastPayday = now;

        if (employee != 0x0) {
            exemployee.transfer(payment);
        }


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



    function getPaid() {

        require(msg.sender == employee);


        uint nextPayday = lastPayday + payDuration;

        assert(nextPayday < now);



        lastPayday = nextPayday;

        employee.transfer(salary);

    }

}