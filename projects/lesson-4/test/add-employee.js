var Payroll = artifacts.require("./Payroll.sol");

contract('Payroll', async function (accounts) {
  const owner = accounts[0];
  const employee = accounts[1];
  const guest = accounts[5];
  const salary = 1;

  it("Test call addEmployee() by owner", async function () {
    let payroll = await Payroll.deployed();
    return await payroll.addEmployee(employee, salary, {from: owner});
  });

  it("Test call addEmployee() with address 0x0", async function () {
    let payroll = await Payroll.deployed();
    try {
      await payroll.addEmployee('0x0', salary, {from: owner});
    } catch(err) {
      assert.include(err.toString(), "Error: VM Exception", "address 0x0 can not be accepted!");
    }
  });

  it("Test call addEmployee() with negative salary", async function () {
    let payroll = await Payroll.deployed();
    try {
      await payroll.addEmployee(employee, -salary, {from: owner});
    } catch(err) {
      assert.include(err.toString(), "Error: VM Exception", "Negative salary can not be accepted!");
    }
  });
  
  it("Test addEmployee() by guest", async function () {
    let payroll = await Payroll.deployed();
    try {
      await payroll.addEmployee(employee, salary, {from: guest});
    } catch(err) {
      assert.include(err.toString(), "Error: VM Exception", "Can not call addEmployee() by guest");
    }
  });

  it("Test call addEmployee() with employee already exist", async function () {
    let payroll = await Payroll.deployed();
    try {
      await payroll.addEmployee(employee, salary, {from: owner});
      await payroll.addEmployee(employee, salary, {from: owner});
    } catch(err) {
      assert.include(err.toString(), "Error: VM Exception", "Can't add employee already exist");
    }
  });
});
