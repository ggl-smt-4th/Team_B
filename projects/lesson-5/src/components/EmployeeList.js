import React, { Component } from 'react';
import {
  Table,
  Button,
  Modal,
  Form,
  InputNumber,
  Input,
  Popconfirm
} from 'antd';

import EditableCell from './EditableCell';

const FormItem = Form.Item;

const columns = [
  {
    title: '地址',
    dataIndex: 'address',
    key: 'address'
  },
  {
    title: '薪水(ether)',
    dataIndex: 'salary',
    key: 'salary'
  },
  {
    title: '上次支付',
    dataIndex: 'lastPaidDay',
    key: 'lastPaidDay'
  },
  {
    title: '操作',
    dataIndex: '',
    key: 'action'
  }
];

class EmployeeList extends Component {
  constructor(props) {
    super(props);
    this.mounted = false;
    this.state = {
      loading: true,
      employees: [],
      showModal: false
    };

    columns[1].render = (text, record) => (
      <EditableCell
        value={text}
        onChange={this.updateEmployee.bind(this, record.address)}
      />
    );

    columns[3].render = (text, record) => (
      <Popconfirm
        title="你确定删除吗?"
        onConfirm={this.removeEmployee.bind(this, record.address)}
      >
        <a href="#">Delete</a>
      </Popconfirm>
    );
  }

  async componentDidMount() {
    const { payroll, account } = this.props;
    const refresh = async (error, result) => {
      if (!error) {
        let info = await payroll.getEmployerInfo.call({ from: account });
        let employeeCount = info[2].toNumber();

        if (employeeCount === 0) {
          this.setState({ loading: false });
          return;
        }

        this.loadEmployees(employeeCount);
      }
    };

    this.onAddEmployee = payroll.AddEmployee(refresh);
    this.onUpdateEmployee = payroll.UpdateEmployee(refresh);
    this.onRemoveEmployee = payroll.RemoveEmployee(refresh);
    this.mounted = true;
    await refresh(null);
  }

  componentWillUnmount() {
    this.onAddEmployee.stopWatching();
    this.onUpdateEmployee.stopWatching();
    this.onRemoveEmployee.stopWatching();
    this.mounted = false;
  }

  loadEmployees = async employeeCount => {
    const { payroll, account, web3 } = this.props;
    let employees = [];

    for (let i = 0; i < employeeCount; i++) {
      let [
        address,
        salary,
        lastPaidDayInUnix,
        balance
      ] = await payroll.getEmployeeInfo.call(i, { from: account });

      employees.push({
        key: address,
        address,
        salary: web3.fromWei(salary.toNumber(), 'ether'),
        lastPaidDay: new Date(lastPaidDayInUnix.toNumber() * 1000).toString(),
        balance: web3.fromWei(balance.toNumber(), 'ether')
      });
    }
    if (this.mounted) {
      this.setState({ employees, loading: false });
    }
  };

  addEmployee = async () => {
    const { payroll, account } = this.props;
    const { address, salary } = this.state;

    // let gas = await payroll.addEmployee.estimateGas(address, parseInt(salary, 10), {from: account});
    await payroll.addEmployee(address, parseInt(salary, 10), {
      from: account,
      gas: 1000000
    });
  };

  updateEmployee = async (address, salary) => {
    const { payroll, account } = this.props;

    await payroll.updateEmployee(address, parseInt(salary, 10), {
      from: account,
      gas: 1000000
    });
  };

  removeEmployee = async employeeId => {
    const { payroll, account } = this.props;

    await payroll.removeEmployee(employeeId, { from: account, gas: 1000000 });
  };

  renderModal() {
    return (
      <Modal
        title="增加员工"
        visible={this.state.showModal}
        onOk={() => {
          this.addEmployee();
          this.setState({ showModal: false });
        }}
        onCancel={() => this.setState({ showModal: false })}
      >
        <Form>
          <FormItem label="地址">
            <Input
              onChange={ev => this.setState({ address: ev.target.value })}
            />
          </FormItem>

          <FormItem label="薪水">
            <InputNumber
              min={1}
              onChange={salary => this.setState({ salary })}
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
          onClick={() => this.setState({ showModal: true })}
        >
          增加员工
        </Button>

        {this.renderModal()}

        <Table loading={loading} dataSource={employees} columns={columns} />
      </div>
    );
  }
}

export default EmployeeList;
