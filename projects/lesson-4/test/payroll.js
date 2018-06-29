var Payroll = artifacts.require("./Payroll.sol");

contract("Payroll", function(accounts) {
  const owner = accounts[0];
  const employee = accounts[1];
  const employee2 = accounts[2];
  const person = accounts[9];
  let payroll;

  beforeEach("Set payroll variable for each test case", async () => {
    payroll = await Payroll.deployed();
  });

  describe("add-employee", function () {
    it("should add new employee by owner", async function() {
      await payroll.addEmployee(employee, 1, {from: owner});
    });

    it("shouldn't add existing employee", async function() {
      try {
        assert.fail(await payroll.addEmployee(employee, 1, {from: owner}));
      } catch(err) {
        assert.include(err.toString(), "Error: VM Exception", "can't add existing employee");
      }
    });

    it("shouldn't add employee by other than owner", async function() {
      try {
        assert.fail(await payroll.addEmployee(employee2, 1, {from: person}));
      } catch (err) {
        assert.include(err.toString(), "Error: VM Exception", "can't add employee from another person");
      }
    });
  });

  describe("remove-employee", function () {
    it("should not remove employee by other than owner", async function() {
      try {
        assert.fail(await payroll.removeEmployee(employee, {from: person}));
      } catch (err) {
        assert.include(err.toString(), "Error: VM Exception", "can't remove employee from another person");
      }
    });

    it("should not able to remove not existing employee", async function() {
      try {
        assert.fail(await payroll.removeEmployee(employee2, {from: owner}));
      } catch (err) {
        assert.include(err.toString(), "Error: VM Exception", "can't remove not existing employee");
      }
    });

    it("should remove employee by owner", async function() {
      await payroll.removeEmployee(employee, {from: owner});
    });
  });

  describe("get-paid", function () {
    const oneMonth = 30 * 24 * 60 * 60 + 1;
    beforeEach("Add two employees to test get paid", async function () {
      payroll = await Payroll.new.call(owner, {from: owner, value: web3.toWei(10, "ether")});
      await Promise.all([payroll.addEmployee(employee, 1, {from: owner}),
                         payroll.addEmployee(employee2, 2, {from: owner})]);
    });

    it("should not get paid if doesn't wait pay duration time", async function() {
      try {
        assert.fail(await payroll.getPaid({from: employee}));
      } catch (err) {
        assert.include(err.toString(), "Error: VM Exception", "can't get paid until next pay day");
      }
    });

    it("should get paid by himself", async function() {
      await web3.currentProvider.send({jsonrpc: "2.0", method: "evm_increaseTime", params: [oneMonth], id: 0});
      await payroll.getPaid({from: employee});
    });

    it("should not get paid by a non employee", async function() {
      try {
        await web3.currentProvider.send({jsonrpc: "2.0", method: "evm_increaseTime", params: [oneMonth], id: 0});
        assert.fail(await payroll.getPaid({from: person}));
      } catch (err) {
        assert.include(err.toString(), "Error: VM Exception", "can't get paid if not an employee");
      }
    });
  });
});
