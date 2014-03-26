import QtQuick 2.0

Rectangle {
    id: apppage
    // set width based on given background
    width: parent.width
    height: parent.height
    color: "#343434"
    property int icon_width : 200
    property int icon_height : 200
    property int spaced : 20

    Component.onCompleted: {
        //console.log(parent_ip);
    }

    ListModel {
        id: appModel
        ListElement {
            type: 'Directory';
            path: 'HomeFolder';
            icon: '../images/kfm-home.png';
        }
        ListElement {
            type: 'Directory';
            path: 'MediaPlayer';
            icon: '../images/mplayer.png';
        }
        ListElement {
            type: 'Directory';
            path: 'PhotoViewer';
            icon: '../images/synfig_icon.png';
        }
        ListElement {
            type: 'Directory';
            path: 'Wireless';
            icon: '../images/network-wireless.png';
        }
        ListElement {
            type: 'Directory';
            path: 'Perference';
            icon: '../images/preferences-system.png';
        }
    }
    Component {
        id: appDelegate1
        Item {
            id: appDelegateitem
            width: icon_width + spaced
            height: icon_width + spaced + 80

            //property alias text: textitem.text
            //signal clicked

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 15
                height: 1
                color: "#424246"
            }

            Rectangle {
                anchors.fill: parent
                color: "#11ffffff"
                visible: appmouse.pressed
            }

            Text {
                id: apptextitem
                color: "white"
                font.pixelSize: 42
                text: path
                anchors.top: parent.bottom
                anchors.topMargin: -65
                anchors.left: appdirtype.left
                anchors.leftMargin: 0
            }

            Image {
                id: appdirtype
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -30
                width: icon_width
                height: icon_height
                source: icon
            }
            /*
            Image {
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                source:{
                    if( type == "File")
                        "."
                    else if( type == "Directory")
                        "../images/navigation_next_item.png"
                    else
                        "../images/navigation_next_item.png"
                }
            }*/
            MouseArea {
                id: appmouse
                anchors.fill: parent
                onClicked:{
                    //console.log("[Clicked]stackView: " + stackView)
                    //loader.source = "ListDirPage.qml"
                    stackView.push(Qt.resolvedUrl("ListDirPage.qml"))
                }
                //appDelegateitem.clicked()
            }
        }
    }

    GridView {
        id: applist
        anchors.fill: parent
        cellWidth: icon_width + spaced;
        cellHeight: icon_height + spaced + 80;
        //highlight: nasHighlight
        focus: true
        model: appModel
        delegate: appDelegate1
    }

}

