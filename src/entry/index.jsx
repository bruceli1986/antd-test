import '../common/lib';
import ReactDOM from 'react-dom';
import React from 'react';
import {Router , browserHistory} from 'react-router';

const rootRoute = {
	component: 'div',
	childRoutes: [{
		path : '/',
		component: require('../page/App'),
		childRoutes:[
			require('../page/Contract'),
			require('../page/TaskManage')
		]
	}]
}

ReactDOM.render(<Router history={browserHistory} routes={rootRoute} />, document.getElementById('react-content'));
