import React, { Component } from 'react';

class TaskManage extends Component {
  render() {
  	const { taskType } = this.props.params

    return <div style={{ height: 210 }}>TaskManage: {taskType}</div>;
  }
}

const app = {
  path: 'taskManage/:taskType',
  getComponent(location, cb){
    require.ensure([], (require) => {
      cb(null, TaskManage);
	})
  }
}

export default app;
