var Payroll = artifacts.require("./Payroll.sol");

contract('Payroll', function (accounts) {
    const owner = accounts[0];
    const employee = accounts[1];
    const guest = accounts[2];
    const salary = 1;
    const runway = 20;
    const payDuration = 60 * 60 * 24 * 30; // 30 days
    const fund = runway * salary;


    it("Test call addEmployee() by owner", function () {
        let payroll;
        return Payroll.new().then(instance => {
            payroll = instance;
            return payroll.addEmployee(employee, salary, { from: owner });
        });
    });

    it("Test call addEmployee() with negative salary", function () {
        var payroll;
        return Payroll.new().then(instance => {
            payroll = instance;
            return payroll.addEmployee(employee, -salary, { from: owner });
        }).then(assert.fail).catch(error => {
            assert.include(error.toString(), "Error: VM Exception", "Negative salary can not be accepted!");
        });
    });

    it("Test addEmployee() by guest", function () {
        var payroll;
        return Payroll.new().then(function (instance) {
            payroll = instance;
            return payroll.addEmployee(employee, salary, { from: guest });
        }).then(() => {
            assert(false, "Should not be successful");
        }).catch(error => {
            assert.include(error.toString(), "Error: VM Exception", "Can not call addEmployee() by guest");
        });
    });


    let payroll;
    beforeEach("Setup contract for each test cases", () => {
        return Payroll.new().then(instance => {
            payroll = instance;
            return payroll.addEmployee(employee, salary, { from: owner });
        });
    });

    it("Test call removeEmployee() by owner", () => {
        // Remove employee
        return payroll.removeEmployee(employee, { from: owner });
    });

    it("Test call removeEmployee() by guest", () => {
        return payroll.removeEmployee(employee, { from: guest }).then(() => {
            assert(false, "Should not be successful");
        }).catch(error => {
            assert.include(error.toString(), "Error: VM Exception", "Cannot call removeEmployee() by guest");
        });
    });


    it("Test getPaid()", function () {
        var payroll;
        return Payroll.new.call(owner, { from: owner, value: web3.toWei(fund, 'ether') }).then(instance => {
            payroll = instance;
            return payroll.addEmployee(employee, salary, { from: owner });
        }).then(() => {
            return payroll.calculateRunway();
        }).then(runwayRet => {
            if (!runwayRet.toNumber || typeof runwayRet.toNumber !== "function") {
                assert(false, "the function `calculateRunway()` should be defined as: `function calculateRunway() public view returns (uint)` | `calculateRunway()` 应定义为: `function calculateRunway() public view returns (uint)`");
            }
            assert.equal(runwayRet.toNumber(), runway, "Runway is wrong");
            return web3.currentProvider.send({ jsonrpc: "2.0", method: "evm_increaseTime", params: [payDuration], id: 0 });
        }).then(() => {
            return payroll.getPaid({ from: employee })
        }).then((getPaidRet) => {
            return payroll.calculateRunway();
        }).then(runwayRet => {
            assert.equal(runwayRet.toNumber(), runway - 1, "The runway is not correct");
        });
    });

    it("Test getPaid() before duration", function () {
        var payroll;
        return Payroll.new.call(owner, { from: owner, value: web3.toWei(fund, 'ether') }).then(instance => {
            payroll = instance;
            return payroll.addEmployee(employee, salary, { from: owner });
        }).then(() => {
            return payroll.calculateRunway();
        }).then(runwayRet => {
            assert.equal(runwayRet.toNumber(), runway, "Runway is wrong");
            return payroll.getPaid({ from: employee })
        }).then((getPaidRet) => {
            assert(false, "Should not be successful");
        }).catch(error => {
            assert.include(error.toString(), "Error: VM Exception", "Should not getPaid() before a pay duration");
        });
    });

    it("Test getPaid() by a non-employee", function () {
        var payroll;
        return Payroll.new.call(owner, { from: owner, value: web3.toWei(fund, 'ether') }).then(instance => {
            payroll = instance;
            return payroll.addEmployee(employee, salary, { from: owner });
        }).then(() => {
            return payroll.calculateRunway();
        }).then(runwayRet => {
            assert.equal(runwayRet.toNumber(), runway, "Runway is wrong");
            return payroll.getPaid({ from: guest })
        }).then((getPaidRet) => {
            assert(false, "Should not be successful");
        }).catch(error => {
            assert.include(error.toString(), "Error: VM Exception", "Should not call getPaid() by a non-employee");
        });
    });

});