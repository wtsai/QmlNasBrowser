var ipaddress = '';
var json;
var json_index = 0;
var doc = new XMLHttpRequest();
var path_list =  ['/'];
var assign_path = '';

function loaddir(dirurl){
    listDirModel.clear();
    /*
    assign_path = '';
    for ( var i = 0 ; i < path_list.length; i++ ) {
        path_list.pop();
    }*/
    listDirModel.append({
        "type": 'Directory',
        "path": '..'
    })
    ipaddress = dirurl;
    doc.onreadystatechange = function() {
        if (doc.readyState == XMLHttpRequest.DONE) {
            json = JSON.parse(doc.responseText.toString());
            for (json_index = 0; json[json_index] != undefined ; json_index++)
            {
                //console.log(json[json_index])
                listDirModel.append({
                    "type": json[json_index]['type'],
                    "path": json[json_index]['path']
                })
            }

        }
    }
    //console.log(ipaddress)
    doc.open("GET", ipaddress);
    doc.send();

}


function loadeddir(nextpath){
    listDirModel.clear();
    assign_path = '/';
    listDirModel.append({
        "type": 'Directory',
        "path": '..'
    })
    //console.log( '[path_list[' + path_list.length + '].toString() ]: ' + path_list[path_list.length-1].toString() );
    //path_list[path_list.length] = nextpath;

    if ( nextpath == '..' && path_list.length > 1)
    {
        path_list.pop();
    }
    else if (nextpath != '..')
    {
        path_list.push(nextpath);

    }
    else
    {
        //console.log( 'The bottom folder now.' );
    }
    //console.log('[Done_path_list[' + path_list.length + ']] ')
    //console.log( '[Done_path_list[' + path_list.length + '].toString() ]: ' + path_list[path_list.length-1].toString() );
    //path_list[path_list.length] = nextpath;

    for ( var i = 1 ; i < path_list.length; i++ ) {
        //console.log( '[path_list[' + i + 1 + '].toString() ]: ' + path_list[i].toString() );
        assign_path = assign_path + path_list[i] + '/';
    }
    //console.log( '[assign_path]: ' + assign_path );

    doc.onreadystatechange = function() {
        if (doc.readyState == XMLHttpRequest.DONE) {
            json = JSON.parse(doc.responseText.toString());
            //console.log("json")
            //for
            for (json_index = 0; json[json_index] != undefined ; json_index++)
            {
                //console.log(json[json_index])
                listDirModel.append({
                    "type": json[json_index]['type'],
                    "path": json[json_index]['path']
                })
            }
        }
    }

    //console.log('[loadeddir]ipaddress: '+ ipaddress)
    //console.log('[loadeddir]assign_path: '+ assign_path)
    doc.open("GET", ipaddress + assign_path);
    doc.send();

}


function showpng(showpng){
    console.log("showpng: " + showpng)
    assign_path = '/';
    for ( var i = 1 ; i < path_list.length; i++ ) {
        console.log( '[path_list[' + i + 1 + '].toString() ]: ' + path_list[i].toString() );
        assign_path = assign_path + path_list[i] + '/';
    }
    console.log("assign_path + showpng: " + assign_path + showpng)
    return assign_path + showpng;
}

function showtxt(parent_ip , parent_port, showtxt){
    console.log("showtxt: " + showtxt)
    assign_path = '/';
    for ( var i = 1 ; i < path_list.length; i++ ) {
        console.log( '[path_list[' + i + 1 + '].toString() ]: ' + path_list[i].toString() );
        assign_path = assign_path + path_list[i] + '/';
    }
    console.log("assign_path + showtxt: " + ipaddress + '/File/Txt' + assign_path + showtxt)

    doc.onreadystatechange = function() {
        if (doc.readyState == XMLHttpRequest.DONE) {
            json = JSON.parse(doc.responseText.toString());
            console.log( json['txt'] );
        }
    }
    doc.open("GET", 'http://' + parent_ip +  ':' + parent_port + '/File/Txt' + assign_path + showtxt);
    doc.send();

    return json['txt'];
}

/*
function destorydir(){
    listDirModel.clear();
    var ipaddress = '';
    assign_path = '';
    for ( var i = 0 ; i < path_list.length; i++ ) {
        path_list.pop();

}
*/
