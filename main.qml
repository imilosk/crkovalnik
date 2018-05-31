import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

ApplicationWindow {
    visible: true
    width: 1280
    height: 720
    color: "white"
    title: qsTr("Hello World")

    Rectangle {
        id: menu
        x: 0
        y: 0
        width: 1280
        height: 720
        color: "white"

        Text {
            id: naslov
            text: "Program za učenje jezika"
            anchors.horizontalCenter: menu.horizontalCenter
            font.pointSize: 46
            y: 50
        }


        Image {
            id: sett
            source: "img/settings.png"
            signal pressAndHold()
            width: 50
            height: 50
            anchors.top: menu.top
            anchors.topMargin: 50
            anchors.right: menu.right
            anchors.rightMargin: 50
            /*MouseArea {
                          anchors.fill: parent
                          onClicked: {
                              game.visible = true
                              menu.visible = false
                          }
                }*/
            Timer {
                id: longPressTimer
                interval: 10 //your press-and-hold interval here
                repeat: false
                running: false
                onTriggered: {
                    sett.pressAndHold()
                    settings.visible = true
                }
            }
            MouseArea {
                anchors.fill: parent
                onPressedChanged: {
                    if ( pressed ) {
                        longPressTimer.running = true;
                    } else {
                        longPressTimer.running = false;
                    }
                }
            }
        }


        Rectangle {
            id: startContainer
            anchors.horizontalCenter: menu.horizontalCenter
            anchors.verticalCenter: menu.verticalCenter
            width: 500
            height: 120
            color: "black"

            Text {
                id: startText
                text: "Začni"
                anchors.horizontalCenter: startContainer.horizontalCenter
                anchors.verticalCenter: startContainer.verticalCenter
                font.pointSize: 24
                color: "white"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    game.visible = true
                    menu.visible = false
                }
            }

        }

        Rectangle {
            id: exitContainer
            anchors.horizontalCenter: menu.horizontalCenter
            y: menu.height / 2 + 100
            signal pressAndHoldExit()
            width: 500
            height: 80
            color: "red"

            Text {
                id: exitText
                text: "Izhod"
                anchors.horizontalCenter: exitContainer.horizontalCenter
                anchors.verticalCenter: exitContainer.verticalCenter
                font.pointSize: 16
                color: "white"
            }

            Timer {
                id: longPressExit
                interval: 1000 //your press-and-hold interval here
                repeat: false
                running: false
                onTriggered: {
                    exitContainer.pressAndHoldExit()
                    Qt.quit()
                }
            }
            MouseArea {
                anchors.fill: parent
                onPressedChanged: {
                    if ( pressed ) {
                        longPressExit.running = true;
                    } else {
                        longPressExit.running = false;
                    }
                }
            }

        }
        Rectangle{
            id: settings
            visible: false
            width: 0
            height: menu.height
            anchors.right: menu.right
            color: "lime"

            states: State {
                name: "anchorRight"
                when: settings.visible == true
                AnchorChanges {
                    target: settings
                    anchors.left: parent.left
                }
            }

            transitions: Transition {
                AnchorAnimation {duration: 3000}
            }
        }
        Component.onCompleted: settings.state = "anchorRight"

    }

















    Rectangle {
        id: game
        x: 0
        y: 0
        visible: false
        width: 1280
        height: 720
        color: "azure"

        Button {
            x: 300
            y: 300
            text: "Prikazi menu"
            onClicked: {
                game.visible = false
                menu.visible = true
            }
        }

    }

}
