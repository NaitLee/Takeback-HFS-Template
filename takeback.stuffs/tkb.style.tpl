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

/* 
a[href^="javascript:"]::before {
    content: "🔮  ";
    color: #5AE
} */

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
