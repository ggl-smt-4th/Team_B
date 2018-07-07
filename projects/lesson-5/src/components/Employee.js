import React, { Component } from 'react';
import { Card, Col, Row, Layout, Alert, Button } from 'antd';

import Common from './Common';

class Employee extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  async componentDidMount() {
    const { payroll } = this.props;

    this.onGetPaid = payroll.GetPaid(async (error, result) => {
      if (!error) {
        await this.checkEmployee();
      }
    });

    await this.checkEmployee();
  }

  componentWillUnmount() {
    this.onGetPaid.stopWatching();
  }

  checkEmployee = async () => {
    const { payroll, account, web3 } = this.props;

    let info = await payroll.getEmployerInfo.call({ from: account });
    let employeeCount = info[2].toNumber();

    if (employeeCount === 0) {
      return;
    }

    // Here we hardcode to first employee
    // TODO: remove hardcode employee after switch to metamask
    let [
      address,
      salary,
      lastPaidDayInUnix,
      balance
    ] = await payroll.getEmployeeInfo(0, { from: account });

    this.setState({
      address,
      salary: web3.fromWei(salary.toNumber(), 'ether'),
      lastPaidDate: new Date(lastPaidDayInUnix.toNumber() * 1000).toString(),
      balance: web3.fromWei(balance.toNumber(), 'ether')
    });
  };

  getPaid = async () => {
    const { payroll } = this.props;
    const { address } = this.state;

    await payroll.getPaid({ from: address, gas: 1000000 });
  };

  renderContent() {
    const { salary, lastPaidDate, balance } = this.state;

    if (!salary || salary === '0') {
      return <Alert message="你不是员工" type="error" showIcon />;
    }

    return (
      <div>
        <Row gutter={16}>
          <Col span={8}>
            <Card title="薪水">{salary} Ether</Card>
          </Col>
          <Col span={8}>
            <Card title="上次支付">{lastPaidDate}</Card>
          </Col>
          <Col span={8}>
            <Card title="帐号金额">{balance} Ether</Card>
          </Col>
        </Row>

        <Button type="primary" icon="bank" onClick={this.getPaid}>
          获得酬劳
        </Button>
      </div>
    );
  }

  render() {
    const { account, payroll, web3 } = this.props;

    return (
      <Layout style={{ padding: '0 24px', background: '#fff' }}>
        <Common account={account} payroll={payroll} web3={web3} />
        <h2>个人信息</h2>
        {this.renderContent()}
      </Layout>
    );
  }
}

export default Employee;
