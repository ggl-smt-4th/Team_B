pragma solidity ^0.4.14;

contract Payroll {
    uint salary = 1 ether;
    address salaryAddress;
    uint constant payDuration = 10 seconds;
    uint lastPayday = now;

    //向合约地址中添加ether
    function addFund() payable returns (uint){
        return this.balance;
    }

    function calculateRunaway() returns (uint) {
        return this.balance / salary;
    }

    function hasEnoughFund() returns (bool) {
        return calculateRunaway() > 0;
    }

    //设置薪水和地址
    function setSalaryAndAddress(uint sa,  address addr) {
        salary = sa * 1 ether;
        salaryAddress = addr;
    }

    //获取薪水和地址
    function getSalaryAddress() returns (uint,address) {
        return (salary, salaryAddress);
    }

    //雇员获取薪水
    function getPaid() {
        if (msg.sender != salaryAddress) {
            revert();
        }

        uint nextPayday = lastPayday + payDuration ;
        if (nextPayday> now) {
            revert();
        }

        lastPayday = nextPayday;
        salaryAddress.transfer(salary);
    }
}
