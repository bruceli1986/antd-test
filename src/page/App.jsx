import React, { Component } from 'react';
import PaymentNav from '../component/PaymentNav';
import PaymentBreadcrumb from '../component/PaymentBreadcrumb';
import './App.less';

class App extends Component {
  render() {
    return (
    <div className="payment-layout-top">
      <PaymentNav />
      <div className="payment-layout-wrapper">
      	<PaymentBreadcrumb />
        <div className="payment-layout-container">
          {this.props.children || <div style={{ height: 210 }}>Home</div>}
        </div>
      </div>
      <div className="payment-layout-footer">
      版权所有中国长江三峡集团公司 All rights reserved. 服务热线：0717-6761000
      </div>
    </div>);
  }
}

export default App;

