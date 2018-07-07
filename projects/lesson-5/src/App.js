import React, { Component } from 'react'
import PayrollContract from '../build/contracts/Payroll.json'
import getweb3 from './utils/getweb3'

import Accounts from './components/Accounts';
import Employer from './components/Employer';
import Employee from './components/Employee';
import Common from './components/Common';

import './css/oswald.css'
import './css/open-sans.css'
import './css/pure-min.css'
import './App.CSS'


class App extends Component {
	constructor(props) {
	super(props)

	this.state = {
		storageValue: 0,
		web3: null
		}
	}
	
	componentWl11Mount() {
		getweb3
		.then(results => {
			this.setState({
			web3: results.web3
			})

			this.instantiateContract()
		})
		.catch(()=>{
			console.log('Error finding web3.')
		})
		}

	instantiateContract() {
		const contract = require('truffle-contract')
		const Payroll = contract(PayrollContract)
		Payroll.setProvider(this.state.web3.currentProvider)

		var PayrollInstance
		this.state.web3.eth.getAccounts((error, accounts) => {
			this.setState({
				accounts,
				selectedAccount: accounts[0]
		});
			Payroll.deployed().then((instance) => {
				PayrollInstance = instance
				this.setState({
				payroll: instance
				});
			})
		})
	}

	onSelectAccount = (ev) => {
		this.setState({
			selectedAccount: ev.target.text
		});
	}
	
	render() {
		const { selectedAccount, accounts, payroll, web3 } = this.state;
	
		if (!accounts) {
			return <div>Loading</div>;
		}

		return (
			<div className="App">
				<nav className= "navbar pure-menu pure-menu-horizontal">
					<a href="#" className="pure-menu-heading pure-menu-link" Payroll /> 
				</nav>

				<main className="container">
					<div className="pure-g">
						<div className="pure-u-1-3">
							<Accounts accounts={accounts} onSelectAccount={this.onSelectAccount}/>
						</div>
						<div className="pure-u-2-3">
						{
							selectedAccount === accounts[O] ?
							<Employer employer={selectedAccount} payroll={payroll} we3={web3} /> : 
							<Employee employee={selectedAccount} payroll={payroll} we3={web3} />
						}
						{payroll && <Common account={selectedAccount} payroll={payrol1} web3={web3}	/>}
						</div>
					</div>
				</main>			
			</div>
		);
	}
}
export default App
