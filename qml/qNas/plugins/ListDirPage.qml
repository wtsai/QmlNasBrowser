import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import "filelist.js" as JS

Rectangle {
    id: listDirPage
    // set width based on given background
    width: parent.width
    height: parent.height
    color: "#343434"
    property string  root_folder : 'http://' + parent_ip +  ':' + parent_port + parent_router
    property string  assigned_folder : ''
    //property int  ListDirport : 9011
    //property string  router : '/File/Dir'
    //property string  ipaddress : 'http://' + ListDirIP + ':' + ListDirport + router
    //property string  ipaddress : "http://localhost:9011/File/Dir/"

    BorderImage {
        id: displaypng
        anchors.fill: parent
        //anchors.horizontalCenter: listView.horizontalCenter
        //anchors.verticalCenter: listView.verticalCenter
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
        console.log("[ipaddress]!!!" + root_folder );
        JS.loaddir( root_folder );
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
                        //if ( path.toString().search('png') != -1)
                        if ( path.toString().search('png') >= 0)
                        {
                            console.log("[Yes]png request: " + path.toString().search('png'));
                            assigned_folder = JS.showpng( path );
                            displaypng.source = 'http://' + parent_ip +  ':' + parent_port + assigned_folder;
                            //console.log("[Yes]assigned_folder: " + displaypng.source);
                            listView.visible = false;
                            displaypng.visible = true;
                            displaypng.width = displaypng.sourceSize.width;
                            displaypng.height = displaypng.sourceSize.height;
                        }
                        //if ( path.toString().search('txt')  != -1)
                        if ( path.toString().search('txt')  >= 0)
                        {
                            //var json_txt = JS.showtxt( parent_ip , parent_port , path ); //a big bug.
                            var json_txt = path.toString();
                            console.log("[Yes]txt request: " + path.toString().search('txt'));
                            //console.log(json_txt);
                            displaytext.text = json_txt.toString();
                            listView.visible = false;
                            displaytext.visible = true;
                            //displaypng.width = displaypng.sourceSize.width;
                            //displaypng.height = displaypng.sourceSize.height;
                        }
                    }
                    else if( type == "Directory")
                    {
                        //assigned_router = path_list[0] +  assigned_router + '/' + path ;
                        //console.log("path: " + path);
                        JS.loadeddir( path );
                    }
                    else
                        console.log("Clicked.")
                }
                //listDirDelegateitem.clicked()
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

