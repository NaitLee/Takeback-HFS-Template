
[+common-html]
<style>
    .animator-show { opacity: unset; transform: unset; }
    .animator-hide { opacity: 0; transform: unset; }
    body, * {
        font-size: 14px;
        font-family: "Arial Unicode MS","Lucida Sans Unicode","DejaVu Sans",sans-serif;
    }
    body {
        color: #eee;
        background-color: black;
    }
    table#files {
        width: 100%;
    }
    .background {
        background-image: linear-gradient(90deg,#002,#113,#201053,#101032,#00002D,#000029,#002,#002);
    }
    .background-mask {
        background-color: transparent;
    }
    section#tooltip, section.lyrics {
        background-color: #ddd;
        color: #333;
        font-size: 14pt;
        border-top: 2px solid #aaa;
        border-bottom: 2px solid #aaa;
        height: 36pt;
    }
    a {
        text-decoration: none;
        font-size: 12pt;
        color: blue;
        font-weight: normal;
        font-family: "Arial Unicode MS","Lucida Sans Unicode","DejaVu Sans",sans-serif;
    }
    a:link {
        color: blue;
    }
    a:hover, a:active {
        color: black;
    }
    a:visited {
        color: purple;
    }
    a.invert, a.invert:link, a.invert:visited, a.invert:hover, a.invert:active {
        background-color: transparent;
        color: unset;
        border-radius: 0;
        border: none;
        padding: 0;
    }
    button, .part3 .right #preview a span.menuitem {
        background-color: #ddd;
        color: #333;
        border: none;
        padding: 0.2em 0.5em;
        text-decoration: none;
    }
    .part0 h1 {
        background-color: #ddd;
        color: #337;
    }
    .part0 nav, .part0 nav * {
        background-color: #ccc;
        color: #337;
    }
    .part0 p a span {
        color: #777;
        font-style: italic;
        animation: none;
        font-family: serif;
        display: none;
    }
    .part3 .left #audioplayer, .part3 .right #preview {
        border: none;
        white-space: nowrap;
        background-color: #ddd;
        padding: 4px;
    }
    .part3 span, .part3 div, .part3 a:link, .part3 a:hover, .part3 a:active, .part3 a:visited {
        color: #444;
        background-color: transparent;
    }
    video::cue {
        background-color: transparent;
        color: #444;
    }
    .arrow::after {
        display: none;
    }
    .search input[type="search"] {
        height: 24px;
    }
    .search input[type="submit"] {
        height: 24px;
    }
    .part1 table#files {
        background-color: white;
        width: 90%;
    }
    .part1 table#files tbody tr.selected {
        outline: 1px solid blue;
    }
    .part1 table#files thead tr td {
        background-color: #888;
        color: white;
    }
    .part1 table#files tbody tr td {
        border-bottom: 1px solid #333;
        color: #333;
    }
    .part2 a {
        color: #ccc;
    }
    .part3 .right #preview .close span {
        color: #f33;
    }
    .part3 .right #preview .nopreview {
        color: #777;
    }
    .part3 .right #preview a.download span {
        color: #444;
    }
</style>
