
[upload]
{.add header|Cache-Control: no-cache, max-age=0.}
<!doctype html>
<!-- Upload page -->
<html>

<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{.!Upload to.}: %folder%</title>
%style%
<script>
var counter = 0;
function addUpload() {
    // Add an upload selection
    counter++;
    if (counter < 6) {
        document.getElementById("addupload").innerHTML += "<p style='margin: 0.6em;'></p><input class='upload' name=\"fileupload" + 
            counter + "\" size=\"50\" type=\"file\">";
    }
    if (counter == 5) {
        document.getElementById("addUploadLink").innerHTML = 
            "<div style=\"color:yellow;\">-- {.!Please put multiple files into a zip file.} --</div>";
    }
}
</script>
</head>

<body style="background-color: black; text-align: center;">
    <!-- Background -->
    {.if|{.!EnableImageBg.}|
        <div id="bg"></div>
        <div class="bgmask"></div>
        %sym-randombg%
    |
        <div class="bgcss3"></div>
    .}
    <!-- Content: Upload -->
    <div style="text-align: left; border-bottom: white 1px solid; margin-bottom: 4px;">
        <b>{.!Upload to.}: </b>%folder%<br />
        <a href="./">&#8678; {.!Back.}</a>
        <a class="inverted" style="float: right;"
        href="javascript: shownewfolder();">
            &#128193; {.!New folder.}
        </a>
    </div>
<div>
{.if|{.%number-addresses-downloading%*%speed-out% < 7500.}|{:
    {.if|{.can mkdir.}|{:
        <script>
            function shownewfolder () {
                document.querySelector('#newfolder').style['display'] = 'block';
            }
        </script>
        <div id='newfolder' style="border-bottom: white 1px solid; display: none;">
            {.!You can also make a new folder.}:<br />
            <input class="upload" id="foldername" type='text' name='fldname' maxlength="25"
                size="25" placeholder="{.!Input folder name....}"><br />
            <button id="createfolder" class="upload">{.!Create Folder.}</button>
            <script>
                createfolder.onclick = function () {
                    var xhr2 = new XMLHttpRequest();
                    // We should post this ajax message to the upload FOLDER, not the ~upload page.
                    xhr2.open("POST", "./?mode=section&id=ajax.mkdir");
                    xhr2.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
                    xhr2.onload = function() { alert(xhr2.responseText); window.history.go(-1) };
                    var hfstoken = '{.cookie|HFS_SID_.}';
                    xhr2.send("&name="+foldername.value+"&token="+hfstoken);
                }
            </script>
            <br />{.!Turns to the file list page after making a folder.}<br /><br />
        </div>
    :}.}
    <b>{.!Free Space Available For Upload.}:<br />%diskfree%B</b>
    <br /><br />
    <div style="font-size: 0.8em;">
        {.!Choose some files.}<br />{.!then tap the "Send file(s)" below.}
    </div><br />
    <form action="%encoded-folder%" target=_parent method=post enctype="multipart/form-data" onSubmit="return true;">
        <div id="addupload"><input class="upload" multiple name="fileupload1" size="50" type="file"></div><br />
        <a id="addUploadLink" style="cursor:pointer;" onclick="addUpload();">
            [ {.!Tap to add a selection.} ]
        </a><br /><br />
        <div style="font-size: 0.8em;">
            {.!Adding an upload selection will cause file selections reset.}<br />
            {.!Only the first selection supports multi-file selection.}
        </div><br />
        <input class="upload" name=upbtn type=submit value="{.!Send File(s).}">
    </form>
    {.!Results page appears after uploads complete.}
:}|{:
    <b>{.!Upload is not available to due to high server load.}</b>
    <br /><br />{.!Automatically retrying after 5 seconds....}
    <script>
        setTimeout(function() { window.location.href = './~upload'; }, 5000);
    </script>
:}.}
</div>
</body>

</html>

[upload-results]
<!doctype html>
<html>

<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="refresh" content="4;url=./">
%style%
<title>{.!Upload result.}: %folder%</title>
</head>
<body>
{.if|{.!EnableImageBg.}|
    <div id="bg"></div>
    <div class="bgmask"></div>
    %sym-randombg%
| <div class="bgcss3"></div> .}
<div>{.!Upload result.}: %folder%</div>
<div>%uploaded-files%<br /><br />
    <a href="%encoded-folder%" target=_parent>
        &#8678; {.!Go Back.}
    </a>
</div>
</body>

</html>

[upload-success]
<li><b>{.!SUCCESS.}: </b>%item-name% - %item-size%B ({.!Speed.}: %speed% KB/s)</li>

[upload-failed]
<li><b>{.!FAILED.}: </b>%item-name% - %reason%</li>
