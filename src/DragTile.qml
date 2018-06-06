import QtQuick 2.0

Item {
    id: root
    property string colorKey

    width: 64; height: 64

    MouseArea {
        id: mouseArea

        width: 64; height: 64
        anchors.centerIn: parent

        drag.target: tile

        onReleased: {
            parent = tile.Drag.target !== null ? tile.Drag.target : root
            if (root !== null && tile !== null) {
                var letter = root.objectName;
                var currentLetter = tile.Drag.target.objectName;
                // console.log("Kej je: " + letter)
                // console.log("Kej bi moglo bit: " + currentLetter)
                if (letter === currentLetter) {
                    root.colorKey = "#3DFF3D"
                    parent.enabled = false
                    game.correctLetters++
                }
            }
            if (game.correctLetters === game.totalLetters){
                console.log("you win");
            }
        }

        Rectangle {
            id: tile
            width: 64; height: 64
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            color: colorKey

            Drag.keys: [ colorKey ]
            Drag.active: mouseArea.drag.active
            Drag.hotSpot.x: 32
            Drag.hotSpot.y: 32
            Text {
                anchors.fill: parent
                color: "white"
                font.pixelSize: 48
                text: modelData
                horizontalAlignment:Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            states: State {
                when: mouseArea.drag.active
                ParentChange {
                    target: tile; parent: root
                }
                AnchorChanges { target: tile; anchors.verticalCenter: undefined; anchors.horizontalCenter: undefined }
            }

        }
    }
}
