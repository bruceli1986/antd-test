import React from 'react';
import { Menu, Breadcrumb, Icon } from 'antd';
import '../style/PaymentNav.css';
import { Link } from 'react-router';

const SubMenu = Menu.SubMenu;

class PaymentNav extends React.Component{
  render() {
    return (   
      <div className="payment-layout-header">
        <div className="payment-layout-wrapper">
          <div className="payment-layout-logo"></div>
          <Menu mode="horizontal"
            defaultSelectedKeys={['1']} style={{lineHeight: '64px'}}>
            <SubMenu key="task" title={<span><Icon type="calendar" />任务中心</span>}>
                <Menu.Item key="task:1"><Link to="/taskManage/todoTask">待办事项</Link></Menu.Item>
                <Menu.Item key="task:2"><Link to="/taskManage/passTask">在办事项</Link></Menu.Item>
                <Menu.Item key="task:3"><Link to="/taskManage/historyTask">办结事项</Link></Menu.Item>
                <Menu.Item key="task:4"><Link to="/taskManage/participantTask">关注事项</Link></Menu.Item>
            </SubMenu>
            <Menu.Item key="2"><Link to="/contract">合同业务</Link></Menu.Item>            
          </Menu>
        </div>
      </div> )
  }
};

export default PaymentNav;
