import React from 'react';
import {Text, View, Button, NativeModules} from 'react-native';
import {createBottomTabNavigator, createAppContainer, createStackNavigator} from 'react-navigation';
import MyTablView from './MyTableView'
class HomeScreen extends React.Component {
    static navigationOptions = ({ navigation }) => {

    };

    render() {
        return (
            <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>

                <Button
                    title="下一页去跳转原生界面"
                    onPress={() => {
                        /* 1. Navigate to the Details route with params */
                        this.props.navigation.navigate('Details', {
                            itemId: 86,
                            otherParam: 'anything you want here',
                        });
                    }}
                />
            </View>
        );
    }
}

class SettingsScreen extends React.Component {
    render() {
        return (
            <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
                <Button
                    title="跳转原生界面"
                    onPress={() => {
                        NativeModules.xkMerchantModule.pushNative();
                    }}
                />
            </View>
        );
    }
}

class TablView extends React.Component {
    render() {
        return (
            <MyTablView style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
            </MyTablView>
        );
    }
}

const RootStack = createStackNavigator(
    {
        Home: {screen:HomeScreen},
        Details:{screen:SettingsScreen}
    }
);


const TabNavigator = createBottomTabNavigator({
    RN: { screen: RootStack },
    Native: { screen: TablView },
});

export default createAppContainer(TabNavigator);