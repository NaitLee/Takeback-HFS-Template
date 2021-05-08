
[+common-html]
<style>
    .animator-show { opacity: unset; transform: unset; }
    .animator-hide { opacity: 0; transform: unset; }
    body, * {
        background-color: white;
        color: #777;
        font-family: 'Tahoma', 'Segoe UI' , sans-serif;
    }
    body {
        font-size: 1em;
    }
    .part0, .part1, .part2 {
        width: 60em;
        margin: auto;
    }
    table#files {
        width: 100%;
    }
    .background, .background-mask {
        background-color: transparent;
    }
    section#tooltip, section.lyrics {
        background-color: #667;
        color: white;
        border-top: 2px solid #aaa;
        border-bottom: 2px solid #aaa;
        border-radius: 0.5em;
    }
    a:link, a:visited, a:hover, a:active {
        color: #357;
    }
    a.invert, a.invert:link, a.invert:visited, a.invert:hover, a.invert:active {
        background-color: #bcd;
        color: #444;
        border-radius: 0.3em;
        border: none;
        padding: 0.2em 0.5em;
    }
    button, .part3 .right #preview a span.menuitem {
        background-color: #bcd;
        color: #444;
        border-radius: 0.3em;
        border: none;
        padding: 0.2em 0.5em;
        text-decoration: none;
    }
    .part0 h1, .part0 nav, .part0 nav * {
        background-color: #678;
        color: white;
    }
    .part0 p a span {
        color: #777;
        font-style: italic;
        animation: none;
        font-family: serif;
        display: none;
    }
    .part3 .left #audioplayer, .part3 .right #preview {
        border-radius: 0.3em;
        border: none;
        white-space: nowrap;
        background-color: #bcd;
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
    .search {
        border: 2px solid #678;
        padding: 0 0.5em;
    }
    .part1 table#files tbody tr.selected {
        outline: 1px solid #678;
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
    @media (max-width: 950px) {
        .part0, .part1, .part2 {
            width: 100%;
        }
    }
</style>
