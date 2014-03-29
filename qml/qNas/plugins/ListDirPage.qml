import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import "filelist.js" as JS

Rectangle {
    id: listDirPage
    width: parent.width
    height: parent.height
    color: "#343434"
    property string  root_folder : 'http://' + parent_ip +  ':' + parent_port + parent_router
    property string  share_folder : 'share/'
    property string  assigned_folder : ''
    property var folder_list: new Array()

    BorderImage {
        id: displaypng
        anchors.fill: parent
        source:  ''
        border.bottom: 8
        border.top: 8
        border.left: 8
        border.right: 8
        anchors.margins: 0
        visible: false
        z: 10
        MouseArea {
            anchors.fill: parent
            onClicked: {
                listView.visible = true;
                displaypng.visible = false;
            }
        }
    }
    Text {
        id: displaytext
        anchors.fill: parent
        color: "white"
        font.pixelSize: 32
        text: 'txt'
        visible: false
        MouseArea {
            anchors.fill: parent
            onClicked: {
                listView.visible = true;
                displaytext.visible = false;
            }
        }
    }

    Component.onCompleted: {
        //console.log("[ipaddress]!!!" + 'http://' + parent_ip +  ':' + parent_port + parent_router );
        JS.loaddir( parent_ip, parent_port, parent_router );
    }

    ListModel {
        id: listDirModel
        ListElement {
            type: 'Directory';
            path: '..';
            icon: '../images/editundo.png';
        }
    }
    Component {
        id: listDirDelegate1
        Item {
            id: listDirDelegateitem
            width: parent.width
            height: 88

            property alias text: textitem.text
            signal clicked

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
                visible: mouse.pressed
            }

            Text {
                id: textitem
                color: "white"
                font.pixelSize: 32
                text: path
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: dirtype.right
                anchors.leftMargin: 30
            }

            Image {
                id: dirtype
                anchors.left: parent.left
                anchors.rightMargin: 0
                anchors.verticalCenter: parent.verticalCenter
                width: 48
                height: 48
                source: {
                    if( type == "File")
                        "../images/source.png"
                    else if( type == "Directory")
                        "../images/fileopen.png"
                    else
                        "../images/fileopen.png"
                }
            }

            Image {
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                source:{
                    if( type == "File")
                        ''
                    else if( type == "Directory")
                        "../images/navigation_next_item.png"
                    else
                        "../images/navigation_next_item.png"
                }
            }
            MouseArea {
                id: mouse
                anchors.fill: parent
                onClicked:{
                    if( type == "File")
                    {
                        console.log("path: " + path);
                        if ( path.toString().search('png') >= 0)
                        {
                            displaypng.source = 'http://' + parent_ip +  ':' + parent_port + '/' + share_folder + folder_list.join('/') + '/' + path;
                            listView.visible = false;
                            displaypng.visible = true;
                            displaypng.width = displaypng.sourceSize.width;
                            displaypng.height = displaypng.sourceSize.height;
                        }
                        if ( path.toString().search('txt')  >= 0)
                        {
                            JS.showtxt( parent_ip , parent_port , share_folder, folder_list.join('/') + '/' + path , function(data){
                                displaytext.text = data;
                            });
                            listView.visible = false;
                            displaytext.visible = true;
                        }
                    }
                    else if( type == "Directory")
                    {
                        if ( path == '..' && folder_list.length > 0)
                        {
                            folder_list.pop();
                        }
                        else if (path != '..')
                        {
                            folder_list.push(path);

                        }
                        else
                        {
                            //console.log( 'The bottom folder now.' );
                        }
                        JS.loadeddir( parent_ip, parent_port, parent_router, '/' + folder_list.join('/') );
                    }
                    else
                        console.log("Clicked.")
                }
            }
        }
    }

    // The view:
    ListView {
        id: listView
        anchors.fill: parent
        model: listDirModel
        delegate: listDirDelegate1
        visible: true
    }
}

