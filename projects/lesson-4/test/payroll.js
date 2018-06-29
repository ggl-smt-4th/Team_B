const Payroll = artifacts.require("Payroll");
const helper = require("./helper");

async function getEmployee(payroll, address) {
  let ret = await payroll.employees.call(address);
  return {
    salary: ret[0],
    lastPayday: ret[1]
  };
}

contract("Payroll", function(accounts) {
  const owner = accounts[0];
  const employee = accounts[1];
  const nonEmployee = accounts[2];
  const salary = 1;
  const salaryInEth = web3.toWei("1", "ether");
  const payDuration = 10; // seconds

  let payroll;

  beforeEach(async () => {
    payroll = await Payroll.new({ value: web3.toWei("4", "ether") });
    await payroll.addEmployee(employee, salary, { from: owner });

    let newEmployee = await getEmployee(payroll, employee);
    assert.equal(
      newEmployee.salary.toString(),
      salaryInEth.toString(),
      "emplyee should exist and has salary set to" + salary
    );

    let totalSalary = await payroll.totalSalary.call();
    assert.equal(
      totalSalary.toString(),
      salaryInEth.toString(),
      "totalSalary should be updated"
    );

    let payrollBalance = await helper.getBalance(payroll.address);
    assert.equal(
      payrollBalance.toString(),
      web3.toWei("4", "ether").toString(),
      "payroll should have 4 ether fund"
    );
  });

  describe("addEmployee(address employeeId, uint salary)", async () => {
    it("should add employee", async () => {
      const totalSalaryPre = await payroll.totalSalary.call();
      await payroll.addEmployee(nonEmployee, salary, { from: owner });
      const totalSalaryPost = await payroll.totalSalary.call();

      assert.equal(
        totalSalaryPost.toString(),
        totalSalaryPre.plus(salaryInEth).toString(),
        "totalSalary should be updated"
      );

      const newEmployee = await getEmployee(payroll, nonEmployee);
      assert.equal(
        newEmployee.salary.toString(),
        salaryInEth.toString(),
        "new employee should be added"
      );
    });

    it("should not add employee from address other than owner", async () => {
      await helper.assertThrow(payroll.addEmployee, nonEmployee, salary, {
        from: nonEmployee
      });
    });

    it("should not add an existent employee again", async () => {
      await helper.assertThrow(payroll.addEmployee, employee, salary, {
        from: owner
      });
    });

    it("should not add employee using negative salary", async () => {
      await helper.assertThrow(payroll.addEmployee, nonEmployee, -1, {
        from: owner
      });
    });
  });

  describe("removeEmployee(address employeeId)", async () => {
    it("should remove an employee", async () => {
      const totalSalaryPre = await payroll.totalSalary.call();
      const employeeBalancePre = await helper.getBalance(employee);
      await payroll.removeEmployee(employee, { from: owner });
      const totalSalaryPost = await payroll.totalSalary.call();
      const employeeBalancePost = await helper.getBalance(employee);

      assert.equal(
        employeeBalancePost.toString(),
        employeeBalancePre.toString(),
        "should not have unpaid salary"
      );
      assert.equal(
        totalSalaryPost.toString(),
        totalSalaryPre.minus(salaryInEth).toString(),
        "totalSalary should be updated"
      );
      const removedEmployee = await getEmployee(payroll, employee);
      assert.equal(
        removedEmployee.salary.toString(),
        "0",
        "employee should be removed"
      );
    });

    it("should remove an employee and pay unpaid salary", async () => {
      await helper.timeJump(payDuration * 2 + 1);
      const totalSalaryPre = await payroll.totalSalary.call();
      const employeeBalancePre = await helper.getBalance(employee);
      await payroll.removeEmployee(employee, { from: owner });
      const totalSalaryPost = await payroll.totalSalary.call();
      const employeeBalancePost = await helper.getBalance(employee);

      assert.equal(
        employeeBalancePost.toString(),
        employeeBalancePre
          .plus(salaryInEth)
          .plus(salaryInEth)
          .toString(),
        "employee should be paid 2x salary"
      );
      assert.equal(
        totalSalaryPost.toString(),
        totalSalaryPre.minus(salaryInEth).toString(),
        "totalSalary should be updated"
      );
      const removedEmployee = await getEmployee(payroll, employee);
      assert.equal(
        removedEmployee.salary.toString(),
        "0",
        "employee should be removed"
      );
    });

    it("should not remove an employee from address other than owner", async () => {
      await helper.assertThrow(payroll.removeEmployee, employee, {
        from: employee
      });
    });

    it("should not remove none existent employee", async () => {
      await helper.assertThrow(payroll.removeEmployee, nonEmployee, {
        from: owner
      });
    });
  });

  describe("getPaid()", async () => {
    it("should pay salary to employee", async () => {
      await helper.timeJump(payDuration + 1);
      const employeeBalancePre = await helper.getBalance(employee);
      const lastPaydayPre = (await getEmployee(payroll, employee)).lastPayday;
      await payroll.getPaid({ from: employee });
      const employeeBalancePost = await helper.getBalance(employee);
      const lastPaydayPost = (await getEmployee(payroll, employee)).lastPayday;

      assert.isTrue(employeeBalancePost.greaterThan(employeeBalancePre));
      assert.isTrue(
        lastPaydayPost > lastPaydayPre,
        "last payday should be updated"
      );
    });

    it("should not pay to non employee", async () => {
      await helper.timeJump(payDuration + 1);
      await helper.assertThrow(payroll.getPaid, { from: nonEmployee });
    });

    it("should not pay again until next payday", async () => {
      await helper.timeJump(payDuration + 1);
      const employeeBalancePre = await helper.getBalance(employee);
      await payroll.getPaid({ from: employee });
      const employeeBalancePost = await helper.getBalance(employee);

      assert.isTrue(employeeBalancePost.greaterThan(employeeBalancePre));
      await helper.assertThrow(payroll.getPaid, { from: employee });
    });
  });
});
