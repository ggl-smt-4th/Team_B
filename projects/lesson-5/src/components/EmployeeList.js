import React, { Component } from 'react'
import { Table, Button, Modal, Form, InputNumber, Input, message, Popconfirm } from 'antd';

import EditableCell from './EditableCell';

const FormItem = Form.Item;

const columns = [{
  title: '地址',
  dataIndex: 'address',
  key: 'address',
}, {
  title: '薪水',
  dataIndex: 'salary',
  key: 'salary',
}, {
  title: '上次支付',
  dataIndex: 'lastPaidDay',
  key: 'lastPaidDay',
}, {
  title: '操作',
  dataIndex: '',
  key: 'action'
}];

class EmployeeList extends Component {
  constructor(props) {
    super(props);

    this.state = {
      loading: true,
      employees: [],
      showModal: false
    };

    columns[1].render = (text, record) => (
      <EditableCell
        value={text}
        onChange={ this.updateEmployee.bind(this, record.address) }
      />
    );

    columns[3].render = (text, record) => (
      <Popconfirm title="你确定删除吗?" onConfirm={() => this.removeEmployee(record.address)}>
        <a href="#">Delete</a>
      </Popconfirm>
    );
  }

  componentDidMount() {
    const { payroll, account, web3 } = this.props;
    payroll.getEmployerInfo.call({
      from: account
    }).then((result) => {
      const employeeCount = result[2].toNumber();

      if (employeeCount === 0) {
        this.setState({loading: false});
        return;
      }

      this.loadEmployees(employeeCount);
    });

  }

  loadEmployees(employeeCount) {
    const { payroll, account, web3 } = this.props;
    let {employees } = this.state;
    let address, salary, lastPaidDay, balance;

    for (let i = 0; i < employeeCount; i++) {
      payroll.getEmployeeInfo.call(i, { from: account }).then((result) => {
        address, salary, lastPaidDay, balance = result;
      });
      employees.push({
        address,
        salary: web3.fromWei(salary.toNumber(), 'ether'),
        lastPaidDay: new Date(lastPaidDay.toNumber() * 1000).toString(),
        balance: web3.fromWei(balance.toNumber(), 'ether')
      });
    }
    this.setState({employees, loading: false});
  };

  addEmployee = () => {
    const {payroll, employer } = this.props;
    const {address, salary} = this.state;

    payroll.addEmployee(address,parseInt(salary), {
      from: employer,
      gas: 1000000
    }).then((result) => {
      alert('success');
    });
  };

  updateEmployee = (address, salary) => {
    const {payroll, employer } = this.props;
    console.log(this.state.address);
    payroll.updateEmployee(address,parseInt(salary), {
      from: employer,
      gas: 1000000
    }).then((result) => {
      alert('success');
    });
  };

  removeEmployee = (employeeId) => {
    const {payroll, employer } = this.props;
    console.log(this.state.address);
    payroll.removeEmployee(this.state.address, {
      from: employer,
      gas: 1000000
    }).then((result) => {
      alert('success');
    });
  };

  renderModal() {
      return (
      <Modal
          title="增加员工"
          visible={this.state.showModal}
          onOk={this.addEmployee}
          onCancel={() => this.setState({showModal: false})}
      >
        <Form>
          <FormItem label="地址">
            <Input
              onChange={ev => this.setState({address: ev.target.value})}
            />
          </FormItem>

          <FormItem label="薪水">
            <InputNumber
              min={1}
              onChange={salary => this.setState({salary})}
            />
          </FormItem>
        </Form>
      </Modal>
    );

  }

  render() {
    const { loading, employees } = this.state;
    return (
      <div>
        <Button
          type="primary"
          onClick={() => this.setState({showModal: true})}
        >
          增加员工
        </Button>

        {this.renderModal()}

        <Table
          loading={loading}
          dataSource={employees}
          columns={columns}
        />
      </div>
    );
  }
}

export default EmployeeList
