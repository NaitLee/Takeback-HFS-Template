
[+common-html]
<style>
    .animator-show { opacity: unset; transform: unset; }
    .animator-hide { opacity: 0; transform: unset; }
    body, * {
        font-size: 1em;
        font-family: sans-serif;
    }
    body {
        color: black;
        background-color: white;
        text-align: left;
    }
    table#files {
        width: 100%;
    }
    .background {
        background: none;
    }
    .background-mask {
        background-color: transparent;
    }
    section#tooltip, section.lyrics {
        font-size: 1em;
        border-top: 1px solid black;
        border-bottom: 1px solid black;
        height: 3.6em;
        color: black;
        background-color: rgba(255, 255, 255, 0.8);
    }
    a {
        text-decoration: none;
        color: blue;
        font-weight: normal;
        font-family: "Arial Unicode MS","Lucida Sans Unicode","DejaVu Sans",sans-serif;
    }
    a:link {
        color: blue;
    }
    a:hover, a:active {
        color: blue;
        text-decoration: underline;
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
        background-color: white;
        color: black;
        border: none;
        padding: 0.2em 0.5em;
        text-decoration: none;
    }
    .part0 h1 {
        display: inline;
        font-size: 1.6em;
        font-weight: bold;
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
        background-color: white;
        padding: 4px;
    }
    .part3 span, .part3 div, .part3 a:link, .part3 a:hover, .part3 a:active, .part3 a:visited {
        background-color: transparent;
    }
    video::cue {
        background-color: rgba(255, 255, 255, 0.8);
        color: black;
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
        width: unset;
        margin: unset;
    }
    .part1 table#files tbody tr.selected {
        outline: 1px solid blue;
    }
    .part1 table#files thead tr td {
        background-color: white;
        color: black;
    }
    .part3 .right #preview .close span {
        color: #f33;
    }
    .part3 .right #preview .nopreview {
        color: #777;
    }
    .part3 .right #preview a.download span {
        color: blue;
    }
    .dialog {
        text-align: center;
        background-color: rgba(255, 255, 255, 0.8);
    }
</style>
