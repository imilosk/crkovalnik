import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.3

Rectangle {
    id: game
    x: 0
    y: 0
    visible: false
    anchors.fill: parent
    color: "#202020"
    property var imagePath: ""
    property var word: ""
    property var index: -1
    property bool textShown: false
    property int correctLetters: 0
    property int totalLetters: word.length

    Image {
        id: gameImageContainer
        anchors {
            horizontalCenter: parent.horizontalCenter
        }
        y: 100
        fillMode: Image.PreserveAspectFit
        source: game.imagePath
        width: 150
        height: 150
    }

    Text {
        id: gameTextContainer
        visible: game.textShown
        anchors {
            horizontalCenter: parent.horizontalCenter
        }
        y: 250
        text: game.word
        font.pointSize: 24
        color: "white"
        font.capitalization: Font.AllUppercase
    }

    // updates word on screen
    function updateWord() {
        gameImageContainer.source = besedaModel.get(game.index).slika
        gameTextContainer.text = besedaModel.get(game.index).tekst
        game.word = gameTextContainer.text
        game.correctLetters = 0;
        game.totalLetters = game.word.length

        if (main.level === 1){
            level1Container.lettersArray = [""]                    // MUST BE HERE TO RESET THE ARRAY IF THE SAME WORD APPEARS TWICE IN WORDS
            level1Container.lettersArray = game.word.split("")     // example: converts "CAR" to ["C", "A", "R"]
            level1Container.visible = true
            level2Container.visible = false
            level3Container.visible = false
            level4Container.visible = false
            gameTextContainer.visible = true
        }
        else if (main.level === 2) {
            level2Container.lettersArray = [""]                    // MUST BE HERE TO RESET THE ARRAY IF THE SAME WORD APPEARS TWICE IN WORDS
            level2Container.lettersArray = game.word.split("")     // example: converts "CAR" to ["C", "A", "R"]
            level2Container.visible = true
            level1Container.visible = false
            level3Container.visible = false
            level4Container.visible = false
            gameTextContainer.visible = true
        } else if (main.level === 3) {
            level3Container.lettersArray = [""]                    // MUST BE HERE TO RESET THE ARRAY IF THE SAME WORD APPEARS TWICE IN WORDS
            level3Container.lettersArray = game.word.split("")     // example: converts "CAR" to ["C", "A", "R"]
            level3Container.visible = true
            level1Container.visible = false
            level2Container.visible = false
            level4Container.visible = false
            level3Container.lettersArrayShuffled = shuffle(game.word.split(""))
            gameTextContainer.visible = false
        } else if (main.level === 4) {
            level4Container.lettersArray = [""]                    // MUST BE HERE TO RESET THE ARRAY IF THE SAME WORD APPEARS TWICE IN WORDS
            level4Container.lettersArray = game.word.split("")     // example: converts "CAR" to ["C", "A", "R"]
            level4Container.visible = true
            level1Container.visible = false
            level2Container.visible = false
            level3Container.visible = false
            gameTextContainer.visible = false
        }
    }

    // when button is clicked, change all atrributes to previous image attributes
    Image{
        id:levo
        width: 70
        height: 70
        source: "../icons/arrow.png"
        x: 50
        y: main.height - levo.width - 50
        MouseArea{
            anchors.fill:parent
            onClicked: {
                // prevents out of bounds
                if (game.index > 0) {
                    game.index--
                    game.updateWord()
                }
            }
        }
    }

    // when button is clicked, change all atrributes to next image attributes
    Image{
        id: desno
        width: 70
        height: 70
        source: "../icons/arrow.png"
        rotation: 180
        x: main.width - 125
        y: main.height - desno.width - 50

        MouseArea{
            anchors.fill:parent
            onClicked: {
                // prevents out of bounds
                if (game.index < besedaModel.count - 1) {
                    game.index++
                    game.updateWord()
                }
            }
        }
    }

}
