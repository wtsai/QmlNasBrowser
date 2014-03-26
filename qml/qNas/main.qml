
import QtQuick 2.1
import QtQuick.Controls 1.1
import "plugins"

ApplicationWindow {
    id: app
    width: 800
    height: 1280
    property int seconds : 0
    //property int delay_interval : 20
    property int delay_interval : 0
    property string slogan : 'Intelligent NAS'
    property string parent_ip : '127.0.0.1'
    property string parent_hostname : 'tpeo54006596'
    property int  parent_port : 9011
    property string  parent_router : '/File/Dir'

    Rectangle {
        color: "#212126"
        anchors.fill: parent
    }

    toolBar: BorderImage {
        border.bottom: 8
        source: "images/toolbar.png"
        width: parent.width
        height: 100

        Rectangle {
            id: backButton
            width: opacity ? 60 : 0
            anchors.left: parent.left
            anchors.leftMargin: 20
            opacity: stackView.depth > 2 ? 1 : 0
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            height: 60
            radius: 4
            color: backmouse.pressed ? "#222" : "transparent"
            Behavior on opacity { NumberAnimation{} }
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: "images/navigation_previous_item.png"
            }
            MouseArea {
                id: backmouse
                anchors.fill: parent
                anchors.margins: -10
                onClicked: {
                    //console.log("stackView.depth: " + stackView.depth)
                    if (stackView.depth > 2)
                        stackView.pop()
                }
            }
        }

        Text {
            font.pixelSize: 42
            Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
            x: backButton.x + backButton.width + 20
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            text: slogan
        }

        BusyIndicator {
            id: busyindicator
            scale: 1
            on: seconds <= delay_interval
            anchors { right: parent.right; rightMargin: 10; verticalCenter: parent.verticalCenter }
        }

        Timer {
            interval: 100; running: true; repeat: true;
            onTriggered: {
                seconds++;
                if (seconds == delay_interval+5)
                    stackView.push(Qt.resolvedUrl("plugins/InitalPage.qml"))
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: Item {
            width: parent.width
            height: parent.height
        }
    }


}
