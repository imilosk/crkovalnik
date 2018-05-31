import QtQuick 2.3
import QtQuick.Controls 1.2

ApplicationWindow {

    property var resolutions: [
        {"height": 480, "width": 320, "name": "HVGA", "ratio": "3:2"},
        {"height": 640, "width": 360, "name": "nHD", "ratio": "16:9"},
        {"height": 640, "width": 480, "name": "VGA", "ratio": "4:3"},
        {"height": 800, "width": 480, "name": "WVGA", "ratio": "5:3"},
        {"height": 800, "width": 600, "name": "SVGA", "ratio": "4:3"},
        {"height": 960, "width": 540, "name": "qHD", "ratio": "16:9"},
        {"height": 1280, "width": 720, "name": "720p", "ratio": "16:9"},
        {"height": 1280, "width": 800, "name": "WXGA", "ratio": "16:10"},
        {"height": 1920, "width": 1080, "name": "1080p", "ratio": "16:9"}
    ]

    property int currentResolution: 6
    property bool isScreenPortrait: height >= width

    visible: true
    width: resolutions[currentResolution]["height"]
    height: resolutions[currentResolution]["width"]
    title: "%ProjectName%"

    Rectangle {
        id: menu
        x: 0
        y: 0
        anchors.fill: parent
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
        anchors.fill: parent
        color: "azure"

        ListModel {
            id: besedaModel
        }

        Component {
            id: besedaDelegate

            Column {
                /*
                Text {
                    text: tekst
                    font.pointSize: 24
                    font.capitalization: Font.AllUppercase
                }
                */
                Image {
                    fillMode: Image.PreserveAspectFit
                    source: slika
                    width: 150
                    height: 150
                }

            }
        }

        GridView {
            anchors.fill: parent
            model: besedaModel
            delegate: besedaDelegate
            anchors {
                leftMargin: 150
            }
            cellWidth: 200
            cellHeight: 200
        }

        Component.onCompleted: {
            var request = new XMLHttpRequest()
            request.open('GET', './words.json');
            request.onreadystatechange = function() {
                if (request.readyState === XMLHttpRequest.DONE) {
                    if (request.status && request.status === 200) {
                        var result = JSON.parse(request.responseText)
                        var list = result["slike"];
                        for (var i in list) {
                            besedaModel.append({
                                                   "slika": list[i].slika,
                                                   "tekst": list[i].tekst
                                               })
                        }
                    } else {
                        console.log("HTTP:", request.status, request.statusText)
                    }
                }
            }
            request.send()
        }

    }

}
