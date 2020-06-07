[]
<!doctype html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{.!TitleText.}</title>

%style%

{.if|{.!UseJquery.}|
<!-- Jquery is included in this HFS link -->
<script src="/?mode=jquery"></script>
|
<!-- Why don't try FaikQuery? With just partical functions, it's quick! -->
<!-- Finally this thing is finished! Search [sym-faikquery] to see it! -->
%sym-faikquery%
.}
<script>

function browseAbleFolderTree(folder) {
var infoFolder = folder;
var path = folder.split("/");
var pathTree = "/";
var pathTreeResult = "";
for (pta = 1; pta < path.length; pta++) {
    pathTree = pathTree + path[pta] + "/";
    pathTreeResult = pathTreeResult + '/<a href="' + pathTree + '" class=\"swapDir\">' + path[pta] + '</a>';
}
document.getElementById('swapDir').innerHTML = pathTreeResult;
}
</script>
<!-- Moved the deleter to File Handler -->
<!-- Moved the searcher below the Frameworks part -->
</head>

<body>
<!-- Background image and blackening mask: Framework -->
<!-- Customizable on the top of the template -->
{.if|{.!EnableImageBg.}|
<div id="bg"></div><div class="bgmask"></div>%sym-randombg%
| <div id="bg"><div class="bgcss3"></div></div> .}

<!-- Notice: Framework -->
<div class="notice">
    <div id="noticetitle"></div>
    <div id="noticecontent"></div>
</div>

<!-- File list: Framework -->
{.if|{.!EnableHeader.}| <div id="title">{.!HeaderText.}</div> |.}
%login-link%%loggedin%
<a href="/">&#127968;{.!Homepage.} </a><span id="swapDir">%folder%</span>
<script> browseAbleFolderTree("%folder%") </script>
%files%

{.if|{.get|can archive.}|
{:{.if|{.%number-files% > 0.}|
{:{.if|{.%total-kbytes% <= {.!MaxArchiveSizeAllowedToDownloadKb.} .}|
    <div style="text-align: center;">
    <a href="%folder%~folder.tar" onclick="return confirm('{.!Download these.} %number-files% {.!files in a .tar archive?.}');">
        [ {.!Click to Archive.} ]
    </a>
    </div>
.}:}
.}:}
.}
<div class="bottomblank"></div>

<!-- Get to top -->
<div id="get-top"><abbr title="{.!Back to top.}">⬆</abbr></div>
<script>
var prevscroll = 0;
window.onscroll = function () {
    var currscroll = document.documentElement.scrollTop || document.body.scrollTop;
    if (currscroll > 240 && prevscroll < 240) {
        $('#get-top').slideDown();
    } else if (currscroll < 240 && prevscroll > 240) {
        $('#get-top').slideUp();
    }
    prevscroll = currscroll;
}
document.querySelector('#get-top').onclick = function () {
    var scrollspeed = scrollY/30;
    var interval = setInterval(function() {
        scrollY > 0 ? scrollBy(window, -scrollspeed) : clearInterval(interval);
    }, 16)
}
</script>
<div id="addons">
<!-- D.J. Fais (as mini player): Framework -->
<div class="playerdj">
<div id="djinfo" style="display: none;"></div>
<div class="fais">
    <span id="dj"><a href="javascript:">{.!HowDjFaisLooksLike.}</a></span>
    <a href="javascript:"><span id="playerstatus">&#9658;&#10073; </span> <!-- Events see onclick() & oncontextmenu() in _fais() -->
    </a><span id="playertitle"></span>
</div>
</div>
<!-- Preview: Framework -->
<div class="preview" id="previewopen"><span class="tiparrow">&nbsp;</span>
    <a href="javascript: previewfile('?show');">{.!Expand preview frame.}</a>&nbsp;
</div>
<div class="preview">
    <span class="tiparrow">&nbsp;</span><span id="previewtip"></span>
    <a class="close" href="javascript: previewfile('?close')">
        <abbr title="{.!Close preview frame.}">[X]</abbr>
    </a>&nbsp;
    <!-- Actions also contained -->
    <div id="previewactions">
		{.if|{.get|can delete.}|
        <a href="javascript: fileaction('?delete');">{.!Delete.}</a>
		    {.if|{.and|{.!option.move.}|{.can move.}.}| 
            <a href="javascript: fileaction('?move');">{.!Move.}</a>.}
		.}
		{.if|{.can rename.}| <a href="javascript: fileaction('?rename');">{.!Rename.}</a> .}
    </div>
    <div class="fileactioninputs">
        <span id="fileactionlabel"></span> <!-- e.g. Move to: -->
        <input id="fileactioninput" type="text" name="fileactioninput"  />
        <button id="fileactionsubmit">{.!OKay.}</button>
    </div>
    <div style="height: 1px; border-bottom: white 1px solid;"></div>
    <div id="preview">{.!You can preview the selected file here.}</div>
</div>

<!-- Slideshow(pictures): Framework -->
<div class="blackblank" id="slideshow">
<!--
    pic0 -> show0
    show0: fadeout
    pic1 -> show1
    pic0 -> show2
    show0: show
-->
    <div class="slidecontainer" id="slideshow2" style="display: none;">
        <!-- pic1: Ready -->
    </div>
    <div class="slidecontainer" id="slideshow1">
        <!-- pic0: Main -->
    </div>
    <div class="blackblank" id="slideblackside" style="display: none;"></div>
    <div class="slidecontainer" id="slideshow0">
        <!-- pic2: OnSwap -->
    </div>
    <div id="slideshowctrl" class="slidecontainer"></div>
</div>
</div>

<!-- Searcher -->
<script>
function searchQuery() {
    frm = document.searchForm;
    if (frm.query.value.length < 1) {
        alert("{.!Search requires 1 or more characters.}");
    } else {
        frm.recursive.checked ? recursive = "&recursive" : recursive = "";
        for (x = 0; x < frm.choice.length; x++) {
            if (frm.choice[x].checked != 1) return;
            if (frm.choice[x].value == "file") {
                searchMode = "?files-filter=";
                filter = "&folders-filter=%5C";
            } else if (frm.choice[x].value == "folder") {
                searchMode = "?folders-filter=";
                filter = "&files-filter=%5C";
            } else {
                searchMode = "?filter=";
                filter = "";
            }
        }
        for (c = 0; c < frm.root.length; c++) {
            if (frm.root[c].checked != 1) return;
            frm.root[c].value == "current" ? searchFrom = "http://%host%%folder%" : searchFrom = "http://%host%";
        }
        document.location.href = searchFrom + searchMode + "*" + frm.query.value + "*" + recursive + filter;
    }
}
</script>

%sym-addonpre%
%sym-preview%
%sym-djfais%
%sym-slideshow%
%sym-thumb%
%sym-fileactions%
</body>
</html>

[login-link]
<div class=btn><a href="/~signin">&#128100; {.!Login.}</a></div>
[loggedin]
<div class=btn>
    <span id="sid" style="display: none"></span>
    <a href="/~signin">&#128100; %user%</a>
    <a href="/~signin" class="inverted">&nbsp;{.!Manage.}&nbsp;</a>
</div>

[upload-link]
<a href="%encoded-folder%~upload" class="inverted uploadbutton">&#8679;&nbsp;{.!Upload Files.}</a>

[files]
<!-- Search box -->
{.if|{.%connections% > 64.}|{:<br />:}|{:<div style="margin-top: 4px; border-bottom: white 1px solid;">
    <form class="hide" name="searchForm" method="GET" action="javascript:searchQuery()">
    <input class="searchbox" placeholder="{.!Search files here....}" type="search" name="query" size="23"
        maxlength="32"><input class="searchbutton" type="submit" name="searchBtn" value="&#128269;">
    <input type="hidden" name="choice" value="file" checked="1">
    <input type="hidden" name="choice" value="folder" checked="1">
    <input type="hidden" name="choice" value="both" checked="1">
    <input type="hidden" name="recursive" checked="1">
    <input type="hidden" name="root" value="root" checked="1">
    <input type="hidden" name="root" value="current" checked="1">
    <!-- Upload button(link) -->
    %upload-link%
    </form>
</div>
<!-- Banner/text -->
<div class="statustext">
    <span><a href="http://rejetto.com/hfs/" target="_blank"
        style="color: {.if|{.%connections% > {.!ThresholdConnectionsOfTuringStatusRed.}.}|{:#996644:}|{:#228833:}.};">
        {.!StatusText.}</a>
    </span>
</div>:}.}
<!-- File list: Table headline -->
<table id="files">
<tr class="trhead">
    <td class="l"><a href="%encoded-folder%?sort=e">
            &#128311;&nbsp;
        </a><a href="%encoded-folder%?sort=n">
            <abbr title="{.!Click to sort files by this.}">{.!FileName.}</abbr>
        </a> (%number-files%)<span id='menu-bar'>&nbsp;</span>
        <span id="showthumb">
            <a href="javascript: showthumbnail();">📸 {.!Photo Thumbnails.}</a>
        </span>
    </td>
    <td class="m"><a href="%encoded-folder%?sort=!t">
            <abbr title="{.!Format.}: {.!DateTimeFormat.}\n{.!Click to sort files by this.}">{.!Date on Edit.}</abbr>
        </a></td>
    <td class="r"><a href="%encoded-folder%?sort=s">
            <abbr title="{.!Click to sort files by this.}">{.!Size.}</abbr>
        </a></td>
</tr>%list%
</table>

{.comment| For special date&time format .}

[+special:alias|cache]
item-modified-datetime-formated={.time|format={.!DateTimeFormat.}|when=%item-modified-dt%.}

[file]
<tr>
<td class="file"><a href="%item-url%">%item-name%</a></td>
<td class="modified">
    {.if|{.!UseSpecialDateTimeFormat.}|
        {.item-modified-datetime-formated.}
    | %item-modified% .}</td>
<td class="size">%item-size%B<span class='del' data-it='%item-url%'></span></td>
</tr>

[link]
<tr>
<td class="link"><a href="%item-url%" target="_blank">%item-name%</a></td>
<td class="modified">. . . &nbsp;</td><td class="sizenone">{.!link.}&nbsp;</td>
</tr>

[folder]
<tr>
<td class="folder"><a href="%item-url%"><b>%item-name%</a></b></td>
<td class="modified">
    {.if|{.!UseSpecialDateTimeFormat.}|
        {.item-modified-datetime-formated.}
    | %item-modified% .}</td>
<td class="sizenone">{.!folder.}&nbsp;</td>
</tr>

[nofiles]
{.if|{.%connections% < 65.}|
{:{.if|{.get|can upload.}|
{:<div style="text-align: center; margin-top: 4px; border-bottom: white 1px solid;">
<a class="inverted" href="%encoded-folder%~upload" style="font-weight: bold;">
    &#8679;&nbsp;{.!Upload Files.} </a></div>:}
.}:}
.}
<div class="nofile">{.!It seems nothing here....}</div>
<script>setTimeout(function () { window.location.href = '../'; }, 12000);</script>
