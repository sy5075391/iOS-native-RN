import React, {Component} from 'react';
import {StyleSheet,View,Button,Text,NativeModules} from "react-native";



export default class TestPage extends React.Component {

    render() {
        return (
            <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>

                <Button
                    title={"我是RN界面 p o p 回到原生界面" + this.props.itemId}
                    onPress={() => {
                        NativeModules.xkMerchantModule.popNative();
                    }}
                />
            </View>
        );
    }
}


const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#F5FCFF',
    },
    welcome: {
        fontSize: 20,
        textAlign: 'center',
        margin: 10,
    },
    instructions: {
        textAlign: 'center',
        color: '#333333',
        marginBottom: 5,
    },
});
