import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QmlioFirebase 1.0

Page {

    title: qsTr("Meassaging")
    property string mtoken
    QmlioMessaging {
        id: messanger
        onInitialized: {
            console.log("im intialsidd  dsd  sdsd   " + ready)
        }
        onTokenRecieved: {
            console.log("My token is " + token)
            mtoken = token
        }
        onMessageRecieved: {
            console.log("dewdwe  \n\n" + message)
        }
        onMessageSent: {
            console.log("is sent  ")
        }
    }
    Column {
        anchors.centerIn: parent
        spacing: 16
        Button {
            text: "Subscripe "
            onClicked: {

                var c = {
                    data: {
                        title: "New Text Message",
                        message: "Hello how are you?",
                        meta: {
                            type: "small",
                            info: "Search"
                        }
                    },
                    to: mtoken
                }
                messanger.send(JSON.stringify(c))
            }
        }
    }
}
