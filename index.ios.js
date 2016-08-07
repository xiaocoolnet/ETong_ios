/**
 * Created by shenxiaolong on 16/7/18.
 */
'use strict';

var React = require('react-native');
var {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    TouchableOpacity,
    } = React;

var RNTestComponent = React.createClass({

    _handle:function(){
        return alert(1);
    },

    render: function() {
    return (
        <View style={styles.container}>
            <Text style={styles.welcome}>
            Welcome to React Native!
            </Text>
            <Text style={styles.instructions}>
            哈哈 就是开心
            </Text>
            <View>
                 <TouchableOpacity style ={styles.buttonStyle} onPress = {()=>this._handle()}>
                     <Text>
                         这是一个按钮
                     </Text>
                 </TouchableOpacity>
            </View>

        </View>
    );
    }
});

var view = require("react-native").NativeModules.RNHomeController;


var styles = StyleSheet.create({
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
    buttonStyle:{
        width:100,
        height:50,
        marginTop: 20,
        backgroundColor: "red",
        borderRadius:10,
        padding:6,
        justifyContent:'center',
    }
});

AppRegistry.registerComponent('RNTestComponent', () => RNTestComponent);