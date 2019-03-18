/** @format */

import {AppRegistry} from 'react-native';
import App from './nativeInsert';
import TestPage from './TestPage'
import {name as appName} from './app.json';

AppRegistry.registerComponent(appName, () => App);

AppRegistry.registerComponent('TestPageName', () => TestPage);
