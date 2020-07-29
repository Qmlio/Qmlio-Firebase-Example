import QtQuick 2.0
import QtQuick.Controls 2.2
import QmlioFirebase 1.0

Rectangle {
    width: parent.width / 2
    height: parent.height
    StorageQuery {
        id: independQuery

        // set storage
        parentStorage: storage
        tag: "independent Query"
        onUploadComplete: {
            log.log("independent child is complete")
        }

        onTransferedSizeChanged: {
            log.log(tag + size)
        }
        onTotalSizeChanged: {
         log.log(tag + size)
        }
    }

    Column {

        anchors.centerIn: parent
        spacing: 16
        Button {
            text: "get File"
            onClicked: {


                // TODO fetch a document from the device
            }
        }

        Button {
            // anchors.centerIn: parent
            text: "upload"
            onClicked: {

                childQuery.child("someNode").putFile(filePath)

                // try using the independent query
                independQuery.child("someNode").putFile(filePath)
            }
        }

        // try pausing
        Button {
            text: "pause"
            onClicked: childQuery.pause()
        }

        // try resuming
        Button {
            text: "resume"
            onClicked: childQuery.resume()
        }
    }
}
