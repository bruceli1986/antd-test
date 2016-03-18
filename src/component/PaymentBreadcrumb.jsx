import React from 'react';
import { Breadcrumb } from 'antd';

class PaymentBreadcrumb extends React.Component{
  render (){
    return (
      <div className="payment-layout-breadcrumb">
        <Breadcrumb>
          <Breadcrumb.Item>首页</Breadcrumb.Item>
          <Breadcrumb.Item>任务中心</Breadcrumb.Item>
          <Breadcrumb.Item>待办事项</Breadcrumb.Item>
        </Breadcrumb>
      </div>)    
  }
}

export default PaymentBreadcrumb;