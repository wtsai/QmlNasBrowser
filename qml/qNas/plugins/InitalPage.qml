import QtQuick 2.0

Rectangle {
    id: initialpage
    width: parent.width
    height: parent.height
    color: "#212126"
    property int icon_width : 510
    property int icon_height : 206
    property int spaced : 20
    ListModel {
        id: nasModel
        ListElement {
            name: 'tpeo54006596';
            ip: 'localhost';
            resolvedUrl: 'NasHomePage.qml';
        }
        ListElement {
            name: 'Cubieboard';
            ip: '192.168.2.126';
            resolvedUrl: 'NasHomePage2.qml';
        }
        ListElement {
            name: 'CubieboardAP';
            ip: '192.168.100.10';
            resolvedUrl: 'NasHomePage2.qml';
        }
    }

    Component {
        id: nasDelegate

        Image {
            id: nas
            width: icon_width
            height: icon_height
            source: "../images/nas_select.png"

            Image {
                id: nas_inner
                width: 77 * 2
                height: 81 * 2
                anchors.horizontalCenter: nas.horizontalCenter
                anchors.horizontalCenterOffset: -(nas.width/4) - 10
                anchors.verticalCenter: nas.verticalCenter
                source: "../images/nas_3_4.png"
            }

            Text {
                id: hostname
                x: nas_inner.width + 60 ; y: 40
                color: "#00BFBB"
                text: name
                width: nas_inner.width + 30
                wrapMode: Text.WordWrap
                font {
                    //family: "Times";
                    pixelSize: 45; weight: Font.Bold;
                }
            }

            Text {
                id: ip1
                x: nas_inner.width + 60 ; y: 90
                //color: nas.GridView.isCurrentItem ? "red" : "#FFFFFF"
                color: "#FFFFFF"
                text: ip
                width: nas_inner.width + 30
                wrapMode: Text.WordWrap
                font {
                    //family: "Times";
                    pixelSize: 40;
                }
            }


            MouseArea {
                anchors.fill: parent
                onClicked: {
                    parent_ip = ip
                    parent_hostname = name
                    stackView.push(Qt.resolvedUrl("NasHomePage.qml"))
                    slogan = 'Intelligent NAS' + '(' + ip + ')'
                }
            }
        }

    }

    Component {
        id: nasHighlight
        Rectangle {
            width: icon_width + spaced + spaced + spaced;
            height: icon_height + spaced + spaced + spaced;
            color: "lightsteelblue"
        }
    }

    GridView {
        id: mainpage
        anchors.fill: parent
        cellWidth: icon_width + spaced;
        cellHeight: icon_height + spaced;
        //highlight: nasHighlight
        focus: true
        model: nasModel
        delegate: nasDelegate
    }

}
