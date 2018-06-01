import QtQuick 2.0

Rectangle {
    id: redContainer
    visible: false
    property var lettersArray: [""]
    property var columnNumb: lettersArray.length
    property var globalX: lettersArray.length
    x: globalX

    Grid {
        id: redDestination
        anchors.margins: 5
        width: 64*columnNumb
        height: 64*3
        opacity: 0.5
        columns: columnNumb

        Repeater {
            model: lettersArray
            delegate: DropTile { colorKey: "black" }
        }
    }

    Row {
        id: redSource
        anchors.left: parent.left; anchors.top: redDestination.bottom
        anchors.margins: 5
        width: 64
        Repeater {
            model: redContainer.lettersArray
            delegate: DragTile {
                colorKey: "black"
                /*
                Text {
                    id: name
                    text: qsTr("text")
                }
                */
            }
        }


    }

}
