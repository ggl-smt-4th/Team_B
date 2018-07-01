let Payroll = artifacts.require("./Payroll.sol");

contract('Payroll', function (accounts) {
  const owner = accounts[0];
  const employee = accounts[1];
  const guest = accounts[5];
  const salary = 1;
  const payDuration = 60 * 60 * 24 * 30;


  it("Test getPaid() before duration", function () {
    let payroll;
    return Payroll.new().then(instance => {
      payroll = instance;
      return payroll.addEmployee(employee, salary, {from: owner});
    }).then(function() {
       payroll.addFund({from:owner, value: web3.toWei(1,'ether')});
    }).then(function() {
      return payroll.getPaid({from: employee});
    }).then(function () {
       assert(false, 'Should not succeed');
    }).catch(error => {
      assert.include(error.toString(), "Error: VM Exception", "should not get paid before pay duration");
    });
  });

  it("Test getPaid() after duration", function () {
    let payroll;
    return Payroll.new().then(instance => {
      payroll = instance;
      return payroll.addEmployee(employee, salary, {from: owner});
    }).then(function() {
       payroll.addFund({from:owner, value: web3.toWei(1,'ether')});
    }).then(function () {
       web3.currentProvider.send({jsonrpc: "2.0", method: "evm_increaseTime", params: [payDuration], id: 0})
    }).then(function() {
      return payroll.getPaid({from: employee});
    }).then(function () {
       assert(true, 'Should succeed');
    }).catch(error => {
      assert.include(error.toString(), "Error: VM Exception", "should get paid after pay duration");
    });
  });

});
