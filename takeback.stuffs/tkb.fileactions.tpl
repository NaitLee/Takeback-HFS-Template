
[sym-fileactions]
<script>
// File handler (Actions to file)
function del(it) {
    if (!confirm("{.!Delete.} " + (it=='.'?'{.!current FOLDER.}':it) + "?")) return 0;
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "%folder%");
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
    xhr.onload = function() {
        document.write(xhr.responseText.trim());
        // Do 'back' rather than refresh while deleting/doing sth to a folder,
        //  otherwise user will face a chance to get a 404, even an innocent ban
        it=='.' ? window.history.go(-1) : location.reload(false);
    };
    xhr.send("action=delete&selection=" + it);
}
function _fileaction(method, file, target, handler) {
    if (!handler) handler = function () {}
    var actionreadable = method;
    switch (method) {
        case 'mkdir':
            actionreadable = '{.!make a folder.}'; break;
        case 'move':
            actionreadable = '{.!move.}'; break;
        case 'rename':
            actionreadable = '{.!rename.}'; break;
        case 'comment':
            actionreadable = '{.!comment.}'; break;
        default:
            actionreadable = method;
    }
    if (!confirm("{.!Do.} "+ actionreadable + ' ' + (file=='.'?'{.!current FOLDER.}':file) + ' {.!to.} ' + target + "?")) return 0;
    var xhr2 = new XMLHttpRequest();
    xhr2.open("POST", "?mode=section&id=ajax."+method);
    xhr2.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
    xhr2.onload = function() {
        handler(xhr2.responseText);
        // Do 'back' rather than refresh while deleting/doing sth to a folder,
        //  otherwise user will face a chance to get a 404, even an innocent ban
        file=='.' ? window.history.go(-1) : location.reload(false);
    };
    var hfstoken = '{.cookie|HFS_SID_.}';
    xhr2.send("from="+file+"&to="+target+"&token="+hfstoken);
}
function fileaction(ctrl) {
    var method = '', handler = function () {};
    var file = '.'; var target = '.';
    switch (ctrl) {
        case '?delete':
            method = 'delete';
            if (method=='delete') {
                del(window.location.href.indexOf(encodeURI(previewtip.innerHTML))<0 ? previewtip.innerHTML : '.');
                return;
            }
            break;
        case '?rename':
            method = 'rename';
            fileactionlabel.innerHTML = '{.!Rename as.}: ';
            fileactioninput.placeholder = '{.!Input file name....}';
            break;
        case '?move':
            method = 'move';
            fileactionlabel.innerHTML = '{.!Move to.}: ';
            fileactioninput.placeholder = '{.!Input distination....}';
            handler = function (res) {
                var a = res.split(";");
                if (a.length < 2)
                    return alert(res.trim());
                var failed = 0, ok = 0, msg = "";
                for (var i=0; i<a.length-1; i++) {
                    var s = a[i].trim();
                    if (!s.length) { ok++; continue; }
                    failed++; msg += s+"\n";
                }
                if (failed) msg = "{.!We met the following problems.}:\n"+msg;
                msg = (ok ? ok+" {.!Files were moved..}\n" : "{.!No file was moved..}\n")+msg;
                alert(msg);
                // if (ok) location = location; // reload, included in xhr.onload
            }
            break;
        case '?comment':
            // Not used currently
            method = 'comment';
            fileactionlabel.innerHTML = '{.!Comment file.}: ';
            fileactioninput.placeholder = '{.!Input something....}';
            break;
    }
    $('.fileactioninputs').slideDown();
    fileactionsubmit.onclick = function () {
        file = window.location.href.indexOf(encodeURI(previewtip.innerHTML))<0 ? previewtip.innerHTML : '.';
        target = fileactioninput.value;
        console.log(method, file, target, handler);
        _fileaction(method, file, target, handler);
    }
}
</script>
