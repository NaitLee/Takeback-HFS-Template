<!--
		The Takeback Template:
			http://rejetto.com/forum/index.php?topic=13287.0
		Licensed under 2-Clause BSD.
-->

[api level]
2

[+special:strings]

{.comment|
	Use Takeback Index as your index page? You may customize it as well,
		just search "MARKER-0" with your editor and you'll see it.
.}
UseTakebackIndex=1
TkbIndex.Title={.!My Personal Site.}
TkbIndex.TitleShort={.!HTTP File Server.}

{.comment| Use special date&time format? 0 to disable, other values to enable .}
UseSpecialDateTimeFormat=1
DateTimeFormat=dd/mm/yyyy
{.comment| Format sample: DateTimeFormat=mm/dd/yyyy hh:MM:ss ampm .}

{.comment| What will the title(browser tab) show? .}
TitleText=HFS::{.!RootToMainPage.}

RootToMainPage={.if|{.=|%folder%|/.}|{.!Main Page.}|%folder%.}

{.comment| Check if a viewer is using IE and hint him/her to update? .}
CheckIE=1
{.comment|
	If you're living in a environment that everyone is using Chrome & Firefox etc,
	you might won't care this. If not, be aware of this option.
	Also notice something called "Dual-core Browser", like 360 Safe Browser, 2345 Browser etc.
	You should enable this if many ones are using them around you, espacially in China.
.}

{.comment| Force load JQuery? (Not needed.) .}
UseJquery=0

{.comment|
	Enable image background?
	Put pictures in your speciefied folder to see them randomly appear
	as the background of your page
.}
EnableImageBg=0
BgFolder=/pic/img/bg/

{.comment| What will the header show?   -- Texts wrapped by {.! .} will be able to be replaced("translated") by defining them like those ones below.}
EnableHeader=0
HeaderText={.!HTTP File Server.}

{.comment| What will the statustext show? .}
EnableStatus=1
StatusText={.!Files here are available for view & download.}
StatusTextLink=http://rejetto.com/hfs/

{.comment| How will Fais looked like? .}
HowDjFaisLooksLike=\( •̀ ω •́ )✧ ♫

{.comment| Presets:    (*゜▽゜)♪    o(*^▽^*)🎶    o(*^∇^)♪🎤    ♪(*￣︶￣*)o🎵    .}

{.comment| ... and more below .}
MaxArchiveSizeAllowedToDownloadKb=4096000
ThresholdConnectionsOfTurningStatusRed=64

[special:import]
{.if|
	{.dialog|
{.!Do you want to overwrite some of your HFS settings to make this template run more efficiently?.}
{.!After accepting this you may reset(clear) settings if you are going to switch to another/default template..}
	|yesno question.}
|{:
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
:}|.}

[commonhead]
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Below 3 metas makes so-called dual-core browsers (360 Safe Browser, etc.)
	use Webkit to render the page by default -->
<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="ie=edge,chrome=1" />
<meta name="force-rendering" content="webkit" />
<link rel="icon" href="/favicon.ico">
<link rel="shortcut icon" href="/favicon.ico" />
<meta name="theme-color" content="#000000" />
<script>
var HFS = { 
	user: '{.js encode|%user%.}', 
	folder: '{.js encode|%folder%.}', 
	sid: '{.cookie|HFS_SID_.}',
}
</script>
<link rel="stylesheet" href="/~tkbmain.css" />
{.if|{.!UseJquery.}| <script id="scriptjq0" src="/?mode=jquery"></script> | {.$faikquery.} .}
{.if|{.CheckIE.}|{.$checkiescript.}.}

[commonbody]
<!-- Background image and blackening mask: Framework -->
{.if|{.!EnableImageBg.}
| <div id="bg"></div><div class="bgmask"></div>
	{.$script.randombg.}
| <div class="bgmask"></div><div id="bg"><div class="bgcss3"></div></div>
.}


<!-- Notice: Framework -->
<div class="notice">
	<div id="noticetitle"></div>
	<div id="noticecontent"></div>
</div>

<!-- Scroll to top: Framework -->
<div id="get-top"><abbr title="{.!Back to top.}">&gt;</abbr></div>

<script>
// Scroll to top: Script
var prevscroll = 0;
window.onscroll = function () {
	var currscroll = document.documentElement.scrollTop || document.body.scrollTop;
	if (currscroll > 240 && prevscroll < 240) {
		$('#get-top').fadeIn();
	} else if (currscroll < 240 && prevscroll > 240) {
		$('#get-top').fadeOut();
	}
	prevscroll = currscroll;
}
document.querySelector('#get-top').onclick = function () {
	if (window.scrollY==undefined) window.scrollY = document.documentElement.scrollTop; // IE
	// if (window.scrollX==undefined) window.scrollX = document.documentElement.scrollLeft;
	var scrollspeed = scrollY/30;
	var interval = setInterval(function() {
		scrollBy(window, -scrollspeed);
	}, 16)
	setTimeout(function() { clearInterval(interval); }, 1000);
}
</script>

<!-- Popup: Framework -->
<div class="popup">
	<div id="popupbg" style="display: none;"></div>
	<div id="popupbox" style="display: none;">
		<div id="popupmsg"><!-- Message --></div>
		<div style="height: 1px; border-bottom: white 1px solid; margin: 16px;"></div>
		<div id="popupctrl">
			<!-- Init by function popup() -->
		</div>
	</div>
</div>
{.$script.popup.}


[checkiescript]
<script>
// Detect IE/Edge by Mario: https://codepen.io/gapcode/pen/vEJNZN
function detectIE() {
	var ua = window.navigator.userAgent;
	var msie = ua.indexOf('MSIE ');
	if (msie > 0) {
		return parseInt(ua.substring(msie + 5, ua.indexOf('.', msie)), 10);
	}
	var trident = ua.indexOf('Trident/');
	if (trident > 0) {
		var rv = ua.indexOf('rv:');
		return parseInt(ua.substring(rv + 3, ua.indexOf('.', rv)), 10);
	}
	return false;
}
var version = detectIE();
if (version < 12 && version != false) {
	// IE, hint for update (< 10), load JQuery if not ever loaded (any version).
	if (version < 10) alert('{.!Please update your browser to modern ones..}\n\n\
{.!You are using an unsupported browser, which will result in an unjoyful experience..}\n\
{.!If you are using a dual-core browser, please switch core at right side of address bar..}\n\
{.!Or you may update your browser to new ones, such as: Chrome, Chromium, Edge, Firefox, Opera, Safari etc..}'
	);
	console.log('Browser: IE ' + version);
	console.log('JQuery will be force loaded for a better experience.');
	if (document.getElementById('scriptjq0') == null) {
		var script = document.createElement('script');
		script.src = '/?mode=jquery';
		document.head.appendChild(script);
	}
}
</script>

[index.html|public]
<!doctype html>

<!-- MARKER-0: Configure Takeback Index -->
{.comment|
	Define some indexes and navs as following:
	{:{.set|TkbIndex.n| Title[Path]Description .}:}
	{:{.set|TkbNav.n| Title[Path]Description .}:}
	Examples are given below.
.}
{.set|#TkbIndex.0| {.!My Projects.}[/projects/]{.!Making stuffs makes me happy!.} .}
{.set|#TkbIndex.1| {.!My Pictures.}[/pictures/]{.!Snap of my memorable times!.} .}
{.set|#TkbIndex.2| {.!My Videos.}[/videos/]{.!Go across past experiences!.} .}
{.set|#TkbIndex.3| {.!Music collection.}[/music/]{.!A special form of art!.} .}

{.set|#TkbNav.0| {.!Server root directory.}[/root/]{.!View the server's structure.} .}
{.set|#TkbNav.1| {.!Administration Login.}[/~login]{.!Get more permissions by logging-in..} .}

<html>
<head>
	{.$commonhead.}
	<link rel="stylesheet" href="/~tkbindex.css" />
	<title>{.!TitleText.}</title>
</head>
<body>
	{.$commonbody.}
	<div class="pond">
        <header>
            <h1 class="logo">
                <a href="/" style="text-decoration: none;">
                    🌎<span>{.!TkbIndex.TitleShort.}</span>
                </a>
            </h1>
            <nav class="nav">
                <h2 class="hidden">Navigation</h2>
                <!-- Navigation items, will be inited with JS. -->
                <ul id="nav">
					{.set|num|0.}
					{.for each|i|{.var domain|#TkbNav.|get=values.}|{:
						{.set|nav|{.^i.}.}
							<li><a href="{.substring|[|]|{.^nav.}|include=0.}">
								<abbr title="{.substring|]||{.^nav.}|include=0.}">{.substring||[|{.^nav.}|include=0.}</abbr>
							</a></li>
						{.inc|num|1.}
					:}.}
                </ul>
            </nav>
        </header>
		<div class="main">
			<div id="title">{.!TkbIndex.Title.}</div>
			<!-- Search box, from a template -->
			<section class="sousuo">
				<h2 class="hidden">Search</h2>
				<div class="search">
					<div class="search-box">
						<span class="search-icon">🔎</span>
						<input type="text" id="txt" class="search-input" placeholder="{.!Search whatever you want....}">
						<button class="search-btn visible-sm visible-md visible-lg" id="search-btn">{.!Search.}</button>
						<i class="search-clear icon icon-remove-sign" style="display: none;"></i>
					</div>
					<!-- Search Engines -->
					<div class="search-engine" style="display: none;">
						<div class="search-engine-head">
							<strong class="search-engine-tit">{.!Select default search engine:.}</strong>
						</div>
						<ul class="search-engine-list">
						</ul>
					</div>
				</div>
			</section>
			<!-- Hitokoto. Details: https://hitokoto.cn 
			<div class="hitokoto">
				<h2 class="hidden">Hitokoto</h2>
				<div class="bracket left">『</div>
				<div id="hitokoto"></div>
				<div class="hitokotod"><span id="hitokotop"></span><span id="cursor">|</span></div>
				<div class="bracket right">』</div>
			</div>
			-->
			<!-- Items -->
			<h2 class="hidden">Items</h2>
			<div id="itemlist">
				{.set|num|0.}
				{.for each|i|{.var domain|#TkbIndex.|get=values.}|{:
					{.set|index|{.^i.}.}
					{.set|direction|{.if|{.=|{.mod|{.^num.}|2.}|0.}|left|right.}.}
					<div class="item {.^direction.}">
						<a href="{.substring|[|]|{.^index.}|include=0.}">
							{.substring||[|{.^index.}|include=0.}
							<span class="item arrow"></span>
						</a>
						<div class="item {.^direction.} description">{.substring|]||{.^index.}|include=0.}</div>
						<div class="item {.^direction.} border"></div>
					</div>
					{.inc|num|1.}
				:}.}
			</div>
			<!-- Copyright -->
			<h2 class="hidden">Copyright</h2>
			<div class="copyright">
				Site powered by <a href="http://www.rejetto.com/hfs/" target="_blank">HTTP File Server</a>.
				<br />Uptime: %uptime%
			</div>
		</div>
	</div>
	<!-- <script src="https://v1.hitokoto.cn/?encode=js&select=%23hitokoto" defer></script> -->
	<script src="~tkbindex.js"></script>
</body>
</html>

[]
<!doctype html>
{.comment|If it is root, go to index page.}
{.if|{.!UseTakebackIndex.}|{.if|{.=|%folder%|/.}|{:{.redirect|/~index.html.}:}.}.}
<html>
<head>
{.$commonhead.}
<title>{.!TitleText.}</title>
{.if|{.=|%folder%|/.}|<meta http-equiv="refresh" content="0;url=/~index.html">.}

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
// Searcher
function searchQuery() {
	frm = document.searchForm;
	if (frm.query.value.length < 1) {
		popup("{.!Search requires 1 or more characters.}");
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
			frm.root[c].value == "current" ? searchFrom = "http://%host%"+HFS.folder : searchFrom = "http://%host%";
		}
		document.location.href = searchFrom + searchMode + "*" + frm.query.value + "*" + recursive + filter;
	}
}
</script>
<style id="iconrules"></style>
</head>

<body>
{.$commonbody.}

<!-- File list: Framework -->
{.if|{.!EnableHeader.}| <div id="title">{.!HeaderText.}</div> |.}
%login-link%%loggedin%
<a href="/">&#127968;{.!Homepage.}</a> <span id="swapDir">%folder%</span>
<script> browseAbleFolderTree("%folder%") </script>
%files%

{.if|{.get|can archive.}|
{:{.if|{.%number-files% > 0.}|
{:{.if|{.%total-kbytes% <= {.!MaxArchiveSizeAllowedToDownloadKb.} .}|
	<div style="text-align: center;">
	<a href="javascript: // Popup confirm // .tar" onclick="popup('{.!Download these.} %number-files% {.!files in a .tar archive?.}', '?confirm', function() { window.location.href = HFS.folder + '~folder.tar'; });">
		[ {.!Click to Archive.} ]
	</a>
	</div>
.}:}
.}:}
.}
<div class="bottomblank"></div>

<!-- Addons: Framework -->
<div id="addons">
<!-- D.J. Fais (as mini player) -->
<div class="playerdj">
<div id="djinfo" style="display: none;"></div>
<div class="fais">
	<span id="dj"><a href="javascript:">{.!HowDjFaisLooksLike.}</a></span>
	<a href="javascript:"><span id="playerstatus">&#9658;&#10073; </span> <!-- Events see onclick() & oncontextmenu() in _fais() -->
	</a><span id="playertitle"></span>
</div>
</div>
<!-- Preview -->
<div class="preview" id="previewopen"><span class="tiparrow">&nbsp;</span>
	<a href="javascript: previewfile('?show');">{.!Expand preview frame.}</a>&nbsp;
</div>
<div class="preview">
	<span class="tiparrow">&nbsp;</span><span id="previewtip"></span>
	<a class="close" href="javascript: previewfile('?close')">
		<abbr title="{.!Close preview frame.}">[X]</abbr>
	</a>&nbsp;
	<!-- Actions also contained -->
	<div id="multiselectactions" style="display: none;">
		<div style="height: 1px; border-bottom: white 1px solid;"></div>
		{.!Multi:.} &nbsp;
		<a href="javascript: fileactionmulti('?mask')">{.!Mask.}</a>
		<a href="javascript: fileactionmulti('?invert')">{.!Invert.}</a>
		<a href="javascript: fileactionmulti('?archive')">{.!Archive.}</a>
		<!-- Note: different from single file actions -->
		{.if|{.get|can delete.}|
		<a href="javascript: fileactionmulti('?delete');">{.!Delete.}</a>
			{.if|{.and|{.!option.move.}|{.can move.}.}| 
			<a href="javascript: fileactionmulti('?move');">{.!Move.}</a>.}
		.}
		<a href="javascript: multiclose();">{.!Close.}</a>
		<div id="multiselectstatics">{.!There are.} 0 {.!files selected.}</div>
	</div>
	<div style="height: 1px; border-bottom: white 1px solid;"></div>
	<div id="previewactions">
		<a href="javascript: multiopen();">{.!Multi select.}</a>
		<a href="javascript: var x = function() { preview.innerHTML = ''; }();">{.!Clear preview.}</a>
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
	<div id="preview">{.!You can tap on filename and preview here.}</div>
</div>

<!-- Slideshow(pictures) -->
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

<script src="/~addonall.js" onerror="var self = this; setTimeout(function() { self.src = '/~addonall.js'; }, 400);" async></script>
<link rel="stylesheet" href="/~font.css" />
</body>
</html>

[addonall.js|no log|public]
{.add header|Cache-Control: public, max-age=86400.}
{.$addonpre.js.}
{.$preview.js.}
{.$fileactions.js.}
{.$djfais.js.}
{.$slideshow.js.}
{.$thumbnail.js.}

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
	<input class="searchbox" placeholder="{.!Search files here....}" type="search" name="query" size="25"
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
	<span><a href="{.!StatusTextLink.}" target="_blank"
		style="color: {.if|{.%connections% > {.!ThresholdConnectionsOfTurningStatusRed.}.}|{:#996644:}|{:#228833:}.};">
		{.!StatusText.}</a>
	</span>
</div>:}.}
<!-- File list: Table headline -->
<div class="files">
<table id="files">
<tr class="trhead">
<td class="l">
	<a href="%encoded-folder%?sort=e">
		<abbr title="{.!Click to sort files by extension.}">&#128311;</abbr>&nbsp;
	</a>
	<a href="%encoded-folder%?sort=n">
		<abbr title="{.!Click to sort files by this.}">{.!FileName.}</abbr>
	</a> (%number-files%)
	<span id='menu-bar'>&nbsp;</span>
	<span id="showthumb">
		<a href="javascript: showthumbnail();">📸 {.!Photo Thumbnails.}</a>
	</span>
</td>
<td class="m">
	<a href="%encoded-folder%?sort=!t">
		<abbr title="{.!Format.}: {.!DateTimeFormat.}    {.!Click to sort files by this.}">{.!Last Modified.}</abbr>
	</a></td>
<td class="r">
	<a href="%encoded-folder%?sort=s">
		<abbr title="{.!Click to sort files by this.}">{.!Size.}</abbr>
	</a>
</td>
</tr>%list%
</table>
</div>

{.comment| For special date&time format .}

[+special:alias|cache]
item-modified-datetime-formated={.time|format={.!DateTimeFormat.}|when=%item-modified-dt%.}
item-edited={.if|{.!UseSpecialDateTimeFormat.}|{.item-modified-datetime-formated.}|%item-modified%.}

[file]
<tr>
<td class="file"><a href="%item-url%">%item-name%</a></td>
<td class="modified">{.item-edited.}</td>
<td class="size">%item-size%B</td>
</tr>

[folder]
<tr>
<td class="folder"><a href="%item-url%"><b>%item-name%</b></a></td>
<td class="modified">{.item-edited.}</td>
<td class="sizenonef"></td>
</tr>

[link]
<tr>
<td class="link"><a href="%item-url%" target="_blank">%item-name%</a></td>
<td class="modified">. . .</td><td class="sizenonel"></td>
</tr>

[nofiles]
{.if|{.%connections% < 65.}|
{:{.if|{.get|can upload.}|
{:<div style="text-align: center; margin-top: 4px; border-bottom: white 1px solid;">
<a class="inverted" href="%encoded-folder%~upload" style="font-weight: bold;">
	&#8679;&nbsp;{.!Upload Files.} </a></div>:}
.}:}
.}
<div class="nofile">{.!{.if|{.length|{.?filter.}.}
	|{.!Sorry, we cannot find what you prefer to see now....}
	|{.!It seems nothing here....}.}.}
</div>
<script>setTimeout(function () { window.location.href = '../'; }, 12000);</script>


[faikquery]

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

[fileicons.js|no log|public]
// <script>
	// Not used currently, but maybe useful
	function iconrule(types, icon, color) {
		types.forEach(function(type, index) {
			iconrules.innerHTML += 'a[href$="'+type.toLowerCase()+'"]::before, a[href$="'+type.toUpperCase()+'"]::before { content: "'+icon+'"; color: '+color+'; }';
		});
	}
	iconrule(['.jpg','.jpeg','.png'], '📷', 'black');
// </script>


[preview.js|no log|public]
{.add header|Cache-Control: public, max-age=86400.}
// <script> // Fool the editor to highlight syntax properly
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
		notice('{.!View your file below the page!.}', '{.!Preview Opened.}');
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
// </script>

[script.popup]
<script>
function popup (message, type, callbackfn, defaultvalue) {
	if (callbackfn == undefined) { callbackfn = function() { return true; } };
	var popupclose = function () {
		$('#popupbg').fadeOut();
		$('#popupbox').slideUp();
	};
	popupmsg.innerHTML = message;
	switch (type) {
		case '?alert':
			popupctrl.innerHTML = '<div id="popupalert"><button id="popupalertok">{.!OKay.}</button></div>';
			popupalertok.addEventListener("keydown", function(event) { if (event.keyCode == 13) popupalertok.onclick(); }); // When press enter, OK
			popupalertok.onclick = function () { callbackfn(true); popupclose(); return true; };
			break;
		case '?confirm':
			popupctrl.innerHTML = '<div id="popupconfirm"><button id="popupconfirmok">{.!OKay.}</button> <button id="popupconfirmcancel">{.!Cancel.}</button></div>';
			popupconfirmok.addEventListener("keydown", function(event) { if (event.keyCode == 13) popupconfirmok.onclick(); });
			popupconfirmok.onclick = function () { callbackfn(true); popupclose(); return true; };
			popupconfirmcancel.onclick = function() { popupclose(); return false; };
			break;
		case '?prompt':
			popupctrl.innerHTML = '<div id="popupprompt"><input type="text" id="popuppromptinput" placeholder="{.!Input something....}" /><br />\
				<button id="popuppromptok">{.!OKay.}</button> <button id="popuppromptcancel">{.!Cancel.}</button></div>';
			popuppromptinput.value = defaultvalue==undefined ? '' : defaultvalue;
			popuppromptinput.addEventListener("keydown", function(event) { if (event.keyCode == 13) popuppromptok.onclick(); });
			popuppromptok.onclick = function () { callbackfn(popuppromptinput.value); popupclose(); return popuppromptinput.value; };
			popuppromptcancel.onclick = function() { popupclose(); return false; };
			break;
		default:
			popup(message, '?alert', callbackfn);
	}
	$('#popupbg').fadeIn();
	$('#popupbox').slideDown();
}
</script>

[addonpre.js|no log|public]
{.add header|Cache-Control: public, max-age=86400.}
// <script>
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

// From HFS original tpl, edited
function getItemName(s) {
	s = s.split('#')[0].split('?')[0];
	// remove protocol and hostname
	var i = s.indexOf('://');
	if (i > 0)
		s = s.slice(s.indexOf('/',i+3));
	// current folder is specified. Remove it.
	if (s.indexOf(HFS.folder) == 0)
		s = s.slice(HFS.folder.length);
	// folders have a trailing slash that's not truly part of the name
	if (s.slice(-1) == '/')
		s = s.slice(0,-1);
	// it is encoded
	s = (decodeURIComponent || unescape)(s);
	return s;
} // getItemName

function spliturllast(url, indexnegative) {
	// 'http://example.net/folder/file.txt' -> 'file.txt'
	var urlparts = url.split('/');
	indexnegative = indexnegative || 1;
	return urlparts[urlparts.length-indexnegative];
}
// Show current folder in preview title
previewtip.innerHTML = decodeURI(spliturllast(window.location.href, 2)+'/');
function _filestatics () {
	this.filelistnodes = document.querySelectorAll('td.file a, td.folder a, td.link a');
	this.nodesfile = document.querySelectorAll('td.file a');
	this.filelist = [];
	this.musiclist = [];
	this.picturelist = [];
	this.selectedfiles = [];
}
var filestatics = new _filestatics();

// Preparition: Query all file links on the page, many functions will use them
// Sort files out by type
if (window.NodeList && !NodeList.prototype.forEach) {	// IE 11
   NodeList.prototype.forEach = Array.prototype.forEach;
}
filestatics.nodesfile.forEach(function(filelistnode, index) {
	var url = filelistnode.href     // spliturllast(filelistnode.href);
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

// Multi select
var filetabletrs = document.querySelectorAll('#files tbody tr');
function refreshmultistatic () {
	filestatics.selectedfiles = [];
	filetabletrs.forEach(function(e, k) {
		if (k == 0) return; k -= 1;  // Table head, skip
		if (e.classList.value.indexOf('selected') != -1)
			filestatics.selectedfiles.push(filestatics.filelistnodes[k].href);
	});
	multiselectstatics.innerHTML = '{.!There are.} ' + filestatics.selectedfiles.length + ' {.!files selected.}'
}
function multiopen () {
	filetabletrs.forEach(function(element, key) {
		if (key == 0) return; key -= 1;  // Table head, skip
		element.onclick = function(event) {
			element.classList.value.indexOf('selected') == -1
				? element.classList.add('selected')
				: element.classList.remove('selected');
			refreshmultistatic();
		}
	});
	$('#multiselectactions').slideDown();
}
function multiclose () {
	filetabletrs.forEach(function(element, key) {
		if (key == 0) return; key -= 1;  // Table head, skip
		element.onclick = function(event) {}
		element.classList.remove('selected');
	});
	$('#multiselectactions').slideUp();
	refreshmultistatic();
}
// </script>

[djfais.js|no log|public]
{.add header|Cache-Control: public, max-age=86400.}
// <script>
// D.J. Fais: Core (Constructor)
function _djfais () {
	var playlist = filestatics.musiclist, num = 0, shuffle = true;

	// Randomize
	var shuffled = playlist.sort(function(a, b) { return 0.5 - Math.random() });

	this.audio = new Audio();
	var self = this;
	var fais = document.querySelector('#dj a');
	function switchsong (ctrl) {
		switch (ctrl) {
			case '?next': num = num==playlist.length-1 ? num=0 : num + 1; break;
			case '?prev': num = num==0 ? num=playlist.length-1 : num - 1; break;
		}
		self.audio.src = shuffle ? playlist[num] : shuffled[num];
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
		musicTitle = spliturllast(decodeURI(self.audio.getAttribute("src")));
		playertitle.innerHTML = musicTitle;
		document.title = musicTitle + " - {.!TitleText.}";
		playertitle.innerHTML += ' [' + new Date(self.audio.duration * 1000).toJSON().slice(14, -5) + ']';
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
// </script>

[slideshow.js|no log|public]
{.add header|Cache-Control: public, max-age=86400.}
// <script>
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
// </script>

[thumbnail.js|no log|public]
{.add header|Cache-Control: public, max-age=86400.}
// <script>
var thumbshown = false;
function showthumbnail () {
	// Only run once
	if (thumbshown) return;
	thumbshown = true;
	// Lazyload introduced from throwback
	filestatics.picturelist.forEach(function(url, index) {
		var element = filestatics.nodesfile[filestatics.filelist.indexOf(url)];
		if (element) element.innerHTML = '<img class="thumbnail lazy" onerror="setTimeout(function() { this.src="' + filestatics.picturelist[index] + '"; }, 250)" alt="" data-src="' + filestatics.picturelist[index] + '" />' + element.innerHTML;
	});
	var lazyloadImages;
	if ("IntersectionObserver" in window) {
		lazyloadImages = document.querySelectorAll("img.thumbnail.lazy");
		var imageObserver = new IntersectionObserver(function (entries, observer) {
			entries.forEach(function (entry) {
				if (entry.isIntersecting) setTimeout(function() {
					var image = entry.target;
					image.src = image.dataset.src;
					image.classList.remove("lazy");
					imageObserver.unobserve(image);
				}, 500)
			});
		});
		lazyloadImages.forEach(function (image) {
			imageObserver.observe(image);
		});
	} else {
		popup('{.!Your browser needs to be updated to support thumbnail lazyload..}<br>\
			{.!If you are using a dual-core browser, please switch core at right side of address bar..}'
		);
	}
	var style = (function() {
		var style = document.createElement("style");
		style.appendChild(document.createTextNode(""));
		document.head.appendChild(style);
		return style;
	})();
	style.sheet.insertRule('.lazy{display:initial}', 0);
}
if (filestatics.picturelist.length > 3) { showthumb.style.display='inline'; }
// </script>

[script.randombg]
{.add header|Cache-Control: public, max-age=86400.}
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
			setTimeout(function() { requestimage() }, 1000);
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

[fileactions.js|no log|public]
{.add header|Cache-Control: public, max-age=86400.}
// <script>
// File handler (Actions to file)
function del(it) {
	popup("{.!Delete.} " + (it=='.'?'{.!current FOLDER.}':it.split('&selection=').join(', ')) + "?", '?confirm', function() {
		var xhr = new XMLHttpRequest();
		xhr.open("POST", HFS.folder);
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
		xhr.onload = function() {
			document.write(xhr.responseText.trim());
			// Do 'back' rather than refresh while deleting/doing sth to a folder,
			//  otherwise user will face a chance to get a 404, even an innocent ban
			it=='.' ? window.history.go(-1) : location.reload(false);
		};
		xhr.send("action=delete&selection=" + it);
	})
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
	popup("{.!Do.} "+ actionreadable + ' ' + (file=='.'?'{.!current FOLDER.}':decodeURIComponent(file.split('&selection=').join(', '))) + ' {.!to.} ' + target + "?", '?confirm', function() {
		var xhr2 = new XMLHttpRequest();
		xhr2.open("POST", "?mode=section&id=ajax."+method);
		xhr2.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
		xhr2.onload = function() {
			handler(xhr2.responseText);
			location.reload();
		};
		var hfstoken = HFS.sid;
		xhr2.send("from="+file+"&to="+target+"&token="+hfstoken);
	});
}
function fileaction(ctrl, file0) {
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
					return popup(res.trim());
				var failed = 0, ok = 0, msg = "";
				for (var i=0; i<a.length-1; i++) {
					var s = a[i].trim();
					if (!s.length) { ok++; continue; }
					failed++; msg += s+"\n";
				}
				if (failed) msg = "{.!We met the following problems.}:\n"+msg;
				msg = (ok ? ok+" {.!Files were moved..}\n" : "{.!No file was moved..}\n")+msg;
				popup(msg);
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
		if (file0) file = file0;
		target = fileactioninput.value;
		console.log(method, file, target, handler);
		_fileaction(method, file, target, handler);
	}
}

RegExp.escape = function(text) {
	if (!arguments.callee.sRE) {
		var specials = '/.*+?|()[]{}\\'.split('');
		arguments.callee.sRE = new RegExp('(\\' + specials.join('|\\') + ')', 'g');
	}
	return text.replace(arguments.callee.sRE, '\\$1');
}//escape

function fileactionmulti(ctrl) {
	var filenames = [];            
	filetabletrs.forEach(function(e, k) {
		if (k == 0) return; k -= 1;
		if (e.classList.value.indexOf('selected')!=-1)
			filenames.push(spliturllast(filestatics.filelistnodes[k].href));
	});
	console.log('Selected files before:\n' + filenames);
	switch (ctrl) {
		case '?mask':
			var s = '.';
			popup('{.!Enter a word or regular expression to select..}<br />\
				<span style="font-size: 0.9em;">{.!Regular expression starts and ends with a slash "/"..}\
				<br />{.!A leading backslash "\\" will invert the logic..}</span>', '?prompt', function(input) {
				s = input;
				filetabletrs.forEach(function(element, key) {
					if (key == 0) return; key -= 1;
					element.classList.remove('selected');
				});
				// Manipulation script from HFS 2.4 original tpl
				if (!s) return;
				var re = s.match('^/([^/]+)/([a-zA-Z]*)');
				if (re)
					re = new RegExp(re[1], re[2]);
				else {
					var n = s.match(/^(\\*)/)[0].length;
					s = s.substring(n);
					var invert = !!(n % 2); // a leading "\" will invert the logic
					s = RegExp.escape(s).replace(/[?]/g,".");;
					if (s.match(/\\\*/)) {
						s = s.replace(/\\\*/g,".*");
						s = "^ *"+s+" *$"; // in this case var the user decide exactly how it is placed in the string
					}
					re = new RegExp(s, "i");
				}
				filetabletrs.forEach(function(e, k) {
					if (k == 0) return; k -= 1;
					if (invert ^ re.test(spliturllast(filestatics.filelistnodes[k].href))) e.classList.add('selected');
				});
				refreshmultistatic();
			}, '*');
			break;
		case '?invert':
			filetabletrs.forEach(function(e, k) {
				if (k == 0) return; k -= 1;
				e.classList.value.indexOf('selected') == -1
					? e.classList.add('selected')
					: e.classList.remove('selected');
			});
			refreshmultistatic();
			break;
		case '?move':
			fileaction('?move', filenames.join(':'));
			break;
		case '?delete':
			// Trick
			del(filenames.join('&selection='));
			break;
		case '?archive':
			popup(('{.!Download these.} ' + (filenames.length==0 ? filestatics.filelist.length : filenames.length) + ' {.!files in a .tar archive?.}'), '?confirm', function() {
				var form = document.createElement('form');
				form.style.display = 'none';
				form.action = HFS.folder+'?mode=archive&recursive';
				form.method = 'POST';
				filenames.forEach(function(v, i) {
					form.append(document.createElement('input'));
					form.children[i].type = 'hidden';
					form.children[i].name = 'selection';
					form.children[i].value = v;
				})
				document.body.appendChild(form);
				form.submit();
			});
			break;
		default:
			throw 'ctrl error at fileactionmulti(): Unknown ctrl type ' + ctrl;
	}
	// Refresh selected files
	filenames = [];
	filetabletrs.forEach(function(e, k) {
		if (k == 0) return; k -= 1;
		if (e.classList.value.indexOf('selected')!=-1)
			filenames.push(spliturllast(filestatics.filelistnodes[k].href));
	});
	console.log('Selected files:\n' + filenames);
}
// </script>

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

[ajax.mkdir|no log|public]
{.check session.}
{.set|x|{.postvar|name.}.}
{.break|if={.pos|\|var=x.}{.pos|/|var=x.}|result={.!Illegal action.} (0).}
{.break|if={.not|{.can mkdir.}.}|result={.!Not authorized.} (1).}
{.set|x|{.force ansi|%folder%{.^x.}.}.}
{.break|if={.exists|{.^x.}.}|result={.!Duplicated to existing file/folder.} (2).}
{.break|if={.not|{.length|{.mkdir|{.^x.}.}.}.}|result={.!Input empty.} (3).}
{.add to log|User %user% created folder "{.^x.}".}
{.pipe|{.!OK.}.}

[ajax.rename|no log|public]
{.check session.}
{.break|if={.not|{.can rename.}.}|result={.!Forbidden.} (0).}
{.break|if={.is file protected|{.postvar|from.}.}|result={.!Forbidden.} (1).}
{.break|if={.is file protected|{.postvar|to.}.}|result={.!Forbidden.} (2).}
{.set|x|{.force ansi|%folder%{.postvar|from.}.}.}
{.set|y|{.force ansi|%folder%{.postvar|to.}.}.}
{.break|if={.not|{.exists|{.^x.}.}.}|result={.!Target Not found.} (3).}
{.break|if={.exists|{.^y.}.}|result={.!Duplicated to existing file/folder.} (4).}
{.break|if={.not|{.length|{.rename|{.^x.}|{.^y.}.}.}.}|result={.!Failed.} (5).}
{.add to log|User %user% renamed "{.^x.}" to "{.^y.}".}
{.pipe|{.!OK.}.}

[ajax.move|no log|public]
{.check session.}
{.set|to|{.force ansi|{.postvar|to.}.}.}
{.break|if={.not|{.and|{.can move.}|{.get|can delete.}|{.get|can upload|path={.^to.}.}/and.}.} |result={.!forbidden.} (0).}
{.set|log|{.!Moving items to.} {.^to.}.}
{.for each|fn|{.replace|:|{.no pipe||.}|{.force ansi|{.postvar|from.}.}.}|{:
	{.break|if={.is file protected|var=fn.}|result={.!Forbidden.} (1).}
	{.set|x|{.force ansi|%folder%.}{.^fn.}.}
	{.set|y|{.^to.}/{.^fn.}.}
	{.if not |{.exists|{.^x.}.}|{.^x.}: {.!Target Not found.} (2)|{:
		{.if|{.exists|{.^y.}.}|{.^y.}: {.!Duplicated to existing file/folder.} (3)|{:
			{.set|comment| {.get item|{.^x.}|comment.} .}
			{.set item|{.^x.}|comment=.} {.comment| this must be done before moving, or it will fail.}
			{.if|{.length|{.move|{.^x.}|{.^y.}.}.} |{:
				{.move|{.^x.}.md5|{.^y.}.md5.}
				{.set|log|{.chr|13.}> {.^fn.}|mode=append.}
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

[ajax.comment|no log|public]
{.check session.}
{.break|if={.not|{.can comment.}.} |result={.!Forbidden.} (0).}
{.for each|fn|{.replace|:|{.no pipe||.}|{.postvar|files.}.}|{:
	 {.break|if={.is file protected|var=fn.}|result={.!Forbidden.} (1).}
	 {.set item|{.force ansi|%folder%{.^fn.}.}|comment={.encode html|{.force ansi|{.postvar|text.}.}.}.}
:}.}
{.pipe|{.!OK.}.}

[ajax.changepwd|no log|public]
{.check session.}
{.break|if={.not|{.can change pwd.}.} |result={.!Forbidden.} (0).}
{.if | {.=|{.sha256|{.get account||password.}.}|{.force ansi|{.postvar|old.}.}.}
	| {:{.if|{.length|{.set account||password={.force ansi|{.base64decode|{.postvar|new.}.}.}.}/length.}|{.!OK.} (1)|{.!Failed.} (2).}:}
	| {:{.!Old password not match.} (3):}
.}

[errorpage.css|no log|public]
{.add header|Cache-Control: public, max-age=86400.}
/* <style> /* Fool the editor to highlight syntax properly. Close comment -> */
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
font-family: 'Takeback-Define-Font', "Monda", "Bahnschrift", "Noto Sans", "Segoe UI Emoji",
	"Microsoft YaHei UI", "微软雅黑", "SimHei", "黑体", "Microsoft JhengHei", "Yu Gothic UI",
	"Malgun Gothic", "Lucida Sans Unicode", "Arial Unicode MS", sans-serif;
background-color: black; color: white; text-align: center;
}
a, a:link, a:hover, a:active, a:visited { color: white; text-decoration: none; transition: all 0.6s; }
a:hover { color: black; background-color: white; }
/* </style> */
// </style>

[error-page]
{.if|{.match|*.php*;*.js;*.py;*.vbs*;*.exe|%url%.}|{:{.disconnect.}:}.}
{.add header|Cache-Control: no-cache, max-age=0.}
<!doctype html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="ie=edge,chrome=1" />
<meta name="force-rendering" content="webkit" />
<link rel="icon" href="data:,">
<meta name="theme-color" content="#000000" />
<link rel="stylesheet" href="/~font.css" />
%content%

[not found]
<meta http-equiv="refresh" content="2;url=../">
<link rel="stylesheet" href="/~errorpage.css" />
<title>404::%folder%</title>
</head>
<body>
<h2><br />{.!You have found a 404 page.}</h2>{.!Redirecting to the previous page....}
</body></html>

[overload]
<meta http-equiv="refresh" content="3;url=./">
<title>{.!Overload.}::%folder%</title>
<link rel="stylesheet" href="/~errorpage.css" />
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
<meta http-equiv="refresh" content="3;url=./">
<title>{.!Already Downloading.}::%folder%</title>
<link rel="stylesheet" href="/~errorpage.css" />
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
	<span style="font-size: 0.8em;">{.!Warning: password you entered will be sent to server with a weak encryption..}<br />{.!For better security please change password via HFS management window..}</span>
	<form>
		<input id="oldpwd" type='password' name='oldpwd' maxlength="32" autocomplete
			size="25" placeholder="{.!Input old password....}" /><br />
		<input id="newpwd" type='password' name='newpwd' maxlength="32" autocomplete
			size="25" placeholder="{.!Input new password....}" /><br />
		<input id="newpwd2" type='password' name='newpwd2' maxlength="32" autocomplete
			size="25" placeholder="{.!Input again....}" /><br />
		<input type="button" onclick="checkpassword()" value="{.!Okay.}" />
	</form>
	</div>
	<script>
	function checkpassword() {     // Also changes password if no problem
		if (newpwd.value!=newpwd2.value) {
			popup('{.!Passwords not match, please re-input..}');
		// } else if (newpwd.value=='') {
			// popup('{.!Password cannot be empty!.}')  // Actually password CAN be none
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
				popup('{.!Complete! Use your new password next time!.}');
				beforeRedirect();
			} else {
				if (code == "0") {
					popup("{.!You cannot change your password!.}");
				} else if (code == "3") {
					popup("{.!Failed: Old password you input is wrong!.}");
				} else if (xhr.responseText.trim() == "bad session") {
					popup("{.!Bad session. Try to refresh the page..}");
				} else {
					popup('{.!Unknown error.}: \n'+xhr.responseText.trim());
				}
			}
		}
		};
		xhr.send("token=" + HFS.sid + "&old=" + sha256(oldpwd.value) + "&new="+btoa(unescape(encodeURIComponent(newpass))));
	}
	</script>
	:}
|
	<form>
		<input id='user' size='24' placeholder="{.!Username.}" /><br />
		<input type='password' id='pw' size='24' autocomplete placeholder="{.!Password.}" /><br />
		<input type='hidden' id='sid' size='16' />
		<label><input type="checkbox" title='{.!By checking this you also agree to use Cookies.}' style="width: 1.6em; height: 1.6em;" /> {.!Keep me loggedin.}</label>
		<br /><input type='button' style="width: 8em;" onclick='login()' value='{.!Login.}' />
	</form>
	<script>
	// dj's login method, edited
	var sha256 = function(s) { return SHA256.hash(s); }
	function login() {
		var sid = HFS.sid;
		// The check below causes infinite loop in cookie-disabled browsers
		// if (sid="") // the session was just deleted
			// return location.reload() // but it's necessary for login
		if (!sid) return popup('{.!Bad session. Try to refresh the page..}');  //let the form act normally
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
				popup("{.!The password you entered is incorrect!.}");
			} else if (xhr.responseText === "username not found") {
				popup("{.!The user account you entered doesn't exist!.}");
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
	setTimeout(function() {
		window.location.href = '/~signin';
	}, 0);
};
</script>
</fieldset>

[login=signin|public]
{.if|{.match|*.php*;*.js;*.py;*.vbs*;*.exe|%url%.}|{:{.disconnect.}:}.}
{.add header|Cache-Control: no-cache, max-age=0.}
<!doctype html>
<html>
<head>
{.$commonhead.}
<title>{.!Login.}</title>
<link rel="stylesheet" href="/~errorpage.css" />
<style>
@media (max-width: 760px) { #login { max-width: 80%; } }
#login {
	max-width: 50%;
	margin: auto;
	line-height: 1.8em;
	font-size: 1.2em;
}
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
<!-- Popup: Framework -->
<div class="popup">
	<div id="popupbg" style="display: none;"></div>
	<div id="popupbox" style="display: none;">
		<div id="popupmsg"><!-- Message --></div>
		<div style="height: 1px; border-bottom: white 1px solid; margin: 16px;"></div>
		<div id="popupctrl">
			<!-- Init by function popup() -->
		</div>
	</div>
</div>
<script src="/~popup.js"></script>
<link rel="stylesheet" href="/~font.css" />
</body>

[unauth=unauthorized|public]
<meta http-equiv="refresh" content="16;url=../">
<title>{.!Unauthorized.}</title>
<link rel="stylesheet" href="/~errorpage.css" />
</head>
<body>
	<h2>{.!Unauthorized.}</h2>
	{.!Currently you have no right to access this resource. Please login if possible..}
	<br /><br /><a href="/~signin" style="font-size: 1.2em;">{.!Login.} &gt;&gt;</a>
	<br /><br /><a href="javascript: history.back()" style="font-size: 1.2em;">&lt;&lt; {.!Tap to Back.} </a>
</body>
</html>


[deny]
<meta http-equiv="refresh" content="1;url=../">
<title>Denied</title>
<link rel="stylesheet" href="/~errorpage.css" />
</head>
<body>
	<h2>{.!Access Denied.}</h2><br /><br />{.!Nope.}
</body>
</html>

[ban]
{.disconnect.}

[upload|public]
{.if|{.match|*.php*;*.js;*.py;*.vbs*;*.exe|%url%.}|{:{.disconnect.}:}.}
{.add header|Cache-Control: no-cache, max-age=0.}
<!doctype html>
<!-- Upload page -->
<html>
<head>
{.$commonhead.}
<title>{.!Upload to.}: %folder%</title>
<script>
var counter = 0;
function addUpload() {
	// Add an upload selection
	counter++;
	if (counter < 6) {
		addupload.append(document.createElement('br'));
		var file = document.createElement('input')
		file.classList.add('upload');
		file.name = 'fileupload' + counter;
		file.size = '50';
		file.type = 'file';
		file.multiple = 'multiple';
		addupload.append(file);
	}
	if (counter == 5) {
		addUploadLink.innerHTML = 
			"<span style=\"color:yellow;\">-- {.!Please put multiple files into a zip file.} --</span>";
	}
}
</script>
</head>

<body style="background-color: black; text-align: center;">
	{.$commonbody.}
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
			<input id="foldername" type='text' name='fldname' maxlength="25"
				size="25" placeholder="{.!Input folder name....}"><br />
			<button class="createfolder" id="createfolder" class="upload">{.!Create Folder.}</button>
			<script>
				createfolder.onclick = function () {
					var xhr2 = new XMLHttpRequest();
					// We should post this ajax message to the upload FOLDER, not the ~upload page.
					xhr2.open("POST", "./?mode=section&id=ajax.mkdir");
					xhr2.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
					xhr2.onload = function() { alert(xhr2.responseText.trim()); window.history.go(-1) };
					var hfstoken = HFS.sid;
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
		<input class="upload" name="upbtn" type="submit" value="{.!Send File(s).}">
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
<link rel="stylesheet" href="/~font.css" />
</body>

</html>

[upload-results]
{.if|{.match|*.php*;*.js;*.py;*.vbs*;*.exe|%url%.}|{:{.disconnect.}:}.}
{.add header|Cache-Control: no-cache, max-age=0.}
<!doctype html>
<html>
<head>
{.$commonhead.}
<title>{.!Upload result.}: %folder%</title>
<meta http-equiv="refresh" content="4;url=./">
</head>
<body>
{.$commonbody.}
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

[tkbindex.js|no log|public]
{.add header|Cache-Control: public, max-age=86400.}
// <script>

// Init search engine
var thisSearch = 'https://www.ecosia.org/search?q=';
var storage = window.localStorage;
var ssData = storage.searchEngine;
if (storage.searchEngine != undefined) {
  ssData = ssData.split(',');
  thisSearch = ssData[0];
}
txt.addEventListener('keydown', function(event) {
	if (event.keyCode==13) {
		window.open(thisSearch + txt.value);
	}
});
var search = {
	data: [{
		name: '{.!Ecosia.}',
		url: 'https://www.ecosia.org/search?q='
	}, {
		name: '{.!Swisscows.}',
		url: 'https://swisscows.ch/web?query='
	}, {
		name: '{.!Oscobo.}',
		url: 'https://www.oscobo.com/search.php?q='
	}, {
		name: '{.!Qwant.}',
		url: 'https://www.qwant.com/?q='
	}, {
		name: '{.!Bing.}',
		url: 'https://cn.bing.com/search?q='
	}, {
		name: '{.!Google.}',
		url: 'https://www.google.com/search?q='
	}, {
		name: '{.!Baidu.}',
		url: 'https://www.baidu.com/s?wd='
	}, {
		name: '{.!Sogou.}',
		url: 'https://www.sogou.com/web?query='
	}, {
		name: '{.!360 So.}',
		url: 'https://www.so.com/s?q='
	}, {
		name: '{.!Wolfram.}',
		url: 'https://www.wolframalpha.com/input/?i='
	}]
};
for (var i = 0; i < search.data.length; i++) {
	var addList = '<li>' + search.data[i].name + '</li>'
	document.querySelector('.search-engine-list').innerHTML += addList;
}

document.querySelector('.search-icon').onmouseover = function () {
	document.querySelector('.search-engine').style.display = 'block';
	if (document.querySelector('.hitokoto') !== null) document.querySelector('.hitokoto').style.left = '-100%';
};
var engines = document.querySelectorAll('.search-engine-list li');
for (var i = 0; i < engines.length; i++) {
	engines[i].num = i;
	engines[i].onclick = function (event) {
		thisSearch = search.data[this.num].url;
		document.querySelector('.search-engine').style.display = 'none';
		if (document.querySelector('.hitokoto') !== null) document.querySelector('.hitokoto').style.left = '0';
    	storage.searchEngine = [thisSearch];
	}
}
// </script>

[tkbmain.css|no log|public]
{.add header|Cache-Control: public, max-age=86400.}
/* <style> /* Close -> */
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
	font-family: 'Takeback-Define-Font', "Monda", "Bahnschrift", "Noto Sans", "Segoe UI Emoji",
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
	z-index: -1;
	background: center / cover;
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
	z-index: -2;
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
	background-color: white;
	display:inline;
	border: white solid 1px;
}

input.searchbutton {
	border: 0;
	height: 2.48em;
	width: 2.48em;
	position: relative;
	/* top: 1px; */
	left: -1px;
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
	transform: rotate(-90deg);
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
a[href$=".JPG"]::before,
a[href$=".webp"]::before,
a[href$=".png"]::before,
a[href$=".PNG"]::before,
a[href$=".gif"]::before,
a[href$=".GIF"]::before {
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
a[href$=".MP3"]::before,
a[href$=".aac"]::before,
a[href$=".m4a"]::before,
a[href$=".wav"]::before,
a[href$=".ogg"]::before {
	content: "\1f50a\FE0E  ";
	color: green
}

/* Video */
a[href$=".mp4"]::before,
a[href$=".MP4"]::before,
a[href$=".avi"]::before,
a[href$=".AVI"]::before,
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
a[href$=".xz"]::before,
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
a[href$=".EXE"]::before,
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
a[href$=".rtf"]::before,
a[href$=".RTF"]::before,
a[href$=".doc"]::before,
a[href$=".DOC"]::before,
a[href$=".docx"]::before,
a[href$=".odt"]::before,
a[href$=".xls"]::before,
a[href$=".xlsx"]::before,
a[href$=".ods"]::before,
a[href$=".ppt"]::before,
a[href$=".pptx"]::before,
a[href$=".odp"]::before {
	content: "📝  ";
	color: gray;
}

/* E-Books */
a[href$=".epub"]::before,
a[href$=".PDF"]::before,
a[href$=".pdf"]::before {
	content: "📕  ";
	color: red;
}

/* Other Text */
a[href$=".txt"]::before,
a[href$=".TXT"]::before,
a[href$=".ini"]::before,
a[href$=".htm"]::before,
a[href$=".HTM"]::before,
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
a[href$=".ICO"]::before,
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
	transition: all 0.3s;
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

td.sizenonef, td.sinenonel {
	font-size: 0.9em;
	text-align: center;
	color: #AAAAAA;
	font-style: italic;
	min-width: 6em;
}
td.sizenonef:after {
	content: "{.!folder.}";
}
td.sizenonel:after {
	content: "{.!link.}";
}

#title {
	font-size: 1.2em;
	text-align: center;
	margin: 0;
}

abbr {
	text-decoration: none;
}
button.createfolder, input#foldername {
	transform: scale(1.28);
}
input.upload, input#file-upload-button {
	transform: scale(1.28);
	border: none;
	background-color: transparent;
	color: white;
}
input.upload:hover {
	border: white 1px solid;
	background-color: white;
	color: #333333;
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
	max-height: 67%;
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

#previewactions, #multiselectactions {
	position: relative;
	text-align: right;
	font-size: 0.9em;
	padding-top: 4px;
	/* padding-bottom: 4px; */
}
#previewactions a:link, #multiselectactions a:link {
	text-decoration: underline;
	color: rgb(255, 190, 140);
	margin-right: 0.4em;
}
#previewactions a:hover, #multiselectactions a:hover {
	/* text-decoration: none; */
	color: rgb(255, 230, 200);
	margin-right: 0.5em;
	background-color: transparent;
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
	font-family: 'Takeback-Define-Font', "Monda", "Tahoma", "Malgun Gothic",
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
	/* max-width: 18em; */
	height: 12em;
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

table#files tr.selected {
	outline: yellow 1px solid;
	background-color: rgba(255, 255, 255, 0.16);
}

table#files tr.selected:after {
	content: '✔';
}

#multiselectstatics {
	text-align: right;
}

button, input, input[type="submit" i], input[type="button" i] {
	background-color: white;
	border-color: white;
	border-width: 1px;
	color: #333333;
	border-radius: 0;
	border-style: solid;
	font-family: 'Takeback-Define-Font', "Monda", "Bahnschrift", "Noto Sans", "Segoe UI Emoji",
		"Microsoft YaHei UI", "微软雅黑", "SimHei", "黑体", "Microsoft JhengHei", "Yu Gothic UI",
		"Malgun Gothic", "Lucida Sans Unicode", "Arial Unicode MS", sans-serif;
	transition: ease-out 0.3s;
}
button:hover, input:hover, input[type="submit" i]:hover, input[type="button" i]:hover {
	background-color: transparent;
	color: white;
}
button, input[type="submit" i], input[type="button" i] {
	cursor: pointer;
}

#popupbg {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.75);
}
#popupbox {
	position: fixed;
	top: 33%;
	left: 25%;
	width: 50%;
	/* min-height: 33%; */
	border: white solid 1px;
	z-index: 10240;
	text-align: center;
	font-size: 1.08em;
	padding: 2em 1em;
	background-color: rgba(0, 0, 0, 0.75);
}
#popupctrl button {
	font-size: 1em;
}
#popuppromptinput {
	width: 67%;
	margin: 16px;
	height: 1.28em;
	font-size: 1em;
}
.files {
	max-width: 100%;
	overflow: auto;
	/* scrollbar-width: none; */
}
.lazy{ display:none; }
/* For devices with small screen (mobiles) */
@media (max-width: 950px) {
#title {
	font-size: 1.08em;
}
body {
	font-size: 1.08em;
}
div.statustext {
	font-size: 0.66em;
}
.searchbutton {
	border: white solid 1px;
}
.preview {
	position: fixed;
	left: 0;
	bottom: 0;
	padding: 0.33em 0.66em;
	text-align: left;
}
#preview, #multiselectstatics, #previewactions, #multiselectactions {
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
	left: 2.4em;
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
	max-height: 16em;
}
.previewflashobject {
	display: none;
}
.notice {
	font-size: 1.08em;
	/* text-align: left; */
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
	height: 10em;
}
#showthumb {
	padding-left: 2em;
}
#popupbox {
	width: 80%;
	left: 5%;
}
}

@media (min-width:768px) {
::-webkit-scrollbar {
width: 10px;
height: 10px;
background-color: black;
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
/* </style> */
// </style>

[tkbindex.css|no log|public]
{.add header|Cache-Control: public, max-age=86400.}
/* <style> /* */
body {
    margin: 0px;
    border: 0px;
}
.pond {
    text-align: center;
    color: white;
    font-family: "Monda", "Bahnschrift", "Noto Sans", "Segoe UI Emoji",
        "Microsoft YaHei UI", "微软雅黑", "SimHei", "黑体", "Microsoft JhengHei", "Yu Gothic UI",
        "Malgun Gothic", "Lucida Sans Unicode", "Arial Unicode MS", sans-serif;
}
/* Starry Night by Lea Verou */
/* https://leaverou.github.io/css3patterns/ */
h2.hidden {
    display: none;
}
@keyframes contentslide {
    from {
        position: absolute;
        top: 320px;
        opacity: 0;
    }
    to {
        position: absolute;
        top: 64px;
        opacity: 1;
    }
}
.main {
    width: 100%;
	position: absolute;
	top: 64px;
    opacity: 0;
    animation: contentslide 0.5s ease-out 1s;
    animation-fill-mode: forwards;
}
#title {
    font-size: 2.4em;
    margin: 0;
    padding: 0.3em;
}
.browsehappy {
    background-color: #c54141;
    color: white;
    font-weight: bold;
    font-size: 1.5em;
    width: 100%;
}
@keyframes crossin {
    from {
        width: 100%;
    }
    to{
        width: 75%;
    }
}
#itemlist {
    width: 100%;
    margin: auto;
    animation: crossin 0.5s ease-out 1s;
    animation-fill-mode: forwards;
}
.item {
    font-size: 1.6em;
    width: 74%;
    position: inherit;
}
.item a {
    text-decoration: none;
    transition: all 0.3s;
}
.item a:hover {
    color: #333333;
    background-color: white;
}
.item.left {
    text-align: left;
    left: 0;
    margin-right: auto;
}
.item.right {
    text-align: right;
    right: 0;
    margin-left: auto;
}
.navicon {
    vertical-align: middle;
    height: 32px;
}
@keyframes swing {
    0% {
        left: 0em;
    }
    50% {
        left: 0.5em;
    }
    100% {
        left: 0em;
    }
}
.item.arrow {
    position: relative;
    font-style: italic;
    font-size: 1.4em;
    padding-left: 0.5em;
    padding-right: 0.5em;
    animation: swing 2.4s ease-in 0.1s infinite;
    animation-fill-mode: forwards;
}
.item.arrow::after {
    content: ">>";
}
.item.description {
    font-size: 0.66em;
}
.item.border{
    height: 1px;
    border-bottom: 1px white solid;
    margin-bottom: 1.5em;
    /* width: 90%; */
}
@keyframes crossout {
    from {
        width: 15%;
    }
    to {
        width: 60%;
    }
}
.hitokoto {
    position: relative;
    width: 15%;
    font-size: 1.6em;
    /* font-weight: 700; */ /* bold */
    text-align: left;
    margin: 0px auto 64px auto;
    animation: crossout 0.5s ease-out 1s;
    animation-fill-mode: forwards;
    transition: all 0.5s;
}
.bracket.left {
    position: absolute;
    left: 0;
    top: 0;
}
.bracket.right {
    position: absolute;
    right: 0;
    bottom: 0;
}
#hitokoto {
    /* display: none; */
    opacity: 0;
    text-align: center;
    padding: 15px 64px;
    min-height: 1.8em;
    animation: fadein 0.5s ease-out 2s;
    animation-fill-mode: forwards;
}
/* Below two is for printing effected hitokoto usage */
.hitokotod {
    display: none;
    padding: 15px 50px;
    min-height: 1.8em;
}
#hitokotop {
    min-height: 1.6em;
}
abbr {
    text-decoration: none;
}
#get-top {
    position: fixed;
    right: 0;
    bottom: 0;
    font-size: 3em;
    line-height: 1em;
    width: 1em;
    padding: 0.2em 0.2em;
    margin: 0.6em;
    background-color: rgba(0, 0, 0, 0.75);
    transform: rotate(-90deg);
    cursor: pointer;
    display: none;
    z-index: 100;
    font-family: monospace;
}
.copyright {
    font-size: 0.8em;
    color: #666666;
    width: 100%;
    margin: 48px 0px;
    /* display: none; */
}
span.showonhover {
    opacity: 0.24;
    transition: all 1s;
}
span.showonhover:hover {
    opacity: 1;
}

/* Below is for devices that goes with a width < 950px */
@media (max-width: 950px){
    #title {
        font-size: 1.8em;
    }
    .item {
        width: 100%;
        font-size: 1.2em;
    }
    .item.right {
        text-align: left;
    }
    @keyframes crossin {
        from {
            width: 80%;
        }
        to{
            width: 95%;
        }
    }
    @keyframes crossout {
        from {
            width: 15%;
        }
        to {
            width: 100%;
        }
    }
    .hitokoto {
        width: 100%;
        font-size: 1em;
        margin-bottom: 24px;
    }
    #hitokoto {
        padding: 18px 24px;
    }
    #get-top {
        transform: scale(0.66) rotate(-90deg);
        margin: 0 0.2em;
    }
    .copyright {
        margin: 8px auto;
        /* color: #333333; */
        font-size: 0.6em;
    }
}

/* nav.css */
html, body {
	height: 100%;
}
body {
	background: #f2f2f2;
	overflow-x: hidden;
	overflow-y: auto;
}
a {
	color: white;
}
header a {
	transition: all 0.3s;
}
a:hover, a:active, a:focus {
	text-decoration: none;
}
header a:hover, a:active, a:focus {
	color: black;
	text-decoration: none;
	background-color: #e8e8e8;
	transition: all 0.3s;
}
dl, ol, ul {
	margin-top: 0;
	margin-bottom: 1rem;
}
li {
	list-style: none;
}
ul {
	padding: 0;
}
.dh {
	padding: 0px 10px;
	margin-bottom:10px;
}
.dh .col-xs-4 {
	padding: 0 3px;
}
.dh a{
	background: rgba(255,255,255,1);
	text-align: center;
	display: block;
	line-height: 45px;
	border-radius: 2px;
	font-size: 14px;
	color: #808080;
	transition: all 0.3s ease;
}
.dh a:hover {
	color: #FFF;
	font-size: 20px;
	font-weight: bold;
	background: #459df5;
}
.dhname {
	font-size: 16px;
	font-weight: 400;
	color: #808080;
	display: block;
	margin-bottom: 5px;
}
.sousuo {
	padding: 16px 0;
	transition: none;
}
.sousuo:hover {
    transform: none;
}
.search {
	position: relative;
	width: 100%;
	margin: 0 auto;
}
.search-box {
	height: 50px;
	/* box-shadow: 0px 0px 2px 0px #ccc; */
	border-radius: 10px;
	overflow: hidden;
	display: -webkit-flex;
	display: flex;
	flex-wrap: wrap;
	border: 1px solid #e6e6e6;
}
.search-icon {
	position: absolute;
    left: 4px;
    top: 6px;
    width: 40px;
    height: 40px;
	font-size: 24px;
	overflow: hidden;
	background-color: #e6e6e6;
	border-radius: 25px;
	cursor: pointer;
}
.search-input {
	box-sizing: border-box;
	flex: 1;
	height: 50px;
	line-height: 50px;
	font-size: 16px;
	background: rgba(238, 238, 238, 0.8);
	color: black;
	box-shadow: 0px 5px 20px 0px #d8d7d7;
	border: none;
	outline: none;
	padding-left: 45px;
}
.search-clear {
	position: absolute;
	right: 15px;
	top: 50%;
	font-size: 20px;
	margin-top: -10px;
	cursor: pointer;
	display: none;
}
.search-engine {
	position: absolute;
	top: 60px;
	left: 0;
	width: 100%;
	background: #eeeeee;
	padding: 15px 0 0 15px;
	border-radius: 5px;
	box-shadow: 0px 5px 20px 0px #d8d7d7;
	transition: all 0.3s;
	display: none;
	z-index: 999;
}
.search-engine-head {
	overflow: hidden;
	margin-bottom: 10px;
	padding-right: 15px;
}
.search-engine-tit {
	float: left;
	margin: 0;
	font-size: 14px;
	color: #999;
}
.search-engine-tool {
	float: right;
	font-size: 12px;
	color: #999;
}
.search-engine-tool > span.off {
	background-position: -30px 0px;
}
.search-engine-tool > span {
	float: right;
	display: block;
	width: 25px;
	height: 15px;
	background: url(/pic/deco/off_on.png) no-repeat 0px 0px;
	cursor: pointer;
}
.search-engine-list::after {
	content: '';
	width: 70px;
	height: 18px;
	position: absolute;
	top: -17px;
	left: 1px;
}
.search-engine-list li {
	float: left;
	width: 30%;
	line-height: 30px;
	font-size: 14px;
	padding: 5px 10px 5px 10px;
	margin: 0 10px 10px 0;
	background: #f9f9f9;
	color: #999;
	cursor: pointer;
	list-style: none;
}
.search-engine ul {
	padding: 0;
}
.search-engine-list li img {
	width: 25px;
	height: 25px;
	border-radius: 15px;
	float: left;
	margin-right: 5px;
	margin-top: 2.5px;
}
.search-engine ul::before {
	content: '';
	width: 0px;
	height: 0px;
	position: absolute;
	top: -15px;
	border-top: 8px solid transparent;
	border-right: 8px solid transparent;
	border-bottom: 8px solid #fff;
	border-left: 8px solid transparent;
}
.search-btn {
	width: 80px;
	height: 50px;
	background: #fff;
	border: none;
	color: #64B5F6;
	font-weight: bold;
	border-left: 1px solid #e6e6e6;
	outline: none;
	cursor: pointer;
}
header {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	z-index: 100;
	height: 50px;
	color: white;
	/* background: #FFF; */
}
header .main {
	position: relative;
}
.not_operational {
	position: absolute;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	z-index: 100;
	/* background: rgba(255,255,255,.8); */
	display: none;
}
header .nav {
	width: 100%;
	margin-left: 25px;
	/* background: #FFF; */
	margin: 0;
	overflow: hidden;
	transition: all 0.4s ease;
	position: absolute;
	top: -300px;
	left: 0;
}
header .showNav {
	top: 50px;
	box-shadow: 0 5px 5px rgba(204,204,204,.15);
	-moz-box-shadow: 0 5px 5px rgba(204,204,204,.15);
}
header .nav a {
	display: block;
	line-height: 40px;
	font-size: 16px;
	/* color: #959595; */
	padding: 0 25px;
	/* border-bottom: 1px solid #f5f5f5; */
}
header .head-btn {
	float: right;
	line-height: 60px;
}
header .bar-btn, header .nav-btn {
	position: fixed;
	border: none;
	background: transparent;
	top: 0;
	left: 10px;
	outline: 0;
	margin-top: 10px;
	z-index: 100;
}
header .bar-btn .icon-bar, header .nav-btn .icon-line {
	display: block;
	margin: 6px 0;
	width: 25px;
	height: 2px;
	/* background: #999; */
	cursor: pointer;
	transition: all .4s ease;
	-moz-transition: all .4s ease;
	-webkit-transition: all .4s ease;
	-o-transition: all .4s ease;
}
header .nav-btn {
	left: inherit;
	right: 10px;
}
header .bar-btn .icon-bar, header .nav-btn .icon-line {
	display: block;
	margin: 6px 0;
	width: 25px;
	height: 2px;
	/* background: #999; */
	cursor: pointer;
	transition: all .4s ease;
}
header .nav-btn .middle {
	margin: 0 auto;
}
header .logo {
	font-size: 20px;
}
#content {
	 min-height: 100%;
}
.main-index{
	padding-bottom: 50px;
}
.footer {
	width: 100%;
	background-color: #fff;
	font-size: 13px;
	padding-top: 15px;
	margin-top: -50px;
	height: 50px;
	z-index: 9999;
	color: #959595;
}	
.footer a{
	color: #959595;
}	
@media (min-width: 992px){
	.sousuo:hover {
		transform: scale(1.05);
	}
	.search {
		width: 650px;
	}
	.search-engine {
		width: 650px;
	}
	.search-engine-list li {
		width: 112px;
		margin: 0 15px 15px 0;
	}
	.search-hot-text {
		width: 559px;
		margin-left: 10px;
	}
	.dh {
		padding: 0px 20px;
		margin-bottom:20px;
	}
	header {
		height: 60px;
		color: white;
		border-bottom: 1px solid #e8e8e8;
	}
	header .main {
		padding: 0 24px;
	}
	header .logo {
		float: left;
		font-size: 27px;
		margin: 0;
		font-weight: 400;
		border: none;
	}
	header .logo a {
		display: block;
		line-height: 59px;
		/* color: #484848; */
		font-weight: 400;
	}
	header .logo img {
		width: 40px;
		vertical-align: -10px;
	}
	header .nav {
		padding-left: 2.4em;
		padding-top: 0px;
		height: 100%;
		display: block;
		overflow: hidden;
		position: static;
		width: auto;
		box-shadow: none;
	}
	header .nav li {
		float: left;
		font-size: 16px;
	}
	header .nav a {
		display: block;
		text-decoration: none;
		line-height: 59px;
		/* color: #959595; */
		padding: 0 18px;
		/* border-bottom: 1px solid #e8e8e8; */
	}
	header .nav a:hover {
		border-color: #459df5;
		/* color: #459df5; */
		text-decoration: none;
	}
	.content-box {
		padding: 0 10px;
		padding-top: 61px;
	}
	.main-index {
		padding-top: 60px;
	}
}
@media (min-width: 768px){
	.sousuo {
		padding: 10px 0 50px 0;
		margin-top: 0;
		transition: all 0.2s;
	}
	.search-clear {
		right: 95px;
	}
}

/* </style> */
// </style>


[font.css|public]
{.add header|Cache-Control: public, max-age=86400.}
/* <style> /* */
@font-face { font-family: 'Monda';
	src: url('data:application/x-font-ttf;base64,AAEAAAASAQAABAAgRkZUTWXx2TAAAKE8AAAAHEdERUYDnAVLAAChWAAAADRHUE9TRrZNAwAAoYwAAAhkR1NVQoUFkl0AAKnwAAAAZE9TLzK8NmN8AAABqAAAAFZjbWFwf0tdrAAACNQAAAO2Y3Z0ICj/AGAAABasAAAAOGZwZ20x/KCVAAAMjAAACZZnYXNwAAAAEAAAoTQAAAAIZ2x5ZsqTYEcAABpQAAB/5GhlYWQCjGS+AAABLAAAADZoaGVhE/sJFAAAAWQAAAAkaG10eB3Q/fkAAAIAAAAG1GxvY2HUZ/WcAAAW5AAAA2xtYXhwAugKZwAAAYgAAAAgbmFtZc8OhBwAAJo0AAAG3nBvc3QAAwAAAAChFAAAACBwcmVwFQScMAAAFiQAAACFAAEAAAABAADbbxJ5Xw889QAJCAAAAAAAzNqNfQAAAADM3oz+/zL9DAqECDoAAAAIAAIAAAAAAAAAAQAACZ38lQAAC0b/1/+DCoQAAQAAAAAAAAAAAAAAAAAAAbUAAQAAAbUAWQAHAEAABAACACYANABsAAAAkgmWAAMAAgABA80BkAAFAAAFMwWZAAABHgUzBZkAAAPXAGYCEgAAAgAFAwAAAAAAAKAAAO9AACBLAAAAAAAAAABuZXd0AEAAIPsECZ38lQAACZ0DawAAAJMAAAAAAAAC7ABEAAAAAAKqAAACAAAAAwABGAN6ALAFBABWBRcAkAgAAKwF3ACwA4AAswMAAKwDAAB8BAAAYwQAAKICgQDABAAAogJ0ALoDAABABOIAhATiAM4E4gCkBOIA0ATiAI8E4gCtBOIAsgTiAL0E4gCEBOIAlwMAAQADAAD4BOIAnATiAOAE4gDQBNgAswgAAWoFlABWBYwA2gWwALYF8gDaBOcA2gSHANoGFAC6BfgA1ARsAL4EtgBmBYoA2gR5ANoG8gDaBjoA2gYKALoFLgDaBgYAugW4ANoFGACQBLQAVAYCAMgFagBWCAAAcAU4AF4FJgAwBNoAtAMAAQADAABAAwAAwwTpAJoDoQAOAmgAcwSUAIQEtAC6BFYAlASwAJQEhgCUAxYAbgSiAJQEygC6AlQAzgJaAA0EgAC6ArgAvgdEALoEygC6BJYAlASuALoEsACUAxoAugPgAI4DSABQBMgAsARQAEAGTgA0BCAAQAReAEwDxACMA7gAngKyAQADuACAA3EAQAIAAAADAAEYBFYAlAT5AKYEfQB0BSYAMAKiAP4D6gCQBAEAngb4AJwEFQC6BB4AYANgAGIEAACiBvgAnAIBACAEDADCBBEAzwQcAL4ElQDIAmgAhQEzAAAE4gCoAZwAbAIAAHgEGgDPA/8AmwQeAH4H/wCkB/8ApAf/AMcE2ACTBZQAVgWUAFYFlABWBZQAVgWUAFYFlABWBpYAYgWwALYE5wDaBOcA2gTnANoE5wDaBGwAvgRsAL4EbAC+BGwAvgS/AEwGOgDaBgoAugYKALoGCgC6BgoAugYKALoDzQCBBgoAugYCAMgGAgDIBgIAyAYCAMgFJgAwBSgA1AUBAL4ElACEBJQAhASUAIQElACEBJQAhASUAIQGzQCDBFYAlASGAJQEhgCUBIYAlASGAJQCVP/2AlQAzgJUAA4CVP/KBIYAlgTKALoElgCUBJYAlASWAJQElgCUBJYAlAQBAGQElgCUBMgAsATIALAEyACwBMgAsAReAEwEqgCxBF4ATAWUAFYElACEBZQAVgSUAIQFlABWBJQAhAWwALYEVgCUBbAAtgRWAJQFsAC2BFYAlAWwALYEVgCUBfIA2gSwAJQEvwBMBLAAlATnANoEhgCUBOcA2gSGAJQE5wDaBIYAlATnANoEhgCUBOcA2gSGAJQGFAC6BKIAlAYUALoEogCUBhQAugSiAJQGFAC6BKIAlAX4ANQEygC6BgAAkATIAB0EbAC+AlQAAwRsAL4CVABkBGwAvgJUAEoEbAC+AlQAewRsAL4CVADOCSIAvgSuAM4EtgBmAloACgWKANoEgAC6BHwAugR5ANoCuAC+BHkA2gK4AL4EeQDaArgAvgR5ANoEVAC+BHkANALEADQGOgDaBMoAugY6ANoEygC6BjoA2gTKALoEygC6Bi4A1ATKALoGCgC6BJYAlAYKALoElgCUBgoAugSWAJQGFQC3BsYAlgW4ANoDGgC6BbgA2gMaALoFuADaAxoAsgUYAJAD4ACOBRgAkAPgAI4FGACQA+AAjgUYAJAD4ACOBLQAVANIAFAEtABUA0gAUAS0AFQDSAA6BgIAyATIALAGAgDIBMgAsAYCAMgEyACwBgIAyATIALAGAgDIBMgAsAYCAMgEyACwCAAAcAZOADQFJgAwBF4ATAUmADAE2gC0A8QAjATaALQDxACMBNoAtAPEAIwDegCN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AAIBQAACAgxBAAAAAVAAAQENAUIREhADESslIQEBIQEzAaYCT/7aAgb76gGysY8EHftUBaYAAAD//wDaAAAFDActECcBdgHuAWITBgAlAAAACbEAAbgBYrApKwD//wC6/+oEIAdTECcBdgGaAYgTBgBFAAAACbEAAbgBiLApKwD//wDaAAAFPActECcBdgI4AWITBgAnAAAACbEAAbgBYrApKwD//wCU/+oD9gdTECcBdgFyAYgTBgBHAAAACbEAAbgBiLApKwD//wDaAAAEDwctECcBdgGiAWITBgApAAAACbEAAbgBYrApKwD//wBuAAAC6AdTECcBdgEKAYgTBgBJAAAACbEAAbgBiLApKwD//wDaAAAGGActECcBdgKmAWITBgAwAAAACbEAAbgBYrApKwD//wC6AAAGlAWpECcBdgLU/94TBgBQAAAACbEAAbj/3rApKwD//wDaAAAErgctECcBdgHyAWITBgAzAAAACbEAAbgBYrApKwD//wC6/mgEGgWpECcBdgGY/94TBgBTAAAACbEAAbj/3rApKwD//wCQ/+oEjActECcBdgG8AWITBgA2AAAACbEAAbgBYrApKwD//wCO/+oDbAWpECcBdgEq/94TBgBWAAAACbEAAbj/3rApKwD//wBUAAAEYActECcBdgGIAWITBgA3AAAACbEAAbgBYrApKwD//wBQ//gC1AbdECcBdgDAARITBgBXAAAACbEAAbgBErApKwD//wBwAAAHkAe0ECcAQwJXAdITBgA6AAAACbEAAbgB0rApKwD//wA0AAAGGgYwECcAQwF+AE4TBgBaAAAACLEAAbBOsCkrAAD//wBwAAAHkAe0ECcAdgNGAdITBgA6AAAACbEAAbgB0rApKwD//wA0AAAGGgYwECcAdgJtAE4TBgBaAAAACLEAAbBOsCkrAAD//wBwAAAHkAcUECcAagIAAW4TBgA6AAAACbEAArgBbrApKwD//wA0AAAGGgWQECcAagEm/+oTBgBaAAAACbEAArj/6rApKwD//wAwAAAE9ge0ECcAQwDqAdITBgA8AAAACbEAAbgB0rApKwD//wBM/moEJAYwECcAQwCPAE4TBgBcAAAACLEAAbBOsCkrAAAAAQACAl4CFwLcAAMAHUAaAAABAQBLAAAAAU8CAQEAAUMAAAADAAMRAw8rEzUhFQICFQJefn4AAAABAAIBkgRKAiQAAwAdQBoAAAEBAEsAAAABTwIBAQABQwAAAAMAAxEDDysTNSEVAgRIAZKSkgAA//8BAAOBAgEFvBEPAA8CwQRqwAAACbEAAbgEarApKwD//wEAA4ECAQW8EQcADwBABNMACbEAAbgE07ApKwAAAP//AQD+rgIBAOkQBgAPQAD//wEAA4EDnQW8EC8ADwLBBGrAABEPAA8EXQRqwAAAErEAAbgEarApK7EBAbgEarApKwAA//8BAAOBA50FvBAnAA8AQATTEQcADwHcBNMAErEAAbgE07ApK7EBAbgE07ApKwAA//8BAP6uA50A6RAnAA8B3AAAEAYAD0AAAAEAWAAAAyIFpgALAChAJQACAgxBBAEAAAFPAwEBAQ9BBgEFBQ0FQgAAAAsACxERERERBxMrIREhNSERMxEhFSERAVz+/AEEvAEK/vYDo4EBgv5+gfxdAAABAHAAAAM6BaYAEwA2QDMHAQEIAQAJAQBXAAQEDEEGAQICA08FAQMDD0EKAQkJDQlCAAAAEwATERERERERERERCxcrIREhNSERITUhETMRIRUhESEVIREBdP78AQT+/AEEvAEK/vYBCv72AZmBAYmBAYL+foH+d4H+ZwAAAQC0ASoDGwOFAAcAF0AUAAEAAAFNAAEBAFEAAAEARRMRAhArAAYgJhA2IBYDG5D+t46PAUmPAcCWlQEwlpYA//8AugAABqIA8hAnABEE6AAAECcAEQJ0AAAQBgARAAAABwDR/+0KhAW1ABAAHAAsADgASABUAFgBDEuwGlBYQCkLBw4DAAkFAgIEAAJZAAEBA1EMAQMDFEEQCA8DBAQGURENCgMGBhUGQhtLsCFQWEAtCwcOAwAJBQICBAACWQABAQNRDAEDAxRBEQENDQ1BEAgPAwQEBlEKAQYGFQZCG0uwMVBYQDELBw4DAAkFAgIEAAJZAAwMDEEAAQEDUQADAxRBEQENDQ1BEAgPAwQEBlEKAQYGFQZCG0A3CwEHCQEFAgcFWQ4BAAACBAACWQAMDAxBAAEBA1EAAwMUQREBDQ0NQRAIDwMEBAZRCgEGBhUGQllZWUAuVVU6OR4dAQBVWFVYV1ZRUEtKQUA5SDpINTQvLiUkHSweLBkYExIJBwAQARASDisBMjc2NTU0JiMmBwYGFRUUFiQGICY1NTQ2IBYXFQEyNzY1NTQmIgcGBhUVFBYkBiAmNTU0NiAWFxUBMjc2JzU0JiIHBgYVFRQWJAYgJjU1NDYgFhcVAQEzAQH7cRwQTT09HTcdTQF8iv65h4UBToMCAyJxHBBNeh03HU0BfIr+uYeFAU6DAgHdchwQAU16HTcdTQF8iv65h4UBToMC+D0CH5X95gMGYzZdXZRUAQwWbVhflmBPw8O4Nbq5vrQ2/FRjNl1dlFQMFmxYX5ZgT8PDuDW6ub60Nv75YzZdXZRUDBZsWF+WYE/Dw7g1urm+tDb+mAWm+loAAQCuAFACUgPUAAUABrMCAAEmKyUBARcDEwHG/ugBEZPPz1ABwgHCRv6E/oQAAAAAAQC0AFACWAPUAAUABrMEAAEmKyUnEwM3AQFHk8/PjAEYUEYBfAF8Rv4+AAABABAAAALwBeIAAwAYQBUAAAAOQQIBAQENAUIAAAADAAMRAw8rMwEzARACKbf92wXi+h4AAQD/AmYDsgXiAA4AL0AsAwECAwFABAECBQEABgIAWAADBwEGAwZTAAEBDgFCAAAADgAOERERERIRCBQrATUhNQEzASE1MxUzFSMVArH+TgFnjf6kARpxkJACZs9cAlH9ruvrW88AAAABAAH/6gUUBbwANACKthMSAgMFAUBLsAlQWEAwAAsACgoLXgYBAwcBAgEDAlcIAQEJAQALAQBXAAUFBFEABAQUQQAKCgxSAAwMFQxCG0AxAAsACgALCmYGAQMHAQIBAwJXCAEBCQEACwEAVwAFBQRRAAQEFEEACgoMUgAMDBUMQllAEzQyLy4pKCUkEREWGRMRERETDRcrJCY1NSM1MzUjNTMSNzYgFhcWFQc0LgIiBwYHBhUVIRUhFSEVIRUUFiA3Njc2NTMUBwYhIAEMVrW1tbUDoYsCE/AeDr8yMXDuREQwXAFn/pkBZ/6ZugGXODgNB78/dP67/u9t3ZwThrSGATJwYZOdRmERkmcsIRAPJUe+GIa0hjK8fzAwXDJG2likAAAAAgCFAv4GSQWmAAwAFAAItRANAQACJisBETMTEzMRIxEDIwMRIREjNSEVIxEDTca4usR/rKGz/Y/UAi/UAv4CqP5jAZ39WAIz/nIBjv3NAjZycv3KAAAAAAIAUgFeA/4F4QAFAAgACLUIBgIAAiYrEzUBMwEVJSEBUgGOqgF0/QkCR/7pAV58BAf7+XyQA0kABACg//IGYAWwAAoAEgAeACsADUAKJiAaFBALAQAEJisBESEgFxUUBiMjEREzMjc1NCMjAAQgJBIQAiQgBAIQAAQgJAIQEiQgBBIQAgKUAUIBAQZ7mbK6hgJ/w/6XASEBZwEgoKD+4P6Z/t+hBB7+7/6a/q/DwwFRAZkBUsFyAT8DQvUOcYH+swGnhxih/NOnpwEkAWkBJKen/tz+mP5FccABUgGbAVHAwP6v/pj+7wABAI4BtwMBAmEAAwAGswEAASYrEzUhFY4CcwG3qqoA//8AQAAAAsAF4hAGABIAAAABAGwE/QE5BcsAAwAGswEAASYrEzUzFWzNBP3OzgAAAAMAQAHlBjIEhgALAC0AOQAKtzQuHQ0GAAMmKwEyNjc3JiYjIgYUFgI2MzIWFxc3Njc2MzIWFhQGBiMiJyYnJwYHBiMiJyY1NDcFIgYHBxYWMzI2NCYBeCGqRUVrySFKUlJ9dz5w9kkdIKKYRDFhjkJCjmF94jQeHrCdQjJhR4lMBGEhq0VFW9ohSlJSAmhqNjVPd3qoeQHlOZA6Fxh7Nhhkl66VY6IlGhqgQBsyYL+EYxplMjJJiXmoegAAAQCN/oQCxgW8ABYABrMKAAEmKxMiJzUWMzInETQ2MzIXFSYjIgYVERQG+zY4ETh4AXiZLzkMIlU6e/6EB3wCfAUGpo8GfAFZRfsAkocAAAACAEACewMxBLQAEQAjAAi1GRIHAAImKwAWMzI1MxQGIyInJiMiFSM0NhIWMzI1MxQGIyInJiMiFSM0NgFvziVuYXpYV6Y2HW5herXOJW5helhXpjYdbmF6A4J1Z3eCWB1nd4IBMnVnd4JYHWd3ggD//wDgAAAEAgXiECcBoADyAAAQBgAgAAD//wCO/wQEEwR4ECYAHwAAEQcAQgCA/2wACbEBAbj/bLApKwD//wCs/w4ERgR4ECYAIQAAEQcAQgCe/3YACbEBAbj/drApKwAAAgB0AAAD3AWmAAUACQAItQgGAgACJishAQEzAQEnEwMBAeD+lAFsqgFS/q5T9/f+8ALVAtH9L/0roAI1Aif92QAAAAABAG4AAAXYBeEAIQA6QDcIAQUFBFEHAQQEDkEKAgIAAANPCQYCAwMPQQwLAgEBDQFCAAAAIQAhIB8eHSEjEiEjEREREQ0XKyERIREjESM1MzU0NjMzFyMiFRUhNTQ2MzMXIyIVFSEVIREED/3MvLGxoaV3DHSZAjShpXcMdJkBAf7/A5b8agOWjqGTiYWFs6GTiYWFs478agAAAAACAG4AAASgBeEAAwAYAElARgAFBQRRAAQEDkEKAQEBAE8AAAAMQQgBAgIDTwYBAwMPQQsJAgcHDQdCBAQAAAQYBBgXFhUUExIQDg0LCAcGBQADAAMRDA8rATUzFQERIzUzNTQ2MzMXIyIVFSERIxEhEQPkvPx/sbGhpXcMdJkCxbz99wTjw8P7HQOWjqKTiIWEtPvcA5b8agAAAAABAG7/+AV0BeEAHgA+QDsAAQEHUQAHBw5BBQEDAwJPBgECAg9BAAgIAFEECQIAAA0AQgEAHRsYFhMSERAPDg0MCwoIBgAeAR4KDisFIiYnJjURISIVFSEVIREjESM1MzU0NjMhERQWMzMHBShddi1U/qCZAQH+/7yxsaGlAitMdyEWCBwnSeID9oWzjvxqA5aOoZOJ+4OATp4AAAACAG4AAAe2BeEAAwAnAFhAVQoBBwcGUQkBBgYOQQ8BAQEATwAAAAxBDQQCAgIFTwsIAgUFD0EQDgwDAwMNA0IEBAAABCcEJyYlJCMiIR8dHBoXFhQSEQ8MCwoJCAcGBQADAAMREQ8rATUzFQERIREjESM1MzU0NjMzFyMiFRUhNTQ2MzMXIyIVFSERIxEhEQb6vPx//aa8sbGhpXcMdJkCWqGldwx0mQLFvP33BOPDw/sdA5b8agOWjqGTiYWFs6GTiYWFs/vcA5b8agABAG7/+AhXBeEALQBNQEoKAQEBCVEMAQkJDkEHBQIDAwJPCwgCAgIPQQANDQBPBgQOAwAADQBCAQAsKiclIiEfHRwaFxYVFBMSERAPDg0MCwoIBgAtAS0PDisFIiYnJjURISIVFSEVIREjESERIxEjNTM1NDYzMxcjIhUVITU0NjMhERQWMzMHCAtddi1U/qCZAQH+/7z92byxsaGldwx0mQInoaUCK0x3IRYIHCdJ4gP2hbOO/GoDlvxqA5aOoZOJhYWzoZOJ+4OATp4AAAAAAAAgAYYAAQAAAAAAAABdAAAAAQAAAAAAAQAFAF0AAQAAAAAAAgAHAGIAAQAAAAAAAwANAGkAAQAAAAAABAANAGkAAQAAAAAABQBLAHYAAQAAAAAABgANAMEAAQAAAAAABwAlAM4AAQAAAAAACAAMAPMAAQAAAAAACQAMAPMAAQAAAAAACwAfAP8AAQAAAAAADAAfAP8AAQAAAAAADQCQAR4AAQAAAAAADgAaAa4AAQAAAAAAEAAFAF0AAQAAAAAAEQAHAGIAAwABBAkAAAC6AcgAAwABBAkAAQAKAoIAAwABBAkAAgAOAowAAwABBAkAAwAaApoAAwABBAkABAAaApoAAwABBAkABQCWArQAAwABBAkABgAaA0oAAwABBAkABwBKA2QAAwABBAkACAAYA64AAwABBAkACQAYA64AAwABBAkACwA+A8YAAwABBAkADAA+A8YAAwABBAkADQEgBAQAAwABBAkADgA0BSQAAwABBAkAEAAKAoIAAwABBAkAEQAOAoxDb3B5cmlnaHQgKGMpIDIwMTIsIHZlcm5vbiBhZGFtcyAodmVybkBuZXd0eXBvZ3JhcGh5LmNvLnVrKSwgd2l0aCBSZXNlcnZlZCBGb250IE5hbWVzICdNb25kYSdNb25kYVJlZ3VsYXJNb25kYSBSZWd1bGFyVmVyc2lvbiAxIDsgdHRmYXV0b2hpbnQgKHYwLjkzLjgtNjY5ZikgLWwgOCAtciA1MCAtRyAyMDAgLXggMCAtdyAiZ0ciIC1XIC1jTW9uZGEtUmVndWxhck1vbmRhIGlzIGEgdHJhZGVtYXJrIG9mIHZlcm5vbiBhZGFtcy5WZXJub24gQWRhbXNodHRwOi8vY29kZS5uZXd0eXBvZ3JhcGh5LmNvLnVrVGhpcyBGb250IFNvZnR3YXJlIGlzIGxpY2Vuc2VkIHVuZGVyIHRoZSBTSUwgT3BlbiBGb250IExpY2Vuc2UsIFZlcnNpb24gMS4xLiBUaGlzIGxpY2Vuc2UgaXMgYXZhaWxhYmxlIHdpdGggYSBGQVEgYXQ6IGh0dHA6Ly9zY3JpcHRzLnNpbC5vcmcvT0ZMaHR0cDovL3NjcmlwdHMuc2lsLm9yZy9PRkwAQwBvAHAAeQByAGkAZwBoAHQAIAAoAGMAKQAgADIAMAAxADIALAAgAHYAZQByAG4AbwBuACAAYQBkAGEAbQBzACAAKAB2AGUAcgBuAEAAbgBlAHcAdAB5AHAAbwBnAHIAYQBwAGgAeQAuAGMAbwAuAHUAawApACwAIAB3AGkAdABoACAAUgBlAHMAZQByAHYAZQBkACAARgBvAG4AdAAgAE4AYQBtAGUAcwAgACcATQBvAG4AZABhACcATQBvAG4AZABhAFIAZQBnAHUAbABhAHIATQBvAG4AZABhACAAUgBlAGcAdQBsAGEAcgBWAGUAcgBzAGkAbwBuACAAMQAgADsAIAB0AHQAZgBhAHUAdABvAGgAaQBuAHQAIAAoAHYAMAAuADkAMwAuADgALQA2ADYAOQBmACkAIAAtAGwAIAA4ACAALQByACAANQAwACAALQBHACAAMgAwADAAIAAtAHgAIAAwACAALQB3ACAAIgBnAEcAIgAgAC0AVwAgAC0AYwBNAG8AbgBkAGEALQBSAGUAZwB1AGwAYQByAE0AbwBuAGQAYQAgAGkAcwAgAGEAIAB0AHIAYQBkAGUAbQBhAHIAawAgAG8AZgAgAHYAZQByAG4AbwBuACAAYQBkAGEAbQBzAC4AVgBlAHIAbgBvAG4AIABBAGQAYQBtAHMAaAB0AHQAcAA6AC8ALwBjAG8AZABlAC4AbgBlAHcAdAB5AHAAbwBnAHIAYQBwAGgAeQAuAGMAbwAuAHUAawBUAGgAaQBzACAARgBvAG4AdAAgAFMAbwBmAHQAdwBhAHIAZQAgAGkAcwAgAGwAaQBjAGUAbgBzAGUAZAAgAHUAbgBkAGUAcgAgAHQAaABlACAAUwBJAEwAIABPAHAAZQBuACAARgBvAG4AdAAgAEwAaQBjAGUAbgBzAGUALAAgAFYAZQByAHMAaQBvAG4AIAAxAC4AMQAuACAAVABoAGkAcwAgAGwAaQBjAGUAbgBzAGUAIABpAHMAIABhAHYAYQBpAGwAYQBiAGwAZQAgAHcAaQB0AGgAIABhACAARgBBAFEAIABhAHQAOgAgAGgAdAB0AHAAOgAvAC8AcwBjAHIAaQBwAHQAcwAuAHMAaQBsAC4AbwByAGcALwBPAEYATABoAHQAdABwADoALwAvAHMAYwByAGkAcAB0AHMALgBzAGkAbAAuAG8AcgBnAC8ATwBGAEwAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAf//AA8AAAABAAAAAMw9os8AAAAAzNmo7gAAAADM2o1yAAEAAAAMAAAAIgAqAAIAAwADAbAAAQGxAbIAAgGzAbQAAQAEAAAAAQAAAAIAAQAAAAAAAAABAAAACgA0AEIAA0RGTFQAHmdyZWsAFGxhdG4AHgAEAAAAAP//AAAABAAAAAD//wABAAAAAWtlcm4ACAAAAAEAAAABAAQAAgAAAAEACAACAy4ABAAAA9wFhAAVABMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD/8AAAAAD/vgAA/3z/vgAA/4wAAAAAAAAAAP/8//r//P/0AAD//gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP/8AAAAAAAAAAAAAP/6//L/+P/4AAAAAAAAAAAAAAAAAAAAAAAA/94AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD//gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA//IAAAAAAAD/+gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD/4AAA/+j/zAAA/9QAAAAAAAAAAAAAAAAAAAAAAAD/5gAA/8QAAAAAAAAAAP/0AAAAAP/8AAD/iP+IAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA//oAAP/8AAAAAAAAAAAAAAAAAAAAAAAA/+gAAAAAAAAAAAAAAAAAAAAAAAD/9P/0/8T/xAAAAAAAAAAAAAD/3AAAAAAAAAAAAAAAAAAAAAAAAP/y//L/2P/YAAAAAAAAAAAAAP/0//gAAAAAAAAAAAAAAAAAAAAA//b/+v/E/8QAAAAAAAAAAAAA//gAAAAA//QAAAAAAAAAAAAAAAD/9P/0/9j/2AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD//AAA//wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP/8AAD//AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP/8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD//AAA//oAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP/Y/9gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/9j/2AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD/2P/YAAAAAAAAAAAAAQBVACQAJgAnACkAKgAuAC8AMgAzADQANQA3ADkAOgA8AEQARQBIAEsAUABRAFIAUwBZAFoAXACCAIMAhACFAIYAhwCUAJUAlgCXAJgAmgCfALMAtAC1ALYAtwC4ALoAvwDAAMEAwgDEAMYA0ADnAOkBBgEIAQoBDgEPARABEQESARMBFgEYARoBJgE3ATkBOgFQAVIBXAFdAV4BXwFgAWIBagGEAYoBjAGOAZAAAgBGACQAJAABACYAJgACACcAJwADACkAKQAEACoAKgAFAC4ALgAGAC8ALwAHADIAMgADADMAMwAIADQANAADADUANQAJADcANwAKADkAOQALADoAOgAMADwAPAANAEQARAAOAEUARQAPAEgASAAQAEsASwARAFAAUQARAFIAUwAPAFkAWQASAFoAWgATAFwAXAAUAIIAhwABAJQAmAADAJoAmgADAJ8AnwANALMAswARALQAuAAPALoAugAPAL8AvwAUAMAAwAAPAMEAwQAUAMIAwgABAMQAxAABAMYAxgABANAA0AADAOcA5wARAOkA6QARAQYBBgARAQgBCAARAQoBCgARAQ4BDgADAQ8BDwAPARABEAADAREBEQAPARIBEgADARMBEwAPARYBFgAJARgBGAAJARoBGgAJASYBJgAKATcBNwATATkBOQAUAToBOgANAVABUAABAVIBUgABAVwBXAADAV0BXQAPAV4BXgADAV8BXwAPAWABYAAJAWIBYgAJAWoBagAKAYQBhAAPAYoBigATAYwBjAATAY4BjgATAZABkAAUAAIAbQAPAA8ADQARABEADgAkACQAAQAmACYAAgAqACoAAgAtAC0AAwAyADIAAgA0ADQAAgA2ADYABAA3ADcABQA4ADgABgA5ADkABwA6ADoACAA7ADsACQA8ADwACgBEAEQACwBGAEgADABSAFIADABUAFQADABYAFgADwBZAFkAEABaAFoAEQBcAFwAEgCCAIcAAQCJAIkAAgCUAJgAAgCaAJoAAgCbAJ4ABgCfAJ8ACgCiAKgACwCpAK0ADACyALIADAC0ALgADAC6ALoADAC7AL4ADwC/AL8AEgDBAMEAEgDCAMIAAQDDAMMACwDEAMQAAQDFAMUACwDGAMYAAQDHAMcACwDIAMgAAgDJAMkADADKAMoAAgDLAMsADADMAMwAAgDNAM0ADADOAM4AAgDPAM8ADADRANEADADVANUADADXANcADADZANkADADbANsADADdAN0ADADeAN4AAgDgAOAAAgDiAOIAAgDkAOQAAgEOAQ4AAgEPAQ8ADAEQARAAAgERAREADAESARIAAgETARMADAEUARQAAgEVARUADAEcARwABAEgASAABAEiASIABAEmASYABQEqASoABgErASsADwEsASwABgEtAS0ADwEuAS4ABgEvAS8ADwEwATAABgExATEADwEyATIABgEzATMADwE0ATQABgE1ATUADwE3ATcAEQE5ATkAEgE6AToACgFOAU4AAgFQAVAAAQFRAVEACwFSAVIAAQFTAVMACwFVAVUADAFXAVcADAFcAVwAAgFdAV0ADAFeAV4AAgFfAV8ADAFkAWQABgFlAWUADwFmAWYABgFnAWcADwFoAWgABAFqAWoABQGKAYoAEQGMAYwAEQGOAY4AEQGQAZAAEgABAAAACgAqADgAA0RGTFQAFGdyZWsAFGxhdG4AFAAEAAAAAP//AAEAAAABbGlnYQAIAAAAAQAAAAEABAAEAAAAAQAIAAEAGgABAAgAAgAGAAwBsgACAE8BsQACAEwAAQABAEk') format('truetype');
}
/* </style> */
// </style>

