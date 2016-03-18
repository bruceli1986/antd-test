import React, { Component } from 'react';

class Contract extends Component {
  render() {
    return <div style={{ height: 210 }}>Contract Payment</div>;
  }
}

const app = {
  path: 'contract',
  getComponent(location, cb){
    require.ensure([], (require) => {
      cb(null, Contract);
	})
  }
}

export default app;
