pragma solidity ^0.4.24;

contract Payroll {
    uint salary = 1 ether;
    address worker = 0xca35b7d915458ef540ade6068dfe2f44e8fa733c;
    uint constant payDuration = 10 seconds;
    uint lastPayday = now;
    
    function addFund() payable returns (uint) {
        return this.balance;
    }
    
    function setSalary(uint x) {
        salary = x;
    }
    
    function getSalary() returns (uint) {
        return salary;
    }
    
    function setWorker(address x) {
        worker = x;
    }
    
    function getWorker() returns (address) {
        return worker;
    }
    
    function calRunway() returns (uint) {
        return this.balance / salary;
    }
    
    function hasEnoughFund() returns (bool) {
    
        return calRunway() > 0;
    }
    
    function getPaid() {
        if(msg.sender != worker) {
            revert();
        }
        uint currPayday = lastPayday + payDuration;
        if(currPayday > now) {
            revert();
        }
        lastPayday = currPayday;
        worker.transfer(salary);
    }
}
