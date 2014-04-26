import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtMultimedia 5.0
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

    Component.onCompleted: {
        JS.loaddir( parent_ip, parent_port, parent_router );
    }

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
                displaytext.visible = false;
                displayMusic.visible = false;
                displayVideo.visible = false;
                outputArea.visible = false;
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
                displaypng.visible = false;
                displaytext.visible = false;
                displayMusic.visible = false;
                displayVideo.visible = false;
                outputArea.visible = false;
            }
        }
    }

    Text {
        id: displayMusic
        anchors.fill: parent
        color: "white"
        font.pixelSize: 32
        text: 'displayMusic'
        visible: false

        MediaPlayer {
            id: playMusic
            autoLoad: false
            source: "music.mp3"
        }
        MouseArea {
            id: musicArea
            anchors.fill: parent
            onPressed:  {
                playMusic.stop();
                listView.visible = true;
                displaypng.visible = false;
                displaytext.visible = false;
                displayMusic.visible = false;
                displayVideo.visible = false;
                outputArea.visible = false;
            }
        }
    }

    Item {
        id: displayVideo
        anchors.fill: parent
        visible: false

        MediaPlayer {
            id: playVideo
            autoLoad: false
            source: "music.mp4"
        }

        VideoOutput {
            id: outputArea
            anchors.fill: parent
            visible: false
            source: playVideo
        }

        MouseArea {
            id: videoArea
            anchors.fill: parent
            onPressed:  {
                playVideo.stop();
                listView.visible = true;
                displaypng.visible = false;
                displaytext.visible = false;
                displayMusic.visible = false;
                displayVideo.visible = false;
                outputArea.visible = false;
            }
        }
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
            height: 120

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
                font.pixelSize: 55
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
                width: 80
                height: 80
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
                        if ( path.toString().search('avi') >= 0 ||
                             path.toString().search('AVI') >= 0 ||
                             path.toString().search('mkv') >= 0 ||
                             path.toString().search('MKV') >= 0 ||
                             path.toString().search('MP4') >= 0 ||
                             path.toString().search('mp4') >= 0 ||
                             path.toString().search('divx') >= 0 ||
                             path.toString().search('DIVX') >= 0 ||
                             path.toString().search('swf') >= 0 ||
                             path.toString().search('SWF') >= 0)
                        {
                            JS.showvideo( parent_ip , parent_port , share_folder, folder_list.join('/') + '/' + path , function(VideoPath){
                                playVideo.source = VideoPath;
                                playVideo.play();
                            });
                            listView.visible = false;
                            displayVideo.visible = true;
                            outputArea.visible = true;
                        }
                        else if ( path.toString().search('mp3')  >= 0 ||
                             path.toString().search('MP3')  >= 0 ||
                             path.toString().search('wma')  >= 0 ||
                             path.toString().search('WMA')  >= 0 ||
                             path.toString().search('WAV')  >= 0 ||
                             path.toString().search('wav')  >= 0 ||
                             path.toString().search('ogg') >= 0 ||
                             path.toString().search('OGG') >= 0)
                        {
                            JS.showmp3( parent_ip , parent_port , share_folder, folder_list.join('/') + '/' + path , function(MediaPath){
                                playMusic.source = MediaPath;
                                playMusic.play();
                            });
                            listView.visible = false;
                            displayMusic.visible = true;
                        }
                        else if ( path.toString().search('png') >= 0 ||
                             path.toString().search('jpg') >= 0 ||
                             path.toString().search('gif') >= 0 ||
                             path.toString().search('tif') >= 0 ||
                             path.toString().search('bmp') >= 0 ||
                             path.toString().search('PNG') >= 0 ||
                             path.toString().search('JPG') >= 0 ||
                             path.toString().search('GIF') >= 0 ||
                             path.toString().search('TIF') >= 0 ||
                             path.toString().search('BMP') >= 0)
                        {
                            displaypng.source = 'http://' + parent_ip +  ':' + parent_port + '/' + share_folder + folder_list.join('/') + '/' + path;
                            listView.visible = false;
                            displaypng.visible = true;
                            displaypng.width = displaypng.sourceSize.width;
                            displaypng.height = displaypng.sourceSize.height;
                        }
                        else if ( path.toString().search('txt')  >= 0 ||
                             path.toString().search('TXT')  >= 0 ||
                             path.toString().search('js')  >= 0 ||
                             path.toString().search('JS')  >= 0 ||
                             path.toString().search('css')  >= 0 ||
                             path.toString().search('CSS')  >= 0 )
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
                        console.log("[mouse]Clicked.")
                        //folder_list.pop();
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

