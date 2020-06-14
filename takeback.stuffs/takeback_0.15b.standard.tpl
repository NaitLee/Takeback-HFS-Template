<!--
        The Takeback Template:
            http://rejetto.com/forum/index.php?topic=13287.0
        Licensed under 2-Clause BSD.
-->

[api level]
2

[+special:strings]
HowDjFaisLooksLike=\( •̀ ω •́ )✧ ♫

[special:import]
{.set ini|use-system-icons=no.}
{.set ini|log-progress=no.}
{.set ini|log-dump-request=no.}
{.set ini|log-only-served=yes.}
{.set ini|tray-icon-for-each-download=no.}
{.set ini|enable-fingerprints=no.}
{.set ini|send-hfs-identifier=no.}
{.set ini|support-descript.ion=no.}
{.set ini|load-single-comment-files=no.}
{.set ini|hints4newcomers=no.}
{.set ini|save-totals=no.}
{.set ini|tray-shows=ips.}
{.set ini|flash-on= .}
{.set ini|browse-localhost=no.}

[+special:strings]

{.comment| Use special date&time format? 0 to disable, other values to enable .}
UseSpecialDateTimeFormat=1
DateTimeFormat=dd/mm/yyyy
{.comment| Format sample: DateTimeFormat=mm/dd/yyyy hh:MM:ss ampm .}

{.comment| What will the title(browser tab) show? .}
TitleText=HFS::%folder%

{.comment| Use JQuery instead of FaikQuery? .}
UseJquery=0
{.comment|
    The webpage goes fast with FaikQuery, because this only includes functions
        that are needed in this webpage/template, and with less operations.
    If you need edit this template with jQuery features(other than animations), turn it on.
    It's finally finished! With a cool animation replaced the slideUp/slideDown!
.}

{.comment|
    Enable image background?
    Put pictures in your speciefied folder to see them randomly appear
    as the background of your page
.}
EnableImageBg=0
BgFolder=/pic/img/bg/

{.comment| What will the header show?   -- Texts wrapped by {.! .} will be able to be replaced("translated") by defining them like those ones below.}
EnableHeader=0
HeaderText={.!HTTP File System.}

{.comment| What will the statustext show? .}
EnableStatus=1
StatusText={.!Files here are available for view & download.}

{.comment| How will Fais looked like? .}
HowDjFaisLooksLike=\( •̀ ω •́ )✧ ♫

{.comment| ... and more below .}
MaxArchiveSizeAllowedToDownloadKb=128000
ThresholdConnectionsOfTuringStatusRed=64
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
%sym-font%
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


[sym-faikquery]

<!-- Thanks to http://youmightnotneedjquery.com/#fade_in, I got this animation structure! -->

<style>
.fkfadein { opacity: inherit; }
.fkfadout { opacity: 0; }
.fkslidwn { transform: inherit; }
/* Though we can't animate height, we can make a cooler one */
.fkslidup { transform: scale(0) translateX(16em); }
</style>

<script>
function _$(querier) {
var elements = document.querySelectorAll(querier);
this.hide = function () {
    elements.forEach(function(element, index) {
        element.style.display = 'none';
        element.classList.remove('fkfadein', 'fkfadout', 'fkslidup', 'fkslidwn');
    });
}
this.fadeOut = function (timeout) {
    if (!timeout) timeout = 400;
    elements.forEach(function(element, index) {
        element.style.transition = 'all '+timeout+'ms';
        setTimeout(function () {
            element.classList.add('fkfadout');
            element.classList.remove('fkfadein', 'fkslidwn');
        }, 16)
        setTimeout(function() {
            element.style.transition = '';
            element.style.display = 'none';
        }, timeout-1)
    });
}
this.slideUp = function (timeout) {
    if (!timeout) timeout = 400;
    elements.forEach(function(element, index) {
        element.style.transition = 'all '+timeout+'ms';
        setTimeout(function () {
            element.classList.add('fkslidup');
            element.classList.remove('fkslidwn', 'fkfadout');
        }, 16)
        setTimeout(function() {
            element.style.transition = '';
            element.style.display = 'none';
        }, timeout-1)
    });
}
this.show = function () {
    elements.forEach(function(element, index) {
        element.style.display = 'block';
        element.classList.remove('fkfadein', 'fkfadout', 'fkslidup', 'fkslidwn');
    });
}
this.fadeIn = function (timeout) {
    if (!timeout) timeout = 400;
    elements.forEach(function(element, index) {
        element.classList.add('fkfadout');
        element.style.transition = 'all '+timeout+'ms';
        element.style.display = 'block';
        setTimeout(function () {
            element.classList.remove('fkfadout', 'fkslidup');
            element.classList.add('fkfadein');
        }, 16)
        setTimeout(function() {
            element.style.transition = '';
            element.style.display = 'block';
        }, timeout)
    });
}
this.slideDown = function (timeout) {
    if (!timeout) timeout = 400;
    elements.forEach(function(element, index) {
        element.classList.add('fkslidup');
        element.style.display = 'block';
        element.style.transition = 'all '+timeout+'ms';
        setTimeout(function () {
            element.classList.remove('fkfadout', 'fkslidup');
            element.classList.add('fkslidwn');
        }, 16)
        setTimeout(function() {
            element.style.transition = '';
            element.style.display = 'block';
        }, timeout)
    });
}
}
function $(element) { return new _$(element); }
</script>

[sym-preview]
<script>
var noticedpreview = false;
var givetofais = false;
// Previewing: Core script
function _previewfile(url) {
    var fileurl = decodeURI(url);
    var filename = spliturllast(fileurl);
    // Judge the file type
    var filetype = 'unknown';
    switch (url.slice(-4).toLowerCase()) {
        case '.png': case '.jpg': case 'jpeg':
        case '.gif': case 'webp': case '.ico':
            filetype = 'image';
            break;
        case '.txt': case 'html': case '.htm':
            filetype = 'text';
            break;
        case '.mp3': case '.m4a':
        case '.wav': case '.ogg': // '.ogg' can be an audio and/or video.
            filetype = 'audio';
            break;
        case '.mp4': case 'webm':
        case '.ogv':    // Name an '.ogg' as '.ogv' to view as a video here.
            filetype = 'video';
            break;
        case '.swf':
            filetype = 'flash';
            break;
        case '.rtf':
        case '.doc': case 'docx': case '.odt':
        case '.xls': case 'xlsx': case '.ods':
        case '.ppt': case 'pptx': case '.odp':
            filetype = 'workdocument';
            break;
        default:
            filetype = 'unknown';
            break;
    }
    // Define the preview content
    previewcontent = '';
    switch (filetype) {
        case 'image':
            previewcontent = '{.!Tap photo to start a slideshow; Right-click/Long-press to save.}&nbsp;<br />\
                <a href="javascript: slideshow(\'?start\')"><img class="previewimg" id="previewobject" src="'+fileurl+'" /></a><br />';
            break;
        case 'audio':
            previewcontent = '<audio controls loop autoplay><source src="'+fileurl+'">\
                {.!Sorry, previewing this file is not sopported by your browser.}</audio><br />\
                <a href="javascript: previewfile(\'?fais\', \''+fileurl+'\')"><span style="color: wheat">[{.!Move to mini player.}]</span>&nbsp;</a>';
            break;
        case 'video':
            previewcontent = '{.!Rotate your device to fullscreen if mobile.}<br />\
                <video controls loop autoplay class="previewvid" id="previewobject"><source src="'+fileurl+'">\
                {.!Sorry, previewing this file is not sopported by your browser.}</video><br />';
            break;
        case 'text':
            previewcontent = '<iframe class="previewiframe" id="previewobject" src="'+fileurl+'">\
                {.!Previewing not supported, please try dowload.}</iframe><br />';
            break;
        case 'flash':
            previewcontent = '{.!Enable flash plug-in in your browser/site settings to view.}&nbsp;<br />\
                {.!Mobile platforms will not support flash anymore.}&nbsp;<br />\
                <embed class="previewflashobject" id="previewobject" src="'+fileurl+'" type="application/x-shockwave-flash" />\
                <div><a class="previewflashfullscreenexit" href="javascript: previewfile(\'?flashfullscreenexit\');"><abbr title="{.!Exit Fullscreen.}">[X]</abbr></a></div>\
                <br /><a href="javascript: previewfile(\'?flashfullscreen\')">[{.!Tap here to fullscreen.}]&nbsp;</a>';
            break;
        case 'workdocument':
            previewcontent = ( url.indexOf('127.0.0')<0 && url.indexOf('192.168')<0 && url.indexOf('localhost')<0 ?     // If no local IP/hostnames in location
                '{.!You can preview this document with Microsoft Office Online service.}<br />\
                    <a href="https://view.officeapps.live.com/op/view.aspx?src='+url+'" target="_blank"><span style="color: wheat" >[{.!View online.}]</span> </a>' : 
                '{.!Unable to view online: this site is in LAN.}<br />' );
            break;
        default:
            previewcontent = '<span style="color: yellow">{.!Previewing not supported, please try dowload.}</span>&nbsp;<br />';
            break;
    }
    previewcontent += '<a href="'+filename+'" onclick="previewfile(\'?download\', \''+filename+'\');"><span style="color: cyan">[{.!Tap here to download.}]</span>&nbsp;</a>'
    if (filetype=='audio' && givetofais==true) {
        previewfile('?fais', url);
    } else {
        previewtip.innerHTML = spliturllast(fileurl);   // spliturllast() in "addon.pre"
        preview.innerHTML = previewcontent;
        previewfile('?show');
    }
    console.log('%c\nPreviewing file:\n'+fileurl+'\nIts type is '+filetype, 'color: teal;');
    if (!noticedpreview && filetype!='unknown') {
        notice('{.!Slide up the screen to see if using a mobile.}', '{.!Preview Opened.}');
        noticedpreview = true;
    }
}

// Previewing: Shell script
function previewfile (ctrl, url) {
    switch (ctrl) {
        case '?show':
            $('.preview').slideDown(); $('#previewopen').slideUp(); break;
        case '?open':
            _previewfile(url); break;
        case '?close':
            $('.preview').slideUp(); $('#previewopen').slideDown(); break;
        case '?download':
            window.location.href = url; 
            notice(url, '{.!Starting Download.}: '+decodeURI(url));
            break;
        case '?fais':
            if (document.querySelector('audio')!=null) document.querySelector('audio').pause();
            fais('?play', url); previewfile('?close');
            givetofais = true;
            break;
        // For flash. Though this thing is dying, but there are still mini-games come with flash
        case '?flashfullscreen':
            $('.previewflashobject').addClass('flashfullpaged');
            $('.previewflashfullscreenexit').fadeIn();
            notice('{.!Exit by tapping the [X].} =>', '{.!Fullscreened.}');
            break;
        case '?flashfullscreenexit':
            $('.previewflashobject').removeClass('flashfullpaged');
            $('.previewflashfullscreenexit').fadeOut();
            break;
        default:
            previewfile('?open', url);
    }
}
previewfile('?show');
</script>

[sym-addonpre]
<script>
function _notice(content, title, timeout) {
    // When the previous notice not hidden
    $('.notice').hide();
    clearTimeout(noticetimeout);
    // Start a notice
    noticetitle.innerHTML = title;
    noticecontent.innerHTML = content;
    $('.notice').slideDown(160);
    console.log('%c\nNotice:\n'+title+'\n'+content, 'font-weight: bold;');
    var noticetimeout = setTimeout(function () { $('.notice').fadeOut(300); }, timeout ? timeout : 3200);
}    
// $('.notice').slideUp();

function notice(message, titlemessage, timeout) {
    _notice(message, titlemessage, timeout);
}

/***
 *  Fullscreen request & exit, by niewzh (CSDN Blog)
 *  requestFullScreen(document.documentElement); exitFullScreen(document);
 *  Link: https://blog.csdn.net/scaped/java/article/details/80297743
 */
function requestFullScreen(element) {
    var requestMethod = element.requestFullScreen || element.webkitRequestFullScreen || element.mozRequestFullScreen || element.msRequestFullScreen;
    if (requestMethod) {
        requestMethod.call(element);
    } else if (typeof window.ActiveXObject !== "undefined") {
        var wscript = new ActiveXObject("WScript.Shell");
        if (wscript !== null) wscript.SendKeys("{F11}");
    }
}
function exitFullScreen(element) {
    var exitMethod = element.exitFullScreen || element.webkitCancelFullScreen || element.mozCancelFullScreen || element.msExitFullScreen;
    if (exitMethod) { exitMethod.call(element); }
    else if (typeof window.ActiveXObject !== "undefined") {
        var wscript = new ActiveXObject("WScript.Shell");
        if (wscript !== null) wscript.SendKeys("{F11}");
    }
}


// Preparition: Query all file links on the page
// Many functions will use them
function spliturllast(url, indexnegative) {
    // 'http://example.net/folder/file.txt' -> 'file.txt'
    var urlparts = url.split('/');
    if (!indexnegative) indexnegative = 1;
    return urlparts[urlparts.length-indexnegative];
}
// Show current folder in preview title
previewtip.innerHTML = decodeURI(spliturllast(window.location.href, 2)+'/');
function _filestatics () {
    this.filelistnodes = document.querySelectorAll('td.file a');
    this.filelist = [];
    this.musiclist = [];
    this.picturelist = [];
}
var filestatics = new _filestatics();

filestatics.filelistnodes.forEach(function(filelistnode, index) {
    var url = spliturllast(filelistnode.href);
    filestatics.filelist.push(url);
    // Prevent browser from directly downloading a file on click, and preview
    filelistnode.onclick = function(event) {
        event.preventDefault();
        previewfile('?open', this.href);
    }
    if (['.mp3', '.wav', '.ogg'].indexOf(url.slice(-4).toLowerCase()) != -1) {
        filestatics.musiclist.push(url);
    } else if (['.png', '.jpg', 'jpeg', '.gif', 'webp'].indexOf(url.slice(-4).toLowerCase()) != -1) {
        filestatics.picturelist.push(url);
    }
});
</script>

[sym-djfais]
<script>
// D.J. Fais: Core (Constructor)
function _djfais () {
    var playlist = filestatics.musiclist, num = 0, sequence = [], shuffle = true;

    playlist.forEach(function (url, index) {
        // Randomizer
        var rnd = Math.floor(Math.random() * playlist.length);
        if (sequence[index-1]!=undefined && sequence[index-1]==rnd) {
            rnd = (index%2==1 ? ++rnd : --rnd ) % playlist.length;
        }
        if (sequence.length==index-1) sequence[index] = (sequence[index] + 1) % playlist.length;
        sequence.push(rnd);
    });

    this.audio = new Audio();
    var self = this;
    var fais = document.querySelector('#dj a');
    function switchsong (ctrl) {
        switch (ctrl) {
            case '?next': num = num==sequence.length-1 ? num=0 : num + 1; break;
            case '?prev': num = num==0 ? num=sequence.length-1 : num - 1; break;
            default:
                throw "Ctrl Error: Unknown ctrl type '"+ctrl+"' at switchsong() at "+this;
        }
        self.audio.src = playlist[shuffle ? sequence[num] : num];
        self.audio.play();
    }
    var scheinfoclose = 0;
    function info (message) {
        clearTimeout(scheinfoclose);
        djinfo.innerHTML = message;
        $('#djinfo').slideDown();
        scheinfoclose = setTimeout(function () { $('#djinfo').slideUp(); }, 2000);
    }
    $('#djinfo').slideUp();
    fais.onclick = function (event) {
        switchsong('?next'); info('{.!Play Next.}');
    }
    fais.oncontextmenu = function (event) {
        event.preventDefault();
        switchsong('?prev'); info('{.!Play Previous.}');
    }
    playerstatus.onclick = function (event) {
        self.audio.paused ? self.audio.play() : self.audio.pause();
    }
    playerstatus.oncontextmenu = function (event) {
        event.preventDefault();
        shuffle = !shuffle;
        info('{.!Play mode.}: ' + (shuffle==true ? '{.!Shuffled.}' : '{.!Sequenced.}'));
    }
    this.audio.onplay = function() {
        if (!self.audio.src) switchsong('?next');
        document.querySelector('span#playerstatus').textContent = "\u25BA {.!Playing.}: "
        }
    this.audio.onpause = function() {
        document.querySelector('span#playerstatus').textContent = "\u2759\u2759 {.!Paused.}: "
    }
    this.audio.onloadedmetadata = function() {
        musicTitle = decodeURI(self.audio.getAttribute("src"));
        playertitle.innerHTML = musicTitle + ' ';
        document.title = musicTitle + " - {.!TitleText.}";
        playertitle.innerHTML += '[' + new Date(self.audio.duration * 1000).toJSON().slice(14, -5) + ']';
    }
    this.audio.onended = function() { switchsong('?next'); }
    this.audio.onerror = function() { self.audio.onended() }
}

// D.J. Fais: Shell
function fais (ctrl, url) {
    if (typeof player != 'object') player = new _djfais();
    switch (ctrl) {
        case '?show':
            if (document.querySelector('.playerdj').style.display=='block'
                ||document.querySelector('.playerdj').style.height!=0) return;
            $('.playerdj').slideDown();
            console.log('%c\n{.!HowDjFaisLooksLike.} D.J. Fais is here~', 'color: blue;');
            break;
        case '?play':
            fais('?show'); player.audio.src = url; player.audio.play();
            break;
        default:
            throw "Ctrl Error: Unknown ctrl type '"+ctrl+"' at fais()"
    }
}
if (filestatics.musiclist.length > 3) { fais('?show'); }
</script>

[sym-slideshow]
<script>
// Slideshow: Script
function _slideshow (timeout, switchtime) {
    var num=0;
    var self = this;
    slideshow1.innerHTML += '<img class="slidepic" />';
    slideshow2.innerHTML += '<img class="slidepic" />';
    slideshow1.children[0].src = filestatics.picturelist[num++];
    slideshow2.children[0].src = filestatics.picturelist[num++];
    requestFullScreen(document.documentElement);
    $('table#files').slideUp(); // Hide file list to hide scroll bar
    previewfile('?close');
    $('#slideshow').fadeIn();
    this.switchslide = function () {
        if (num >= filestatics.picturelist.length) num = 0;
        $('#slideblackside').show();
        $('#slideshow0').show();
        slideshow0.innerHTML = slideshow1.innerHTML;
        slideshow1.innerHTML = slideshow2.innerHTML;
        $('#slideblackside').fadeOut(switchtime);
        $('#slideshow0').fadeOut(switchtime)
        setTimeout(function() {
            slideshow2.innerHTML = slideshow0.innerHTML;
            slideshow2.children[0].src = filestatics.picturelist[num++];
        }, switchtime);
    }
    var switchtimeout = 0;
    var switchinterval = 0;
    this.start = function () {
        clearTimeout(switchtimeout);
        switchinterval = setInterval(function () {
            switchtimeout = setTimeout(self.switchslide, timeout);
        }, timeout);
        setTimeout(self.switchslide, timeout);
        slideshowctrl.onclick = function (event) {
            self.switchslide();
            clearTimeout(switchtimeout);
        }
        slideshowctrl.oncontextmenu = function (event) {
            event.preventDefault();
            self.stop();
        }
    }
    this.stop = function () {
        $('#slideshow').fadeOut();
        $('table#files').slideDown();
        clearTimeout(switchtimeout);
        clearInterval(switchinterval);
        exitFullScreen(document);
    }
}
// Slideshow: Shell function
function slideshow (ctrl) {
    switch (ctrl) {
        case '?start':
            notice('{.!Tap screen for next, rightclick/longpress to exit.}', '{.!Slideshow will start after 3 seconds.}');
            setTimeout(function () {
                if (typeof window.show) window.show = new _slideshow(5000, 1000);
                show.start();
            }, 3200);
            break;
        case '?next':
            show.switchslide(); break;
        case '?stop':
            show.stop(); break;
            // window.show = null;
        default:
            throw "Ctrl Error: Unknown ctrl type '"+ctrl+"' at slideshow()";
    }
}
</script>

[sym-thumbnail]
<script>
var thumbshown = false;
function showthumbnail () {
    if (thumbshown) return;
    thumbshown = true;
    var sum = filestatics.picturelist.length;
    var num = 0;
    var interval = 0;
    var numberonceshow = 5;
    var delay = 3000;
    // Reduce the server's load by delaying
    function addthumb() {
        for (var i=num; i<num+numberonceshow; i++) {
            var element = filestatics.filelistnodes[filestatics.filelist.indexOf(filestatics.picturelist[i])];
            if (element) element.innerHTML = '<img class="thumbnail" src="'+filestatics.picturelist[i]+'" />' + element.innerHTML;
        }
        if (num>=sum) { clearInterval(interval);}
        num += numberonceshow;
    }
    addthumb();
    interval = setInterval(function(){ addthumb(); }, delay);
}
if (filestatics.picturelist.length > 3 && filestatics.picturelist.length < 65) { showthumb.style.display='inline'; }
</script>

[sym-randombg]

<script>
function randomOneIn(sth) {
    return sth[Math.floor(Math.random()*sth.length)];
}
var linkGettingList = '{.!BgFolder.}?tpl=list&folders-filter=\\&recursive';
function requestimage() {
var xhr1 = new XMLHttpRequest();
xhr1.open('get', linkGettingList);
xhr1.onreadystatechange = function () {
    if (xhr1.readyState === 4) {
        var lines = xhr1.responseText;
        if (xhr1.status == 429) {
            console.log('Network busy (429). Retrying in few seconds...');
            setTimeout(e => requestimage(), 1000);
            return;
        }
        var bgImgLocs = lines.split('\n');
        var selectedImage = randomOneIn(bgImgLocs);
        console.log("Selected image for bg: \n" + selectedImage);
        bg.style.backgroundImage = "url("+selectedImage+")";
    }
}
xhr1.send();
}
requestimage();
</script>

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

{.comment| Macros needed to control files .}

[+special:alias]
check session=if|{.{.cookie|HFS_SID_.} != {.postvar|token.}.}|{:{.cookie|HFS_SID_|value=|expires=-1.} {.break|result={.!Bad session.}.}:}
can mkdir=and|{.get|can upload.}|{.!option.newfolder.}
can comment=and|{.get|can upload.}|{.!option.comment.}
can rename=and|{.get|can delete.}|{.!option.rename.}
can change pwd=member of|can change password
can move=or|1|1
escape attr=replace|"|&quot;|$1
commentNL=if|{.pos|<br|$1.}|$1|{.replace|{.chr|10.}|<br />|$1.}
add bytes=switch|{.cut|-1||$1.}|,|0,1,2,3,4,5,6,7,8,9|$1 Bytes|K,M,G,T|$1Bytes

[ajax.mkdir|no log]
{.check session.}
{.set|x|{.postvar|name.}.}
{.break|if={.pos|\|var=x.}{.pos|/|var=x.}|result={.!Illegal action.} (0).}
{.break|if={.not|{.can mkdir.}.}|result={.!Not authorized.} (1).}
{.set|x|{.force ansi|%folder%{.^x.}.}.}
{.break|if={.exists|{.^x.}.}|result={.!Duplicated.} (2).}
{.break|if={.not|{.length|{.mkdir|{.^x.}.}.}.}|result={.!Input empty.} (3).}
{.add to log|User %user% created folder "{.^x.}".}
{.pipe|{.!OK.}.}

[ajax.rename|no log]
{.check session.}
{.break|if={.not|{.can rename.}.}|result={.!Forbidden.} (0).}
{.break|if={.is file protected|{.postvar|from.}.}|result={.!Forbidden.} (1).}
{.break|if={.is file protected|{.postvar|to.}.}|result={.!Forbidden.} (2).}
{.set|x|{.force ansi|%folder%{.postvar|from.}.}.}
{.set|y|{.force ansi|%folder%{.postvar|to.}.}.}
{.break|if={.not|{.exists|{.^x.}.}.}|result={.!Target Not found.} (3).}
{.break|if={.exists|{.^y.}.}|result={.!Duplicated.} (4).}
{.break|if={.not|{.length|{.rename|{.^x.}|{.^y.}.}.}.}|result={.!Failed.} (5).}
{.add to log|User %user% renamed "{.^x.}" to "{.^y.}".}
{.pipe|{.!OK.}.}

[ajax.move|no log]
{.check session.}
{.set|to|{.force ansi|{.postvar|to.}.}.}
{.break|if={.not|{.and|{.can move.}|{.get|can delete.}|{.get|can upload|path={.^to.}.}/and.}.} |result={.!forbidden.} (0).}
{.set|log|{.!Moving items to.} {.^to.}.}
{.for each|fn|{.replace|:|{.no pipe||.}|{.force ansi|{.postvar|from.}.}.}|{:
    {.break|if={.is file protected|var=fn.}|result={.!Forbidden.} (1).}
    {.set|x|{.force ansi|%folder%.}{.^fn.}.}
    {.set|y|{.^to.}/{.^fn.}.}
    {.if not |{.exists|{.^x.}.}|{.^x.}: {.!Target Not found.} (2)|{:
        {.if|{.exists|{.^y.}.}|{.^y.}: {.!Duplicated.} (3)|{:
            {.set|comment| {.get item|{.^x.}|comment.} .}
            {.set item|{.^x.}|comment=.} {.comment| this must be done before moving, or it will fail.}
            {.if|{.length|{.move|{.^x.}|{.^y.}.}.} |{:
                {.move|{.^x.}.md5|{.^y.}.md5.}
                {.set|log|{.chr|13.}{.^fn.}|mode=append.}
                {.set item|{.^y.}|comment={.^comment.}.}
            :} | {:
                {.set|log|{.chr|13.}{.^fn.} ({.!Failed.})|mode=append.}
                {.maybe utf8|{.^fn.}.}: {.!Not moved.}
            :}/if.}
        :}/if.}
    :}.}
    ;
:}.}
{.add to log|{.^log.}.}

[ajax.comment|no log]
{.check session.}
{.break|if={.not|{.can comment.}.} |result={.!Forbidden.} (0).}
{.for each|fn|{.replace|:|{.no pipe||.}|{.postvar|files.}.}|{:
     {.break|if={.is file protected|var=fn.}|result={.!Forbidden.} (1).}
     {.set item|{.force ansi|%folder%{.^fn.}.}|comment={.encode html|{.force ansi|{.postvar|text.}.}.}.}
:}.}
{.pipe|{.!OK.}.}

[ajax.changepwd|no log]
{.check session.}
{.break|if={.not|{.can change pwd.}.} |result={.!Forbidden.} (0).}
{.comment | {.break|if={.substring|{.chr|123|46.}|{.chr|46|125.}|{.base64decode|{.postvar|new.}.}.}|result={.!Macro detected.} (4).} .}
{.if | {.=|{.sha256|{.get account||password.}.}|{.force ansi|{.postvar|old.}.}.}
    | {:{.if|{.length|{.set account||password={.force ansi|{.base64decode|{.postvar|new.}.}.}.}/length.}|{.!OK.} (1)|{.!Failed.} (2).}:}
    | {:{.!Old password not match.} (3):}
.}
[sym-errorpagecss]
<style>
@keyframes fadein {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}
/* Starry Night by Lea Verou */
/* https://leaverou.github.io/css3patterns/ */
body {
width: 100%;
height: 100%;
position: fixed;
margin: 0px;
z-index: -2;
background-color:black;
background-image:
radial-gradient(white, rgba(255,255,255,.2) 2px, transparent 40px),
radial-gradient(white, rgba(255,255,255,.15) 1px, transparent 30px),
radial-gradient(white, rgba(255,255,255,.1) 2px, transparent 40px),
radial-gradient(white, rgba(255,255,255,.08) 3px, transparent 60px),
radial-gradient(rgba(255,255,255,.4),
rgba(255,255,255,.1) 2px, transparent 30px);
background-size: 550px 550px, 350px 350px, 250px 250px, 950px 950px, 150px 150px;
background-position: 0 0, 40px 60px, 130px 270px, 640px 240px, 70px 100px;
font-size: 1.2em;
/*transform: scale(1.08);*/
font-family: sans-serif; background-color: black; color: white; text-align: center;
}
a, a:link, a:hover, a:active, a:visited { color: white; text-decoration: none; transition: all 0.6s; }
a:hover { color: black; background-color: white; }
</style>

[error-page]
%content%

[not found]
{.if|{.match|*.php*;*.js;*.py;*.vbs*;*.exe|%url%.}|{:{.disconnect.}:}.}
{.add header|Cache-Control: no-cache, max-age=0.}
<!doctype html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="refresh" content="1;url=../">
%sym-errorpagecss%
<title>404</title>
</head>
<body>
<h2><br />{.!You have found a 404 page.}</h2>{.!Redirecting to the previous page....}
</body></html>

[overload]
{.if not|%user%|{:{.if|{.match|^\/([Ff]ile(\/)?)?$|%url%.}|{:{.disconnect.}:}.}:}.}
{.add header|Cache-Control: no-cache, max-age=0.}
<!doctype html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="refresh" content="3;url=./">
<title>Overload</title>
%sym-errorpagecss%
</head>
<body>
    <h2><br />{.!There are more people than on a worktime bus station.}</h2>
    {.!Returning to previous page after traffic afford has gone lower....}
</body>
</html>
{.disconnect|{.current downloads|ip|file=this.}.}
{.if|{.{.current downloads|ip=%ip%|file=this.}> 1.}|
    {: {.disconnection reason|knackered.}
:}/if.}

[max contemp downloads]
{.add header|Cache-Control: no-cache, max-age=0.}
<!doctype html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="refresh" content="3;url=./">
<title>Downloads</title>
%sym-errorpagecss%
</head>
<body style="background-color: black; text-align: center;" text="white" alink="white" link="white" vlink="white">
    <h2><br />{.!There are ongoing downloads.}</h2>
    {.!More available after current downloads finish.}
</body>
</html>
{.disconnect|{.current downloads|ip|file=this.}.}

[box login]
<fieldset id='login'>
<legend>{.!User & Login.}</legend>
{.if| {.length|%user%.} |{:
    %user% <button onclick='logout()'>{.!Logout.}</button>
    {.if|{.can change pwd.} | <button onclick='areanewpass.style.display = "block";'>{.!Change Password.}</button> .}
    <br /><span id="sid" style="display: none;"></span>
    <div id='areanewpass' style="display: none;">
    <input id="oldpwd" type='password' name='oldpwd' maxlength="32"
        size="25" placeholder="{.!Input old password....}" /><br />
    <input id="newpwd" type='password' name='newpwd' maxlength="32"
        size="25" placeholder="{.!Input new password....}" /><br />
    <input id="newpwd2" type='password' name='newpwd2' maxlength="32"
        size="25" placeholder="{.!Input again....}" /><br />
    <input type="button" onclick="checkpassword()" value="{.!Okay.}" />
    </div>
    <script>
    function checkpassword() {     // Also changes password if no problem
        if (newpwd.value!=newpwd2.value) {
            alert('{.!Passwords not match, please re-input..}');
        } else if (newpwd.value=='') {
            alert('{.!Password cannot be empty!.}')
        } else {
            changePwd(newpwd.value);
            beforeRedirect();
        }
    }
    var sha256 = function(s) { return SHA256.hash(s); }
    function logout() {fetch("/?mode=logout");/*.then(res => location.reload());*/beforeRedirect(); return false;}
    function changePwd(newpass) {
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '?mode=section&id=ajax.changepwd');
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            console.log(xhr.responseText);
            var code = ( xhr.responseText.split('(')[1] == undefined ? -1 : xhr.responseText.split('(')[1].split(')')[0] );
            if (code == "1") {
                alert('{.!Complete! Use your new password next time!.}');
                beforeRedirect();
            } else {
                if (code == "0") {
                    alert("{.!You cannot change your password!.}");
                } else if (code == "3") {
                    alert("{.!Failed: Old password you input is wrong!.}");
                } else if (code == "4") {
                    alert("{.!Macro is detected in your input. Please do not attack..}");
                } else if (xhr.responseText.trim() == "bad session") {
                    alert("{.!Bad session. Try to refresh the page..}");
                } else {
                    alert('{.!Unknown error.}: \n'+xhr.responseText.trim());
                }
            }
        }
        };
        xhr.send("token={.cookie|HFS_SID_.}" + "&old=" + sha256(oldpwd.value) + "&new="+btoa(unescape(encodeURIComponent(newpass))));
    }
    </script>
    :}
|
    <input id='user' size='16' placeholder="{.!Username.}" /><br />
    <input type='password' id='pw' size='16' placeholder="{.!Password.}" /><br />
    <input type='hidden' id='sid' size='16' />
    <input type="checkbox" title='{.!By checking this you also agree to use Cookies.}' style="transform: scale(1.6);" /> {.!Keep me loggedin.}
    <input type='button' style="width: 8em;" onclick='login()' value='{.!Login.}' />
    <script>
    var sha256 = function(s) { return SHA256.hash(s); }
    function login() {
        var sid = "{.cookie|HFS_SID_.}"  //getCookie('HFS_SID');
	    // if (sid="") // the session was just deleted
		    // return location.reload() // but it's necessary for login
        if (!sid) return;  //let the form act normally
        var usr = user.value;
        var pwd = pw.value;
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "/?mode=login");  // /~login
        var formData = new FormData();
        formData.append("user",usr)
        typeof SHA256 == 'undefined' ? formData.append("password",pwd) : formData.append("passwordSHA256",sha256(sha256(pwd).toLowerCase()+sid).toLowerCase()) ;
        xhr.onload=function(){
        if(xhr.response=='ok') {
            if(document.querySelector("input[type=checkbox]").checked) localStorage.login=JSON.stringify([usr,pwd]); else localStorage.removeItem('login');
            beforeRedirect();
        } else {
            console.log(xhr.responseText);
            if (xhr.responseText === "bad password") {
                alert("{.!The password you entered is incorrect!.}");
            } else if (xhr.responseText === "username not found") {
                alert("{.!The user account you entered doesn't exist!.}");
            }
        }
        // document.querySelector("form").reset()
        }
        xhr.send(formData);
    }
    if(localStorage.login) document.querySelector("input[type=checkbox]").checked=true  //stop keep loggedin: call /~login (or /~signin) and disable "Keep me loggedin"
    document.querySelector("input[type=checkbox]").onchange=function(){if(!this.checked) localStorage.removeItem('login')}
    if(localStorage.login) {
    var tmp=JSON.parse(localStorage.login);
    user.value=tmp[0];
    pw.value=tmp[1];
    login();
    }
    </script>
.}
<script src='/~sha256.js'></script>
<script>
function beforeRedirect() {
    var inputs = ['user', 'pw', 'newpwd', 'newpwd2'];
    for (var i in inputs) {
        var inpt = document.getElementById(inputs[i]);
        if (inpt!=null) inpt.value = '';
    }
    // With a delay it will be more stable
    setTimeout(function() {
        window.location.href = '/~signin';
    }, 800);
};
</script>
</fieldset>

[signin]
{.if|{.match|*.php*;*.js;*.py;*.vbs*;*.exe|%url%.}|{:{.disconnect.}:}.}
{.add header|Cache-Control: no-cache, max-age=0.}
<!doctype html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>{.!Login.}</title>
%sym-errorpagecss%
<style>
#login {
    max-width: 50%;
    margin: auto;
    line-height: 1.8em;
    font-size: 1.4em;
    font-family: monospace;
}
@media (max-width: 760px) { #login { max-width: 80%; } }
</style>
</head>
<body style="background-color: black; text-align: center;" text="white" alink="white" link="white" vlink="white">
{.if| {.length|%user%.} |{:
    <br />
    <h2>{.!Welcome back.}, %user%!</h2>
    {.!You are already logged in, you need to log out before logging in as different user..}
    <!-- If not in login/signin page, it means no permission -->
    {.if|{.or|{.count substring|/~signin|%url%.}|{.count substring|/~login|%url%.}.}||
        <br /><br />{.!If you are here accidentally, you may lack the permission to access this file/folder..}
    .}
:}|{:
    <h2><br />{.!Please login to your account.}</h2>
    {.!Please login to access to your account, and check you have the correct permissions to continue.}
:}.}
<br /><br />
{.$box login.}
<br /><br /><a href="javascript: history.back()" style="font-size: 1.2em;">&lt;&lt; {.!Tap to Back.} </a>
</body>

[login]
{.$signin.}

[unauth]
{.$unauthorized.}

[unauthorized]
{.if|{.match|*.php*;*.js;*.py;*.vbs*;*.exe|%url%.}|{:{.disconnect.}:}.}
{.add header|Cache-Control: no-cache, max-age=0.}
<!doctype html>
<html>
<head>
<meta http-equiv="refresh" content="16;url=../">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>{.!Unauthorized.}</title>
%sym-errorpagecss%
</head>
<body>
    <h2>{.!Unauthorized.}</h2>
    {.!Currently you have no right to access this resource. Please login if possible..}
    <br /><br /><a href="/~signin" style="font-size: 1.2em;">{.!Login.} &gt;&gt;</a>
    <br /><br /><a href="javascript: history.back()" style="font-size: 1.2em;">&lt;&lt; {.!Tap to Back.} </a>
</body>
</html>


[deny]
{.if|{.match|*.php*;*.js;*.py;*.vbs*;*.exe|%url%.}|{:{.disconnect.}:}.}
{.add header|Cache-Control: no-cache, max-age=0.}
<!doctype html>
<html>
<head>
<meta http-equiv="refresh" content="1;url=../">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>Denied</title>
%sym-errorpagecss%
</head>
<body>
    <h1>{.!Access Denied.}</h1><br /><br />{.!Nope.}
</body>
</html>

[ban]
{.disconnect.}

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
                    xhr2.onload = function() { alert(xhr2.responseText.trim()); window.history.go(-1) };
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
[style]

<style>
@keyframes fadein {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}

body {
    text-align: left;
    font-weight: normal;
    color: white;
    background-color: black;
    font-family: "Monda", "Bahnschrift", "Noto Sans", "Segoe UI Emoji",
        "Microsoft YaHei UI", "微软雅黑", "SimHei", "黑体", "Microsoft JhengHei", "Yu Gothic UI",
        "Malgun Gothic", "Lucida Sans Unicode", "Arial Unicode MS", sans-serif;
    font-size: 1.2em;
    padding: 0px;
    margin: 0
}

.bgoriginal {
    width: 100%;
    height: 100%;
    position: fixed;
    margin: 0px;
    z-index: -2;
    background-size: cover;
    background: linear-gradient(95deg, #002, #113, #201053, #101032, #00002D, #000029, #002, #002);
}

/* Starry Night by Lea Verou */
/* https://leaverou.github.io/css3patterns/ */
.bgcss3 {
    width: 100%;
    height: 100%;
    position: fixed;
    margin: 0px;
    z-index: -2;
    background-color:black;
    background-image:
        radial-gradient(white, rgba(255,255,255,.2) 2px, transparent 40px),
        radial-gradient(white, rgba(255,255,255,.15) 1px, transparent 30px),
        radial-gradient(white, rgba(255,255,255,.1) 2px, transparent 40px),
        radial-gradient(white, rgba(255,255,255,.08) 3px, transparent 60px),
        radial-gradient(rgba(255,255,255,.4),
        rgba(255,255,255,.1) 2px, transparent 30px);
    background-size: 550px 550px, 350px 350px, 250px 250px, 950px 950px, 150px 150px;
    background-position: 0 0, 40px 60px, 130px 270px, 640px 240px, 70px 100px;
    transform: scale(1.08);
}

#bg {
    width: 100%;
    height: 100%;
    position: fixed;
    margin: 0px;
    z-index: -2;
    background: center / cover;
    opacity: 0;
    animation: fadein 0.33s ease-out 0.33s;
    animation-fill-mode: forwards;
}

.bgmask {
    width: 100%;
    height: 100%;
    position: fixed;
    margin: 0px;
    z-index: -1;
    /* background-image: url("/pic/deco/blackmask.png"); */
    background-color: rgba(0, 0, 0, 0.75);
}

.blackblank {
    width: 100%;
    height: 100%;
    position: fixed;
    margin: 0px;
    background-color: black;
}

hr {
    padding: 0;
    border-top: none;
    border-bottom: white 1px solid;
}

.inpt {
    color: #333377
}

.searchbox {
    padding: 0;
    border: 0;
    height: 2.48em;
    background-color: #F5FDF6;
    display:inline;
}

.searchbutton {
    border: 0;
    height: 2.48em;
    width: 2.48em;
    position: relative;
    /* top: 1px; */
    left: -1px;
    background-color: #e0dbd9;
    border-bottom: #e0dbd9 1px solid;
}

a.inverted {
    color: #333333;
    background-color: white;
    border: white 1px solid;
}
a.inverted:visited {
    color: #333333;
    background-color: white;
}
a.inverted:hover {
    color: white;
    background: none;
}

a.uploadbutton {
    display: block;
    float: right;
    font-weight: bold;
    height: 1.72em;
}

.nofile {
    margin: auto;
    font-size: 1.2em;
    text-align: center;
}

.btn {
    padding: 1px;
    float: right
}

table {
    white-space: nowrap;
}

a {
    text-decoration: none;
    font-size: 1em;
    color: white;
    font-weight: normal;
    transition: all 0.5s;
}

a:visited {
    color: white;
}

a:hover {
    color: #333333;
    background-color: white;
    text-decoration: none;
}

.del {
    background: transparent;
    border: none;
    color: #900;
    font-size: 12pt;
    cursor: pointer
}

#get-top {
    position: fixed;
    right: 0;
    bottom: 2em;
    font-size: 2em;
    width: 1em;
    height: 1em;
    text-align: center;
    padding: 0.2em 0.2em;
    margin: 1em;
    background-color: rgba(0, 0, 0, 0.75);
    cursor: pointer;
    display: none;
    z-index: auto;
    font-family: monospace;
    overflow: visible;
}

@keyframes blink {
    from {
        opacity: 1;
    }
    to {
        opacity: 0.5;
    }
}

div.statustext {
    overflow: hidden;
    margin-top: 0.1em;
    font-size: 0.9em;
    text-align: center;
    animation: blink 2s ease-in-out 1s alternate infinite;
}

table#files tr td {
    height: 32px;
}

/* Folder */
table#files a[href$="/"]::before {
    content: "\1f4c1\FE0E  ";
    color: #FB0
}

/* Unknown File */
td a::before {
    content: "\1f4c4  ";
    color: #BCC
}

/* Other */
td a[href$=";"]::before,
td a[href*="?"]::before {
    content: none;
}

/* Picture */
a[href$=".jpg"]::before,
a[href$=".jpeg"]::before,
a[href$=".webp"]::before,
a[href$=".png"]::before,
a[href$=".gif"]::before {
    content: "\1f4f7  ";
    color: black
}

/* Working Picture (Photoshop & GIMP) */
a[href$=".psd"]::before,
a[href$=".xcf"]::before {
    content: "📸  ";
    color: #5AE
}

/* Audio/Music */
a[href$=".mp3"]::before,
a[href$=".aac"]::before,
a[href$=".m4a"]::before,
a[href$=".wav"]::before,
a[href$=".ogg"]::before {
    content: "\1f50a\FE0E  ";
    color: green
}

/* Video */
a[href$=".mp4"]::before,
a[href$=".avi"]::before,
a[href$=".webm"]::before,
a[href$=".ogv"]::before,
a[href$=".flv"]::before,
a[href$=".mkv"]::before {
    content: "\1f4fa  ";
    color: teal
}

/* Compressed/Storage Pack */
a[href$=".tar"]::before,
a[href$=".gz"]::before,
a[href$=".rar"]::before,
a[href$=".7z"]::before,
a[href$=".zip"]::before {
    content: "\1f381  ";
    color: brown
}

/* Installation Pack */
a[href$=".msi"]::before,
a[href$=".tar.gz"]::before,
a[href$=".deb"]::before,
a[href$=".rpm"]::before {
    content: "📦  ";
    color: brown
}

/* Executable/Script */
a[href$=".exe"]::before,
a[href$=".vbs"]::before,
a[href$=".bat"]::before,
a[href$=".sh"]::before,
a[href$=".ps1"]::before,
a[href$=".pyc"]::before,
a[href$=".apk"]::before {
    content: "\1f537  ";
    color: #5AE
}

/* Code */
a[href$=".c"]::before,
a[href$=".cpp"]::before,
a[href$=".h"]::before,
a[href$=".cxx"]::before,
a[href$=".gcc"]::before,
a[href$=".py"]::before,
a[href$=".js"]::before {
    content: "⌨  ";
    color: yellow;
}

/* Working Document */
a[href$=".rtf"]::before ,
a[href$=".doc"]::before ,
a[href$=".docx"]::before ,
a[href$=".odt"]::before ,
a[href$=".xls"]::before ,
a[href$=".xlsx"]::before ,
a[href$=".ods"]::before ,
a[href$=".ppt"]::before ,
a[href$=".pptx"]::before ,
a[href$=".odp"]::before {
    content: "📝  ";
    color: gray;
}

/* PDF */
a[href$=".pdf"]::before {
    content: "📕  ";
    color: red;
}

/* Other Text */
a[href$=".txt"]::before,
a[href$=".ini"]::before,
a[href$=".htm"]::before,
a[href$=".html"]::before,
a[href$=".cfg"]::before,
a[href$=".json"]::before,
a[href$=".lrc"]::before {
    content: "📑  ";
    color: thistle;
}

/* Flash */
a[href$=".swf"]::before {
    content: "⚡  ";
    color: gold;
}

/* Icon */
a[href$=".ico"]::before {
    content: "🥚  ";
    color: wheat;
}

/* (Data) Image */
a[href$=".iso"]::before,
a[href$=".img"]::before,    /* '.img' is a floppy💾 image💿 */
a[href$=".dda"]::before {
    content: "💿  ";
    color: white;
}

/* Link */
table#files a[href^="ftp://"]::before,
table#files a[href^="file://"]::before,
table#files a[href^="tcp://"]::before,
table#files a[href^="udp://"]::before,
table#files a[href^="rtmp://"]::before,
table#files a[href^="rtsp://"]::before,
table#files a[href^="http://"]::before,
table#files a[href^="https://"]::before  {
    content: "🌎  ";
    color: #5AE
}

#files {
    background: none;
    border: 0 white solid;
    width: 75%;
    margin: auto;
}

tr.trhead {
    background-color: white;
    color: #333333;
    font-weight: bold;
}

tr.trhead a {
    color: #333333;
    font-weight: bold;
}

tr.trhead .l {
    text-align: left;
    width: 100%;
}

tr.trhead .m, tr.trhead .r {
    text-align: center;
}

table#files tr {
    outline: transparent 1px solid;
    transition: all 0.6s;
}

table#files tr:hover {
    outline: white 1px solid;
}

td.modified {
    font-size: 0.9em;
    text-align: center;
    min-width: 8em;
}

td.size {
    font-size: 0.9em;
    text-align: right;
    min-width: 6em;
}

td.sizenone {
    font-size: 0.9em;
    text-align: center;
    color: #AAAAAA;
    font-style: italic;
    min-width: 6em;
}

#title {
    font-size: 1.2em;
    text-align: center;
    margin: 0;
}

abbr {
    text-decoration: none;
}

input.upload {
    transform: scale(1.28);
}

.bottomblank {
    height: 24em;
}

.preview {
    /* text-align: right; */
    background-color: rgba(0, 0, 0, 0.8);
    position: fixed;
    right: 0;
    bottom: 0;
    padding-left: 0.8em;
    padding-top: 0.4em;
    /* max-width: 33%;*/
    display: none;
}

#preview {
    text-align: right;
    transition: all 0.33s;
    min-width: 24em;
    /* padding-right: 0.3em; */
}

@keyframes swing {
    0% {
        left: -0.5em;
    }
    50% {
        left: 0em;
    }
    100% {
        left: -0.5em;
    }
}

.tiparrow {
    position: relative;
    left: 0;
    font-size: 1.2em;
    font-style: italic;
    animation: swing 0.5s ease-in 0.1s infinite;
    animation-fill-mode: forwards;
    padding-left: 0.2em;
}
.tiparrow::after {
    content: ">>";
}

#previewtip {
    padding-right: 2em;
    max-width: 16em;
    overflow: hidden;
}

#previewopen {
    padding: 0;
    display: block;
}

a.close {
    color: #FF8888;
    float: right;
    font-size: 1.2em;
}

#previewactions {
    position: relative;
    text-align: right;
    font-size: 0.9em;
    top: -4px;
}
#previewactions a:link {
    text-decoration: underline;
    color: rgb(255, 199, 136);
    margin-right: 0.5em;
}
iframe {
    border: 0;
    margin: 0;
}

iframe.previewiframe {
    background-color: white;
    width: 32em;
    height: 18em;
}

.notice {
    background-color: rgba(0, 0, 0, 0.8);
    color: white;
    position: fixed;
    top: 0;
    font-size: 1.28em;
    display: none;
    height: auto;
    width: 100%;
    text-align: center;
    z-index: 10000;
    border-bottom: white 1px solid;
}

.notice #noticetitle {
    font-weight: bold;
    font-size: 1.08em;
    padding-top: 0.8em;
}
.notice #noticecontent {
    font-size: 0.92em;
    padding-bottom: 0.8em;
}

img.previewimg, video.previewvid {
    max-width: 32em;
    max-height: 18em;
}
.previewflashobject {
    width: 32em;
    height: 18em;
}

.flashfullpaged {
    position: fixed;
    top: 0;
    left: 0;
    width: 100% !important;
    height: 100% !important;
}
.previewflashfullscreenexit {
    font-size: 1.6em;
    color: #FF8888;
    position: fixed;
    top: 0;
    right: 0;
    margin: 1.2em;
    display: none;
    z-index: 1201;
}

.playerdj {
    position: fixed;
    left: 0;
    bottom: 0;
    background-color: rgba(0, 0, 0, 0.8);
    display: none;
    transition: all 0.33s;
}

#dj {
    padding: 0.3em 1.2em;
    /* Some fonts will make Fais ugly. Only keep ones that will not */
    font-family: "Monda", "Tahoma", "Malgun Gothic",
        "Lucida Sans Unicode", "DejaVu Sans", sans-serif;
}
#dj a {
    font-size: 1.2em;
}

#slideshow {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 2400;
    display: none;
    cursor: none;
}

.slidecontainer {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    text-align: center;
}

img.slidepic {
    line-height: 100%;
    /* max-width: 100%; */
    height: 100%;
    vertical-align: middle;
}

img.faded {
    transition: all 1s;
    opacity: 0;
}

img.thumbnail {
    width: 16em;
    /* max-height: 12em; */
    vertical-align: middle;
    position: relative;
    left: -1.6em;
}

#showthumb {
    display: none;
    padding-left: 30%;
}

#fileactionlabel, #fileactionsubmit {
    font-size: 0.8em;
}
.fileactioninputs {
    transform: scale(1.2);
    /* width: 80%; */
    text-align: center;
    position: relative;
    top: -6px;
    display: none;
}
.comment {
    padding-left: 2.4em;
}
/* For devices with small screen (mobiles) */
@media (max-width: 950px) {
#title {
    font-size: 1.08em;
}
body {
    font-size: 1.08em;
}
.bgcss3 {
    animation: none;
    width: 100%;
    height: 100%;
    position: fixed;
    margin: 0px;
    z-index: -2;
    background-size: cover;
    /* background: linear-gradient(95deg, #002, #113, #150d31, #171741, #00002D, #000029, #002, #002); */
    background: black;
}
div.statustext {
    font-size: 0.66em;
}
.searchbutton {
    border-bottom: none;
}
.preview {
    position: fixed;
    left: 0;
    bottom: 0;
    padding: 0.33em 0.66em;
    text-align: left;
}
#preview {
    text-align: left;
}
.fileactioninputs {
    transform: scale(1.0);
    text-align: left;
    position: relative;
    top: -2px;
}
a.close {
    float: left;
    position: absolute;
    left: 2em;
}
#previewactions {
    text-align: left;
    line-height: 1.6em;
}
#tiparrow {
    padding-left: 0;
}
#get-top {
    z-index: 1000;
}
#previewtip {
    padding-left: 2.4em;
    padding-right: 0;
}
img.previewimg, video.previewvid, iframe.previewiframe {
    max-width: 17.2em;
    max-height: 16em;
}
.previewflashobject {
    display: none;
}
.notice {
    font-size: 1em;
    text-align: left;
}
.notice#noticetitle {
    font-size: 1.08em;
}
.notice#noticecontent {
    font-size: 0.92em;
}
.playerdj {
    bottom: 2em;
}
.fais {
    min-height: 3.6em;
}
#playertitle {
    /* Get this element to a "new line" */
    display: block;
    padding-left: 2.4em;
}
.anotherlineonmobile {
    /* Make an inline(display) element block */
    display: block;
}
img.thumbnail {
    width: 12em;
}
#showthumb {
    padding-left: 2em;
}
}
/* A clear-looking scroll bar, copied from zui.css: (also edited here)*/
/* https://cdn.bootcss.com/zui/1.8.1/css/zui.min.css */
@media (min-width:768px) {
::-webkit-scrollbar {
width: 10px;
height: 10px;
/* background-color: black; */
}
::-webkit-scrollbar-button {
width: 0;
height: 0;
}
::-webkit-scrollbar-button:end:increment,::-webkit-scrollbar-button:start:decrement {
display: block;
}
::-webkit-scrollbar-button:vertical:end:decrement,::-webkit-scrollbar-button:vertical:start:increment {
display: none;
}
::-webkit-scrollbar-thumb:horizontal,::-webkit-scrollbar-thumb:vertical,::-webkit-scrollbar-track:horizontal,::-webkit-scrollbar-track:vertical {
border-color: transparent;
border-style: solid;
}
::-webkit-scrollbar-track:vertical::-webkit-scrollbar-track:horizontal {
/* background-color: rgba(255,255,255,.2); */
-webkit-background-clip: padding-box;
background-clip: padding-box;
}
::-webkit-scrollbar-thumb {
min-height: 28px;
padding-top: 100;
background-color: rgba(255,255,255,.2);
-webkit-background-clip: padding-box;
background-clip: padding-box;
border-radius: 5px;
}
::-webkit-scrollbar-thumb:hover {
background-color: rgba(255,255,255,.24);
box-shadow: inset 1px 1px 1px rgba(0,0,0,.25);
}
::-webkit-scrollbar-thumb:active {
background-color: rgba(255,255,255,.12);
box-shadow: inset 1px 1px 3px rgba(0,0,0,.35);
}
::-webkit-scrollbar-thumb:horizontal,::-webkit-scrollbar-thumb:vertical,
::-webkit-scrollbar-track:horizontal,::-webkit-scrollbar-track:vertical {
border-width: 0;
}
::-webkit-scrollbar-track:hover {
background-color: rgba(0,0,0,.05);
box-shadow: inset 1px 0 0 rgba(0,0,0,.1);
}
::-webkit-scrollbar-track:active {
background-color: rgba(0,0,0,.05);
box-shadow: inset 1px 0 0 rgba(0,0,0,.14),
inset -1px -1px 0 rgba(0,0,0,.07);
}
.scrollbar-hover::-webkit-scrollbar,.scrollbar-hover::-webkit-scrollbar-button,
.scrollbar-hover::-webkit-scrollbar-thumb,.scrollbar-hover::-webkit-scrollbar-track {
visibility: hidden;
}
.scrollbar-hover:hover::-webkit-scrollbar,.scrollbar-hover:hover::-webkit-scrollbar-button,.scrollbar-hover:hover::-webkit-scrollbar-thumb,.scrollbar-hover:hover::-webkit-scrollbar-track {
visibility: visible;
}
}
</style>

[sym-font]
<style>
@font-face { font-family: 'Monda';
	src: url('data:application/x-font-ttf;base64,AAEAAAASAQAABAAgRkZUTWXx2TAAAKE8AAAAHEdERUYDnAVLAAChWAAAADRHUE9TRrZNAwAAoYwAAAhkR1NVQoUFkl0AAKnwAAAAZE9TLzK8NmN8AAABqAAAAFZjbWFwf0tdrAAACNQAAAO2Y3Z0ICj/AGAAABasAAAAOGZwZ20x/KCVAAAMjAAACZZnYXNwAAAAEAAAoTQAAAAIZ2x5ZsqTYEcAABpQAAB/5GhlYWQCjGS+AAABLAAAADZoaGVhE/sJFAAAAWQAAAAkaG10eB3Q/fkAAAIAAAAG1GxvY2HUZ/WcAAAW5AAAA2xtYXhwAugKZwAAAYgAAAAgbmFtZc8OhBwAAJo0AAAG3nBvc3QAAwAAAAChFAAAACBwcmVwFQScMAAAFiQAAACFAAEAAAABAADbbxJ5Xw889QAJCAAAAAAAzNqNfQAAAADM3oz+/zL9DAqECDoAAAAIAAIAAAAAAAAAAQAACZ38lQAAC0b/1/+DCoQAAQAAAAAAAAAAAAAAAAAAAbUAAQAAAbUAWQAHAEAABAACACYANABsAAAAkgmWAAMAAgABA80BkAAFAAAFMwWZAAABHgUzBZkAAAPXAGYCEgAAAgAFAwAAAAAAAKAAAO9AACBLAAAAAAAAAABuZXd0AEAAIPsECZ38lQAACZ0DawAAAJMAAAAAAAAC7ABEAAAAAAKqAAACAAAAAwABGAN6ALAFBABWBRcAkAgAAKwF3ACwA4AAswMAAKwDAAB8BAAAYwQAAKICgQDABAAAogJ0ALoDAABABOIAhATiAM4E4gCkBOIA0ATiAI8E4gCtBOIAsgTiAL0E4gCEBOIAlwMAAQADAAD4BOIAnATiAOAE4gDQBNgAswgAAWoFlABWBYwA2gWwALYF8gDaBOcA2gSHANoGFAC6BfgA1ARsAL4EtgBmBYoA2gR5ANoG8gDaBjoA2gYKALoFLgDaBgYAugW4ANoFGACQBLQAVAYCAMgFagBWCAAAcAU4AF4FJgAwBNoAtAMAAQADAABAAwAAwwTpAJoDoQAOAmgAcwSUAIQEtAC6BFYAlASwAJQEhgCUAxYAbgSiAJQEygC6AlQAzgJaAA0EgAC6ArgAvgdEALoEygC6BJYAlASuALoEsACUAxoAugPgAI4DSABQBMgAsARQAEAGTgA0BCAAQAReAEwDxACMA7gAngKyAQADuACAA3EAQAIAAAADAAEYBFYAlAT5AKYEfQB0BSYAMAKiAP4D6gCQBAEAngb4AJwEFQC6BB4AYANgAGIEAACiBvgAnAIBACAEDADCBBEAzwQcAL4ElQDIAmgAhQEzAAAE4gCoAZwAbAIAAHgEGgDPA/8AmwQeAH4H/wCkB/8ApAf/AMcE2ACTBZQAVgWUAFYFlABWBZQAVgWUAFYFlABWBpYAYgWwALYE5wDaBOcA2gTnANoE5wDaBGwAvgRsAL4EbAC+BGwAvgS/AEwGOgDaBgoAugYKALoGCgC6BgoAugYKALoDzQCBBgoAugYCAMgGAgDIBgIAyAYCAMgFJgAwBSgA1AUBAL4ElACEBJQAhASUAIQElACEBJQAhASUAIQGzQCDBFYAlASGAJQEhgCUBIYAlASGAJQCVP/2AlQAzgJUAA4CVP/KBIYAlgTKALoElgCUBJYAlASWAJQElgCUBJYAlAQBAGQElgCUBMgAsATIALAEyACwBMgAsAReAEwEqgCxBF4ATAWUAFYElACEBZQAVgSUAIQFlABWBJQAhAWwALYEVgCUBbAAtgRWAJQFsAC2BFYAlAWwALYEVgCUBfIA2gSwAJQEvwBMBLAAlATnANoEhgCUBOcA2gSGAJQE5wDaBIYAlATnANoEhgCUBOcA2gSGAJQGFAC6BKIAlAYUALoEogCUBhQAugSiAJQGFAC6BKIAlAX4ANQEygC6BgAAkATIAB0EbAC+AlQAAwRsAL4CVABkBGwAvgJUAEoEbAC+AlQAewRsAL4CVADOCSIAvgSuAM4EtgBmAloACgWKANoEgAC6BHwAugR5ANoCuAC+BHkA2gK4AL4EeQDaArgAvgR5ANoEVAC+BHkANALEADQGOgDaBMoAugY6ANoEygC6BjoA2gTKALoEygC6Bi4A1ATKALoGCgC6BJYAlAYKALoElgCUBgoAugSWAJQGFQC3BsYAlgW4ANoDGgC6BbgA2gMaALoFuADaAxoAsgUYAJAD4ACOBRgAkAPgAI4FGACQA+AAjgUYAJAD4ACOBLQAVANIAFAEtABUA0gAUAS0AFQDSAA6BgIAyATIALAGAgDIBMgAsAYCAMgEyACwBgIAyATIALAGAgDIBMgAsAYCAMgEyACwCAAAcAZOADQFJgAwBF4ATAUmADAE2gC0A8QAjATaALQDxACMBNoAtAPEAIwDegCN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AAIBQAACAgxBAAAAAVAAAQENAUIREhADESslIQEBIQEzAaYCT/7aAgb76gGysY8EHftUBaYAAAD//wDaAAAFDActECcBdgHuAWITBgAlAAAACbEAAbgBYrApKwD//wC6/+oEIAdTECcBdgGaAYgTBgBFAAAACbEAAbgBiLApKwD//wDaAAAFPActECcBdgI4AWITBgAnAAAACbEAAbgBYrApKwD//wCU/+oD9gdTECcBdgFyAYgTBgBHAAAACbEAAbgBiLApKwD//wDaAAAEDwctECcBdgGiAWITBgApAAAACbEAAbgBYrApKwD//wBuAAAC6AdTECcBdgEKAYgTBgBJAAAACbEAAbgBiLApKwD//wDaAAAGGActECcBdgKmAWITBgAwAAAACbEAAbgBYrApKwD//wC6AAAGlAWpECcBdgLU/94TBgBQAAAACbEAAbj/3rApKwD//wDaAAAErgctECcBdgHyAWITBgAzAAAACbEAAbgBYrApKwD//wC6/mgEGgWpECcBdgGY/94TBgBTAAAACbEAAbj/3rApKwD//wCQ/+oEjActECcBdgG8AWITBgA2AAAACbEAAbgBYrApKwD//wCO/+oDbAWpECcBdgEq/94TBgBWAAAACbEAAbj/3rApKwD//wBUAAAEYActECcBdgGIAWITBgA3AAAACbEAAbgBYrApKwD//wBQ//gC1AbdECcBdgDAARITBgBXAAAACbEAAbgBErApKwD//wBwAAAHkAe0ECcAQwJXAdITBgA6AAAACbEAAbgB0rApKwD//wA0AAAGGgYwECcAQwF+AE4TBgBaAAAACLEAAbBOsCkrAAD//wBwAAAHkAe0ECcAdgNGAdITBgA6AAAACbEAAbgB0rApKwD//wA0AAAGGgYwECcAdgJtAE4TBgBaAAAACLEAAbBOsCkrAAD//wBwAAAHkAcUECcAagIAAW4TBgA6AAAACbEAArgBbrApKwD//wA0AAAGGgWQECcAagEm/+oTBgBaAAAACbEAArj/6rApKwD//wAwAAAE9ge0ECcAQwDqAdITBgA8AAAACbEAAbgB0rApKwD//wBM/moEJAYwECcAQwCPAE4TBgBcAAAACLEAAbBOsCkrAAAAAQACAl4CFwLcAAMAHUAaAAABAQBLAAAAAU8CAQEAAUMAAAADAAMRAw8rEzUhFQICFQJe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AFoAXACCAIMAhACFAIYAhwCUAJUAlgCXAJgAmgCfALMAtAC1ALYAtwC4ALoAvwDAAMEAwgDEAMYA0ADnAOkBBgEIAQoBDgEPARABEQESARMBFgEYARoBJgE3ATkBOgFQAVIBXAFdAV4BXwFgAWIBagGEAYoBjAGOAZAAAgBGACQAJAABACYAJgACACcAJwADACkAKQAEACoAKgAFAC4ALgAGAC8ALwAHADIAMgADADMAMwAIADQANAADADUANQAJADcANwAKADkAOQALADoAOgAMADwAPAANAEQARAAOAEUARQAPAEgASAAQAEsASwARAFAAUQARAFIAUwAPAFkAWQASAFoAWgATAFwAXAAUAIIAhwABAJQAmAADAJoAmgADAJ8AnwANALMAswARALQAuAAPALoAugAPAL8AvwAUAMAAwAAPAMEAwQAUAMIAwgABAMQAxAABAMYAxgABANAA0AADAOcA5wARAOkA6QARAQYBBgARAQgBCAARAQoBCgARAQ4BDgADAQ8BDwAPARABEAADAREBEQAPARIBEgADARMBEwAPARYBFgAJARgBGAAJARoBGgAJASYBJgAKATcBNwATATkBOQAUAToBOgANAVABUAABAVIBUgABAVwBXAADAV0BXQAPAV4BXgADAV8BXwAPAWABYAAJAWIBYgAJAWoBagAKAYQBhAAPAYoBigATAYwBjAATAY4BjgATAZABkAAUAAIAbQAPAA8ADQARABEADgAkACQAAQAmACYAAgAqACoAAgAtAC0AAwAyADIAAgA0ADQAAgA2ADYABAA3ADcABQA4ADgABgA5ADkABwA6ADoACAA7ADsACQA8ADwACgBEAEQACwBGAEgADABSAFIADABUAFQADABYAFgADwBZAFkAEABaAFoAEQBcAFwAEgCCAIcAAQCJAIkAAgCUAJgAAgCaAJoAAgCbAJ4ABgCfAJ8ACgCiAKgACwCpAK0ADACyALIADAC0ALgADAC6ALoADAC7AL4ADwC/AL8AEgDBAMEAEgDCAMIAAQDDAMMACwDEAMQAAQDFAMUACwDGAMYAAQDHAMcACwDIAMgAAgDJAMkADADKAMoAAgDLAMsADADMAMwAAgDNAM0ADADOAM4AAgDPAM8ADADRANEADADVANUADADXANcADADZANkADADbANsADADdAN0ADADeAN4AAgDgAOAAAgDiAOIAAgDkAOQAAgEOAQ4AAgEPAQ8ADAEQARAAAgERAREADAESARIAAgETARMADAEUARQAAgEVARUADAEcARwABAEgASAABAEiASIABAEmASYABQEqASoABgErASsADwEsASwABgEtAS0ADwEuAS4ABgEvAS8ADwEwATAABgExATEADwEyATIABgEzATMADwE0ATQABgE1ATUADwE3ATcAEQE5ATkAEgE6AToACgFOAU4AAgFQAVAAAQFRAVEACwFSAVIAAQFTAVMACwFVAVUADAFXAVcADAFcAVwAAgFdAV0ADAFeAV4AAgFfAV8ADAFkAWQABgFlAWUADwFmAWYABgFnAWcADwFoAWgABAFqAWoABQGKAYoAEQGMAYwAEQGOAY4AEQGQAZAAEgABAAAACgAqADgAA0RGTFQAFGdyZWsAFGxhdG4AFAAEAAAAAP//AAEAAAABbGlnYQAIAAAAAQAAAAEABAAEAAAAAQAIAAEAGgABAAgAAgAGAAwBsgACAE8BsQACAEwAAQABAEk') format('truetype');
}
</style>
