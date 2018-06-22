pragma solidity ^0.4.14;

contract Payroll {
    uint newsalary;
    uint salary;
    address Employeeaccount;
    address frank;
    uint constant payDuration = 10 seconds;
    uint lastPayday = now ;
    
    function set(uint newsalary) {
      salary = newsalary * 1 ether;
    }
    
    function set(address Employeeaccount){
      frank = Employeeaccount;
    }
    
    function addFund() payable returns(uint) {
        return this.balance;
    }
    
    function calculateRunway()returns (uint) {
        return this.balance / salary;
    }
    
    function hasenoughFund() returns (bool) {
        return calculateRunway() > 0;
    }
    
    function getPaid() {
        if (msg.sender != frank) {
            revert();
        }
        uint nextPayday = lastPayday + payDuration;
        if (nextPayday > now){
            revert();
        }
            lastPayday = nextPayday;
            frank.transfer(salary);
    }
}
