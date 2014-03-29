function loaddir(parent_ip, parent_port, parent_router){
    var json_loaddir;
    var json_index = 0;
    var doc_loaddir = new XMLHttpRequest();
    listDirModel.clear();
    listDirModel.append({
        "type": 'Directory',
        "path": '..'
    })
    doc_loaddir.onreadystatechange = function() {
        if (doc_loaddir.readyState == XMLHttpRequest.DONE) {
            json_loaddir = JSON.parse(doc_loaddir.responseText.toString());
            for (json_index = 0; json_loaddir[json_index] != undefined ; json_index++)
            {
                listDirModel.append({
                    "type": json_loaddir[json_index]['type'],
                    "path": json_loaddir[json_index]['path']
                })
            }

        }
    }
    doc_loaddir.open("GET", 'http://' + parent_ip +  ':' + parent_port + parent_router);
    doc_loaddir.send();

}

function loadeddir(parent_ip, parent_port, parent_router, assign_path){
    var json_loadeddir;
    var json_index = 0;
    var doc_loadeddir = new XMLHttpRequest();
    listDirModel.clear();
    listDirModel.append({
        "type": 'Directory',
        "path": '..'
    })
    doc_loadeddir.onreadystatechange = function() {
        if (doc_loadeddir.readyState == XMLHttpRequest.DONE) {
            json_loadeddir = JSON.parse(doc_loadeddir.responseText.toString());
            for (json_index = 0; json_loadeddir[json_index] != undefined ; json_index++)
            {
                listDirModel.append({
                    "type": json_loadeddir[json_index]['type'],
                    "path": json_loadeddir[json_index]['path']
                })
            }
        }
    }

    doc_loadeddir.open("GET", 'http://' + parent_ip + ':' + parent_port + parent_router + assign_path);
    doc_loadeddir.send();

}

function showtxt(parent_ip , parent_port, share_folder, assign_path, callback){
    var json_showtxt;
    var returntxt = '';
    var doc_showtxt = new XMLHttpRequest();
    doc_showtxt.onreadystatechange = function() {
        if (doc_showtxt.readyState == XMLHttpRequest.DONE) {
            json_showtxt = JSON.parse(doc_showtxt.responseText.toString());
            returntxt = json_showtxt['txt'].toString();
            if (callback)
                return callback(returntxt);
        }
    }
    doc_showtxt.open("GET", 'http://' + parent_ip +  ':' + parent_port + '/File/Txt/' + assign_path);
    doc_showtxt.send();

}
