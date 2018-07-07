import React, { Component } from 'react';
import { Card, Col, Row } from 'antd';

class Common extends Component {
  constructor(props) {
    super(props);

    this.state = {};
    this.mounted = false;
  }

  async componentDidMount() {
    const { payroll } = this.props;

    const updateInfo = async (error, result) => {
      if (!error) {
        await this.getEmployerInfo();
      }
    };

    this.addFund = payroll.AddFund(updateInfo);
    this.getPaid = payroll.GetPaid(updateInfo);
    this.addEmployee = payroll.AddEmployee(updateInfo);
    this.updateEmployee = payroll.UpdateEmployee(updateInfo);
    this.removeEmployee = payroll.RemoveEmployee(updateInfo);

    this.mounted = true;
    await this.getEmployerInfo();
  }

  componentWillUnmount() {
    this.addFund.stopWatching();
    this.getPaid.stopWatching();
    this.addEmployee.stopWatching();
    this.updateEmployee.stopWatching();
    this.removeEmployee.stopWatching();
    this.mounted = false;
  }

  getEmployerInfo = async () => {
    const { payroll, account, web3 } = this.props;

    let info = await payroll.getEmployerInfo.call({ from: account });
    if (this.mounted) {
      this.setState({
        balance: web3.fromWei(info[0].toNumber()),
        runway: info[1].toNumber(),
        employeeCount: info[2].toNumber()
      });
    }
  };

  render() {
    const { runway, balance, employeeCount } = this.state;
    return (
      <div>
        <h2>通用信息</h2>
        <Row gutter={16}>
          <Col span={8}>
            <Card title="合约金额">{balance} Ether</Card>
          </Col>
          <Col span={8}>
            <Card title="员工人数">{employeeCount}</Card>
          </Col>
          <Col span={8}>
            <Card title="可支付次数">{runway}</Card>
          </Col>
        </Row>
      </div>
    );
  }
}

export default Common;
