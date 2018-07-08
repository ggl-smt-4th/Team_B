import React, { Component } from 'react'
import { Card, Col, Row } from 'antd';

class Common extends Component {
  constructor(props) {
    super(props);

    this.state = {};
  }

  //组件加载完以后添加智能合约中的事件监听
  componentDidMount() {
    const { payroll, web3 } = this.props;

    const updateInfo = (error, result) => {
      if (!error) {
        console.log('result: ');
        console.log(result);
        this.getEmployerInfo();
      }else {
        console.log(error);
      }
    }

    //开启事件监听，通过回调函数获取事件监听返回的信息
    this.addFund = payroll.AddFund(updateInfo);
    this.getPaid = payroll.GetPaid(updateInfo);
    this.addEmployee = payroll.AddEmployee(updateInfo);
    this.updateEmployee = payroll.UpdateEmployee(updateInfo);
    this.removeEmployee = payroll.RemoveEmployee(updateInfo);

    this.getEmployerInfo();
  }

  //组件卸载之前停止事件监听
  componentWillUnmount() {
    this.addFund.stopWatching();
    this.getPaid.stopWatching();
    this.addEmployee.stopWatching();
    this.updateEmployee.stopWatching();
    this.removeEmployee.stopWatching();
  }

  //获取雇主的信息
  getEmployerInfo = () => {
    const { payroll, account, web3 } = this.props;
    payroll.getEmployerInfo.call({
      from: account,
    }).then((result) => {
      this.setState({
        balance: web3.fromWei(result[0].toNumber()),
        runway: result[1].toNumber(),
        employeeCount: result[2].toNumber()
      })
    });
  }

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

export default Common