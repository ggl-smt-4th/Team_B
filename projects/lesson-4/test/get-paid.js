var Payroll = artifacts.require("./Payroll.sol");

contract('Payroll', function (accounts) {
  const owner = accounts[0];
  const employee = accounts[1];
  const guest = accounts[5];
  const salary = 1;
  const runway = 20;
  const payDuration = (30 + 1) * 86400;
  //const payDuration = 30 * 86400;
  const fund = runway * salary;

  let payroll;

  beforeEach("Setup contract for each test cases", async () => {
    //Payroll.new.call(owner, {from: owner, value: web3.toWei(fund, 'ether')});
    payroll = await Payroll.new();
    //Payroll.new.call(owner, {from: owner, value: web3.toWei(fund, 'ether')});
    await payroll.addFund({from: owner, value: web3.toWei(fund, 'ether')});
    //await payroll.call(owner, {from: owner, value: web3.toWei(fund, 'ether')});
    return await payroll.addEmployee(employee, salary, {from: owner});
  });

  it("Test getPaid()", async function () {
    let runwayRet = await payroll.calculateRunway();
    if (!runwayRet.toNumber || typeof runwayRet.toNumber !== "function") {
        assert(false, "the function `calculateRunway()` should be defined as: `function calculateRunway() public view returns (uint)` | `calculateRunway()` 应定义为: `function calculateRunway() public view returns (uint)`");
    }
    assert.equal(runwayRet.toNumber(), runway, "Runway is wrong");
    web3.currentProvider.send({jsonrpc: "2.0", method: "evm_increaseTime", params: [payDuration], id: 0});
    let getPaidRet = await payroll.getPaid({from: employee});
    let runwayRet2 = await payroll.calculateRunway();
    assert.equal(runwayRet2.toNumber(), runway - 1, "The runway is not correct");
  });

  it("Test getPaid() before duration", async function () {
    let runwayRet = await payroll.calculateRunway();
    assert.equal(runwayRet.toNumber(), runway, "Runway is wrong");
     
    try {
      await payroll.getPaid({from: employee});
    } catch(err) {
      assert.include(err.toString(), "Error: VM Exception", "Should not getPaid() before a pay duration");
    }
  });

  it("Test getPaid() by a non-employee", async function () {
    let runwayRet = await payroll.calculateRunway();
    assert.equal(runwayRet.toNumber(), runway, "Runway is wrong");
     
    try {
      await payroll.getPaid({from: guest});
    } catch(err) {
      assert.include(err.toString(), "Error: VM Exception", "Should not getPaid() by a non-employee");
    }
  });

});
