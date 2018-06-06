import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtMultimedia 5.6

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

    id: main
    visible: true
    width: resolutions[currentResolution]["height"]
    height: resolutions[currentResolution]["width"]
    title: "Crkovalnik"


    property int level: 1
    property bool sound_set: true

    SoundEffect {
        id: yaay
        source: "../sounds/yaay.wav"
    }
    SoundEffect {
        id: wrong
        source: "../sounds/wrong.wav"
    }
    SoundEffect {
        id: drop_sound
        source: "../sounds/drop.wav"
    }


    /***********************************************************
     * MainMenu
    ***********************************************************/

    Rectangle {
        id: menu
        x: 0
        y: 0
        anchors.fill: parent
        color: "#AAAAAA"

        Text {
            id: naslov
            text: "Črkovalnik"
            anchors.horizontalCenter: menu.horizontalCenter
            font.pointSize: 46
            y: 50
        }


        Image {
            id: sett

            source: "../icons/settings.png"
            signal pressAndHold()
            width: 50
            height: 50
            anchors.top: menu.top
            anchors.topMargin: 50
            anchors.right: menu.right
            anchors.rightMargin: 50


            Timer {
                id: longPressTimer
                interval: 1000 //your press-and-hold interval here
                repeat: false
                running: false
                onTriggered: {
                    sett.pressAndHold()
                    settings.visible = true
                    drop_sound.play()
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

        /*****************************
         * startButton
        ******************************/
        Rectangle {
            id: startContainer
            anchors.horizontalCenter: menu.horizontalCenter
            anchors.verticalCenter: menu.verticalCenter
            width: 500
            height: 120
            color: "#111111"

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
                    imagesGrid.visible = true
                    menu.visible = false
                    drop_sound.play()
                    imagesGrid.stupidProperty = 1
                }
            }

        }

        /*****************************
         * exitButton
        ******************************/

        Rectangle {
            id: exitContainer
            anchors.horizontalCenter: menu.horizontalCenter
            y: menu.height / 2 + 100
            signal pressAndHoldExit()
            width: 500
            height: 80
            color: "#FF4136"

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
                    drop_sound.play()
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


        /*****************************
         * settingsWindow
        ******************************/


        Rectangle{
            property string textToShow
            id: settings
            visible: false
            width: menu.width/2
            height: menu.height
            anchors.right: menu.right
            color: "#DDDDDD"

            Image {
                id: nazaj
                source: "../icons/arrow.png"
                width: 50
                height: 50
                y:25
                x:20
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        settings.visible=false
                        drop_sound.play()
                    }
                }
            }


                ComboBox {
                    anchors.horizontalCenter:parent.horizontalCenter
                    y: parent.height/2 - 100
                    currentIndex: 0
                    width: 200
                        height: 60
                    style: ComboBoxStyle{
                        font.pointSize: 24
                    }

                    model: ListModel {
                        id: nivoji
                        ListElement { text: "Nivo 1"}
                        ListElement { text: "Nivo 2"}
                        ListElement { text: "Nivo 3"}
                        ListElement { text: "Nivo 4"}
                    }
                    Layout.fillWidth: true
                    onCurrentIndexChanged: {
                        main.level = currentIndex+1
                        imagesGrid.stupidProperty = 1
                        console.debug(main.level)
                    }
                }



            RowLayout {
                Text {
                    id: zvok
                    text: "Zvok: "
                    font.pointSize: 24
                }
                anchors.horizontalCenter:parent.horizontalCenter
                anchors.verticalCenter:parent.verticalCenter
                ExclusiveGroup { id: tabPositionGroup }
                RadioButton {
                    id: daButton
                    exclusiveGroup: tabPositionGroup
                    checked: true
                    style: RadioButtonStyle {
                            indicator: Rectangle {
                                    implicitWidth: 16
                                    implicitHeight: 16
                                    radius: 9
                                    border.color: control.activeFocus ? "darkblue" : "gray"
                                    border.width: 1
                                    Rectangle {
                                        anchors.fill: parent
                                        visible: control.checked
                                        color: "#555"
                                        radius: 9
                                        anchors.margins: 4
                                    }
                            }
                        }
                }
                Text {
                    id: zvok_Da
                    text: "Da"
                    font.pointSize: 26
                }
                RadioButton {
                    id: neButton
                    exclusiveGroup: tabPositionGroup
                    Layout.preferredHeight: 40
                    style: RadioButtonStyle {
                            indicator: Rectangle {
                                    implicitWidth: 16
                                    implicitHeight: 16
                                    radius: 9
                                    border.color: control.activeFocus ? "darkblue" : "gray"
                                    border.width: 1
                                    Rectangle {
                                        anchors.fill: parent
                                        visible: control.checked
                                        color: "#555"
                                        radius: 9
                                        anchors.margins: 4
                                    }
                            }
                        }
                    onCheckedChanged: {
                        drop_sound.muted = !drop_sound.muted
                        wrong.muted = !wrong.muted
                        yaay.muted = !yaay.muted
                    }
                }
                Text {
                    id: zvok_ne
                    text: "Ne"
                    font.pointSize: 26
                }

            }
        }

    }





    /***********************************************************
     * ImagesGrid
    ***********************************************************/




    Rectangle {
         property int stupidProperty: 1
        id: imagesGrid
        x: 0
        y: 0
        visible: false
        anchors.fill: parent
        color: "#AAAAAA"

        ListModel {
            id: besedaModel
        }

        Image {
            source: "../icons/arrow.png"
            width: 50
            height: 50
            y:25
            x:20
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    imagesGrid.visible=false
                    menu.visible=true
                    drop_sound.play()
                }
            }
        }


        // This is the component where the grid cell is stored
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
                    id: image
                    fillMode: Image.PreserveAspectFit
                    source: slika
                    width: 150
                    height: 150
                    MouseArea {
                        anchors.fill: parent
                        // What happens when you click an image
                        onPressedChanged: {
                            if ( !pressed ) {
                                besedaModel.get(slika).tekst
                                for (var i = 0; i < besedaModel.count; i++){
                                    if (slika === besedaModel.get(i).slika) {
                                        game.index = i;
                                        break;
                                    }
                                }

                                game.imagePath = slika
                                game.word = tekst

                                game.visible = true
                                if (main.level === 1){
                                    level1Container.visible = true
                                    level2Container.visible = false
                                    level3Container.visible = false
                                    level4Container.visible = false
                                    game.textShown = true
                                } else if (main.level === 2){
                                    level2Container.visible = true
                                    level1Container.visible = false
                                    level3Container.visible = false
                                    level4Container.visible = false
                                    game.textShown = true
                                } else if (main.level === 3){
                                    level3Container.visible = true
                                    level1Container.visible = false
                                    level2Container.visible = false
                                    level4Container.visible = false
                                    game.textShown = false
                                } else if (main.level === 4){
                                    level4Container.visible = true
                                    level1Container.visible = false
                                    level2Container.visible = false
                                    level3Container.visible = false
                                    game.textShown = false
                                }
                                game.updateWord()
                                imagesGrid.visible = false
                                drop_sound.play()
                            }
                        }
                    }
                }
            }
        }

        // GridView for the images
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

        // Load images and add them to the grid
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




    /***********************************************************
     * Game
    ***********************************************************/


    Game {
        id: game
        Image {
            source: "../icons/arrow.png"
            width: 50
            height: 50
            y:25
            x:20
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    imagesGrid.visible=true
                    level1Container.visible = false
                    level2Container.visible = false
                    level3Container.visible = false
                    level4Container.visible = false
                    game.visible= false
                    imagesGrid.stupidProperty = 1
                    drop_sound.play()
                }
            }
        }

    }



    Level1 {
        id: level1Container
        visible: false
        lettersArray: game.word.split("")
        globalX: main.width / 2 - 64 * (game.word.split("").length) / 2
        y: main.height / 2
    }

    Level2 {
        id: level2Container
        visible: false
        lettersArray: game.word.split("")
        globalX: main.width / 2 - 64 * (game.word.split("").length) / 2
        y: main.height / 2
    }

    Level3 {
        id: level3Container
        visible: false
        lettersArray: game.word.split("")
        lettersArrayShuffled: shuffle(game.word.split(""))
        globalX: main.width / 2 - 64 * (game.word.split("").length) / 2
        y: main.height / 2
    }

    Level4 {
        id: level4Container
        visible: false
        lettersArray: game.word.split("")
        globalX: main.width / 2 - 64 * (game.word.split("").length) / 2
        y: main.height / 2
    }

    function shuffle(array) {
        var currentIndex = array.length, temporaryValue, randomIndex;

        // While there remain elements to shuffle...
        while (0 !== currentIndex) {

            // Pick a remaining element...
            randomIndex = Math.floor(Math.random() * currentIndex);
            currentIndex -= 1;

            // And swap it with the current element.
            temporaryValue = array[currentIndex];
            array[currentIndex] = array[randomIndex];
            array[randomIndex] = temporaryValue;
        }

        return array;
    }


}

