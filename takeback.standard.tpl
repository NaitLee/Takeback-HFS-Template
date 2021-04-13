[api level]
2

[+special:strings]
_use_font=1
_background_image=0
_title=0
_player=0
_time_format=0

[+special:alias|cache]
fallback={.if|$1|$1|$2.}
get-common-html={.replace|@head@|$1|@body@|$2|{.$common-html.}.}
mm-dd-yyyy={.time|format={.fallback|{.!_time_format.}|mm/dd/yyyy.}|when=%item-modified%.}
check session=if|{.{.cookie|HFS_SID_.} != {.postvar|token.}.}|{:{.cookie|HFS_SID_|value=|expires=-1.} {.break|result={.!Bad session.}.}:}
can mkdir=and|{.get|can upload.}|{.!option.newfolder.}
can comment=and|{.get|can upload.}|{.!option.comment.}
can rename=and|{.get|can delete.}|{.!option.rename.}
can change pwd=member of|can change password
can move=or|1|1
escape attr=replace|"|"|$1
commentNL=if|{.pos|<br|$1.}|$1|{.replace|{.chr|10.}|<br />|$1.}
add bytes=switch|{.cut|-1||$1.}|,|0,1,2,3,4,5,6,7,8,9|$1 Bytes|K,M,G,T|$1Bytes


[common-html]
<!doctype html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="theme-color" content="#000000"/>
    <meta name="description" content="{.!This is a file sharing site..}" />
    <link rel="stylesheet" href="/~takeback-general.css" defer />
    {.if|{.!_use_font.}|<link rel="stylesheet" href="/~monda-font.css" defer />.}
    @head@
    <script>
        window.HFS = {
            sid: '{.cookie|HFS_SID_.}',
            folder: '%folder%',
            encodedFolder: '%encoded-folder%',
            can_delete: '{.get|can delete.}',
            can_mkdir: '{.can mkdir.}',
            can_comment: '{.can comment.}',
            can_rename: '{.can rename.}',
            can_move: '{.can move.}'
        }
    </script>
</head>
<body>
    {.if|{.!_background_image.}|
        <section class="background-image"></section>
    |
        <section class="background"></section>
    .}
    <section class="background-mask"></section>
    <section id="dialog" style="opacity: 0;"></section>
    <section id="tooltip" style="display: none;"></section>
    <script src="/~takeback-general.js"></script>
    @body@
</body>
</html>

[]
{.get-common-html|
    <title>{.fallback|{.!_title.}|{.!HFS.}.}::%folder%</title>
    <link rel="stylesheet" href="/~takeback-filelist.css" defer />
|
    <!-- Header, Nav, Notice -->
    <section class="part0">
        <h1>{.!HTTP File Server.}</h1>
        <nav>
            <span>
                {.replace|<a href="/"></a>|<a href="/">🏠 {.!Home.}</a>|{.breadcrumbs|<a href="%bread-url%">%bread-name%</a>/.}.}
            </span>
            <span class="right">
                <span>👤 %user%</span>
                {.if|%user%|
                    <a class="invert" href="/~login#%encoded-folder%">{.!Manage.}</a>|
                    <a href="/~login#%encoded-folder%">{.!Login.}</a>
                .}
            </span>
            <div style="height: 4px;"></div>
            <form class="search" action="./">
                <input type="search" name="search" placeholder="{.!Search.}" /><input type="submit" value="🔍" />
            </form>
            {.if|{.get|can upload.}|
                <span class="right">
                    <a class="invert" href="./~upload" data-tooltip="{.!Upload some files to this folder.}">⇧ {.!Upload.}</a>
                </span>
            .}
        </nav>
        <p>
            <a href="http://rejetto.com/hfs/"><span>{.!Files here are available for download..}</span></a>
        </p>
    </section>
    %files%
.}

[files]
<!-- Filelist -->
<section class="part1">
    <table id="files">
        <thead>
            <tr>
                <td>
                    <a class="invert" href="./?sort=e" data-tooltip="{.!Click to sort files by extension.}">&nbsp;🔷</a>
                    <a class="invert" href="./?sort=n" data-tooltip="{.!Click to sort files by name.}">
                        {.!Item.} (%number%)
                    </a>
                    <a id="showthumb" class="invert" href="javascript:" data-tooltip="{.!Show thumbnails of photos.}" style="display: none; margin-left: 2em;">
                        📸 {.!Photo Thumbnails.}
                    </a>
                </td>
                <td>
                    <a class="invert" href="./?sort=!t" data-tooltip="{.!Click to sort files by time.} [ {.!Format:.}mm/dd/yyyy ]">
                        {.!Last Modified.}
                    </a>
                </td>
                <td>
                    <a class="invert" href="./?sort=s" data-tooltip="{.!Click to sort files by size.}">
                        {.!Size.}
                    </a>
                </td>
            </tr>
        </thead>
        <tbody>
            %list%
        </tbody>
    </table>
</section>
<!-- Footer -->
<section class="part2">
    <p>
        <a href="./~folder.tar" data-tooltip="{.!Save files in this folder to an archive.}">[ {.!Archive.} ]</a>
    </p>
    <div class="blank"></div>
</section>
<!-- Dashboard -->
<section class="part3">
    <span class="left">
        <span id="audioplayer" style="display: none;">
            <a href="javascript:" data-player="next" data-player-alt="prev">&nbsp;{.fallback|{.!_player.}|\( •̀ ω •́ )✧ ♫.}&nbsp;</a>
            <a href="javascript:" data-player="pause" data-player-alt="sequence">
                <span>&nbsp;►❙&nbsp;</span>
                <span data-player="status"></span>
            </a>
            <span data-player="nowplaying"></span>
        </span>
    </span>
    <div class="right">
        <div id="preview" style="display: none;">
            <a href="javascript:" data-preview="close" class="close">
                <span>[X]</span>
            </a>
            <div class="title">
                <span class="arrow"></span>
                <span data-preview="title"></span>
            </div>
            <div data-preview="menu"></div>
            <hr />
            <div data-preview="content"></div>
        </div>
    </div>
</section>
<section class="slideshow" style="display: none;">
    <img src="" alt="" />
    <img src="" alt="" />
</section>
<script src="/~takeback-filelist.js" defer></script>

[nofiles]
<p>
    {.if|{.length|{.?search.}.}|
        {.!No search results.}|
        {.!Empty folder.}
    .}
</p>

[file]
<tr class="file">
    <td><a href="%item-url%">%item-name%</a><p>%item-comment%</p></td>
    <td>{.mm-dd-yyyy.}</td>
    <td>%item-size%B</td>
</tr>

[folder]
<tr class="folder">
    <td><a href="%item-url%">%item-name%</a><p>%item-comment%</p></td>
    <td>{.mm-dd-yyyy.}</td>
    <td>{.!folder.}</td>
</tr>

[link]
<tr class="link">
    <td><a href="%item-url%">%item-name%</a><p>%item-comment%</p></td>
    <td></td>
    <td>{.!link.}</td>
</tr>

[takeback-general.js|public|no log|cache]
// <script>
    class Helper {
        getFilename(path) {
            return decodeURIComponent(path.split('/').slice(-1)[0]);
        }
        getDirname(path) {
            return decodeURIComponent(path.split('/').slice(0, -1).join('/') + '/');
        }
        getPath(url) {
            return decodeURIComponent('/' + url.split('/').slice(3).join('/'));
        }
    }
    window.helper = new Helper();

    class Animator {
        constructor(selector) {
            if (typeof selector == 'string') {
                this.elements = document.querySelectorAll(selector);
            } else {
                this.elements = [selector];
            }
            this.FRAME = 1000 / 60;
            // Edit CSS for controlling how to animate
            this.classShow = 'animator-show';
            this.classHide = 'animator-hide';
        }
        hide(timeout = 200, callbackfn = () => undefined) {
            this.elements.forEach(element => {
                element.style.transition = `all ${timeout}ms`;
                setTimeout(() => {
                    element.classList.add(this.classHide);
                    element.classList.remove(this.classShow);
                }, this.FRAME);
                setTimeout(() => {
                    element.style.transition = '';
                    element.style.display = 'none';
                    callbackfn();
                }, timeout - 1);
            });
        }
        show(timeout = 200, callbackfn = () => undefined) {
            this.elements.forEach(element => {
                element.classList.add(this.classHide);
                element.style.transition = `all ${timeout}ms`;
                element.style.display = '';
                setTimeout(() => {
                    element.classList.remove(this.classHide);
                    element.classList.add(this.classShow);
                }, this.FRAME);
                setTimeout(() => {
                    element.style.transition = '';
                    element.style.display = '';
                    callbackfn();
                }, timeout);
            });
        }
    }
    window.$ = (x) => new Animator(x);

    class TooltipManager {
        constructor() {
            this.elemTooltip = document.getElementById('tooltip');
            document.querySelectorAll('*[data-tooltip]').forEach(element => {
                element.addEventListener('mouseover', event => this.show(element.getAttribute('data-tooltip')));
                element.addEventListener('mouseout', event => this.hide());
            });
        }
        show(message) {
            this.elemTooltip.innerText = message;
            $(this.elemTooltip).show();
        }
        hide() {
            $(this.elemTooltip).hide();
        }
    }
    window.addEventListener('DOMContentLoaded', () => window.tooltip_manager = new TooltipManager());

    class Dialog {
        constructor() {
            this.sectionDialog = document.getElementById('dialog');
            this.elemDialog = document.createElement('div');
            $(this.elemDialog).hide();
            this.elemDialog.classList.add('dialog');
            this.elemText = document.createElement('p');
            let hr = document.createElement('hr');
            this.elemActions = document.createElement('p');
            this.elemActions.style.display = 'flex';
            this.elemActions.style.justifyContent = 'space-around';
            this.elemDialog.appendChild(this.elemText);
            this.elemDialog.appendChild(hr);
            this.elemDialog.appendChild(this.elemActions);
            this.sectionDialog.appendChild(this.elemDialog);
            this.close();
        }
        clearActions() {
            this.elemActions.querySelectorAll('*').forEach(e => e.remove());
        }
        showDialog() {
            this.sectionDialog.style.top = '0';
            this.sectionDialog.style.opacity = '1';
            $(this.elemDialog).show();
        }
        close() {
            this.sectionDialog.style.opacity = '0';
            $(this.elemDialog).hide(undefined, () => this.sectionDialog.style.top = '200%');
        }
        alert(message, callbackfn = () => undefined) {
            function done() {
                this.close();
                callbackfn();
            }
            this.elemDialog.onkeyup = event => {
                if (event.key == 'Enter') done.bind(this)();
            };
            this.elemText.innerText = message;
            this.clearActions();
            let ok = document.createElement('a');
            ok.innerText = '{.!OK.}';
            ok.href = 'javascript:';
            ok.classList.add('invert');
            ok.addEventListener('click', done.bind(this));
            this.elemActions.appendChild(ok);
            this.showDialog();
        }
        confirm(message, callbackfn = () => undefined) {
            function done() {
                this.close();
                callbackfn();
            }
            this.elemDialog.onkeyup = event => {
                if (event.key == 'Enter') done.bind(this)();
            };
            this.elemText.innerText = message;
            this.clearActions();
            let ok = document.createElement('a');
            ok.innerText = '{.!OK.}';
            ok.href = 'javascript:';
            ok.classList.add('invert');
            ok.addEventListener('click', done.bind(this));
            this.elemActions.appendChild(ok);
            let cancel = document.createElement('a');
            cancel.innerText = '{.!Cancel.}';
            cancel.href = 'javascript:';
            cancel.classList.add('invert');
            cancel.addEventListener('click', event => {
                this.close();
            });
            this.elemActions.appendChild(cancel);
            this.showDialog();
        }
        prompt(message, callbackfn = (input) => input) {
            function done() {
                this.close();
                callbackfn(elemInput.value);
            }
            this.elemText.innerText = message;
            let elemInput = document.createElement('input');
            let br = document.createElement('br');
            elemInput.type = 'text';
            elemInput.classList.add('prompt-input');
            elemInput.addEventListener('keyup', event => {
                if (event.key == 'Enter') done.bind(this)();
            });
            this.elemText.appendChild(br);
            this.elemText.appendChild(elemInput);
            this.clearActions();
            let ok = document.createElement('a');
            ok.innerText = '{.!OK.}';
            ok.href = 'javascript:';
            ok.classList.add('invert');
            ok.addEventListener('click', done.bind(this));
            this.elemActions.appendChild(ok);
            let cancel = document.createElement('a');
            cancel.innerText = '{.!Cancel.}';
            cancel.href = 'javascript:';
            cancel.classList.add('invert');
            cancel.addEventListener('click', event => {
                this.close();
            });
            this.elemActions.appendChild(cancel);
            this.showDialog();
            elemInput.focus();
        }
    }
    window.addEventListener('DOMContentLoaded', () => window.dialog = new Dialog());
// </script>

[takeback-filelist.js|public|no log|cache]
// <script>
    class StaticsManager {
        constructor() {
            this.typeMap = {
                audio: ['.mp3', '.ogg', '.wav', '.m4a'],
                video: ['.mp4', '.ogv', '.mpv', '.webm'],
                image: ['.png', '.jpg', '.jpeg', '.gif', '.webp'],
                doc: ['.txt', '.html', '.htm']
            }
            this.filelist = [];
            document.querySelectorAll('table#files tbody tr td:nth-child(1) a').forEach(element => this.filelist.push(element.href));
        }
    }
    window.addEventListener('DOMContentLoaded', () => window.statics = new StaticsManager());

    class Player {
        // The lyric system made a mess here...
        constructor() {
            this.masterElement = document.getElementById('audioplayer');
            $(this.masterElement).show();
            this.sequence = 'shuffle';
            this.playing = false;   // For tracking whether the song is playing
            this.lyricIndex = 0;    // For tracking which line of lyric is playing
            this.lyricTimeout = 0;  // For tracking when the next line of lyric to show. sometimes needs clearTimeout()
            this.audio = new Audio();
            this.audio.pause();
            this.audio.onended = () => this.play(1);
            this.audio.onerror = () => this.play(1);
            this.songlist = window.statics.filelist.filter(filename => statics.typeMap['audio'].some(format => filename.toLowerCase().endsWith(format)));
            if (this.songlist.length == 0) $(this.masterElement).hide();
            this.nowplaying = 0;    // for tracking current playing song
            this.songlistShuffled = this.songlist.sort((a, b) => 0.5 - Math.random());
            document.getElementById('audioplayer').querySelectorAll('*[data-player], *[data-player-alt]').forEach(element => {
                switch (element.getAttribute('data-player')) {
                    case 'next':
                        element.addEventListener('click', event => {
                            this.play(1);
                        });
                        break;
                    case 'pause':
                        element.addEventListener('click', event => {
                            this.playing ? this.pause() : this.play();
                        });
                        break;
                    case 'status':
                        this.elemStatus = element;
                        break;
                    case 'nowplaying':
                        this.elemNowplaying = element;
                        break;
                }
                switch (element.getAttribute('data-player-alt')) {
                    case 'prev':
                        element.addEventListener('contextmenu', event => {
                            event.preventDefault();
                            this.play(-1);
                        });
                        break;
                    case 'sequence':
                        element.addEventListener('contextmenu', event => {
                            event.preventDefault();
                            if (this.sequence == 'shuffle') {
                                this.sequence = 'sequence';
                            } else {
                                this.sequence = 'shuffle';
                            }
                        });
                        break;
                }
            });
        }
        play(offset = 0) {
            if (offset != 0 || this.audio.src == '') {  // If "play" is just going to continue
                let count = this.nowplaying + offset;
                if (count < 0) count = this.songlist.length + count;
                else if (count >= this.songlist.length) count = count % this.songlist.length;
                this.nowplaying = count;
                this.lyricIndex = 0;
                this.scheduleLyric(-1);
                this.audio.src = this.sequence == 'shuffled' ? this.songlist[count] : this.songlistShuffled[count];
                this.loadLyric(this.audio.src, () => this.audio.play());
            } else {    // If "play" is going to switch song
                if (this.lyricIndex != 0 && this.lyricIndex != -1)  // If this song have lyrics
                    this.audio.currentTime = parseInt(this.lyricKeys[this.lyricIndex]) / 1000;
                this.scheduleLyric(this.lyricIndex + 1);
                this.audio.play();
            }
            this.elemStatus.innerText = '{.!Playing:.}';
            this.elemNowplaying.innerText = helper.getFilename(this.audio.src);
            this.playing = true;
        }
        pause() {
            this.audio.pause();
            this.elemStatus.innerText = '{.!Paused:.}';
            this.playing = false;
            this.scheduleLyric(-1); // clearTimeout() next lyric schedule
        }
        loadLyric(audiofile, callbackfn = () => undefined) {
            // Replace .mp3 etc. with .lrc
            let lyricfile = audiofile.split('.').slice(0, -1).join('.') + '.lrc';
            if (statics.filelist.indexOf(lyricfile) == -1) {
                // No lyric file. at least in filelist
                tooltip_manager.hide();
                this.lyricIndex = -1;
                callbackfn();
                return;
            }
            fetch(lyricfile).then(r => {
                if (!r.ok) {    // If 404
                    tooltip_manager.hide();
                    this.lyricIndex = -1;
                    callbackfn();
                }
                else return r.text();
            }).then(t => {
                if (!t) {
                    callbackfn();
                    return;
                }
                this.lyricIndex = 0;    // init
                let lines = t.split('\n');
                // [ti:title]
                let argRegex = /^\[([a-zA-Z]{2}):(.*)\]$/;
                // [00:00.00]lyric/translation
                let lrcRegex = /^\[(\d+):(\d\d?)(\.\d\d?)\](.*)/;
                this.lyricMap = {
                    0: ''
                }
                for (let i of lines) {
                    if (argRegex.test(i)) {
                        this.lyricMap[0] += i.match(argRegex)[2] + ' - ';
                    } else if (lrcRegex.test(i)) {
                        let matched = i.match(lrcRegex);
                        let time = parseInt(matched[1]) * 60 * 1000 + parseInt(matched[2]) * 1000 + parseFloat(matched[3]) * 1000;
                        this.lyricMap[time] = matched[4].replace('/', '\n');
                    }
                }
                this.lyricKeys = [];
                for (let i in this.lyricMap) this.lyricKeys.push(i);
                this.scheduleLyric(this.lyricIndex);
                callbackfn();
            });
        }
        scheduleLyric(index) {
            // Controls the schedule of lyric strings
            if (this.lyricIndex == -1) return;  // If no lyrics
            if (index == -1) {  // If want clearTimeout()
                clearTimeout(this.lyricTimeout);
                return;
            }
            let lyricMap = this.lyricMap;
            let lyricKeys = this.lyricKeys;
            let delay = lyricKeys[index] - (lyricKeys[index - 1] || 0);
            this.lyricTimeout = setTimeout(() => {
                let lyric = lyricMap[lyricKeys[index]];
                if (lyric === undefined) return;
                tooltip_manager.hide();
                // For a smooth animation
                setTimeout(() => {
                    tooltip_manager.show(lyric);
                    if (lyricKeys[index] != undefined && this.playing) {
                        this.lyricIndex = index;
                        this.scheduleLyric(++index);
                    }
                }, 200);
            }, delay - 201);
        }
    }
    window.addEventListener('DOMContentLoaded', () => window.player = new Player());

    class Previewer {
        // Also file control menu
        constructor() {
            this.selectedFiles = [];
            document.querySelectorAll('.part1 table#files tbody tr td:nth-child(1) a').forEach(element => {
                let path = helper.getPath(element.href);    // href contains http://.../
                if (path.endsWith('/')) return;
                element.addEventListener('click', event => {
                    event.preventDefault();
                    event.cancelBubble = true;  // prevent selecting item, just preview
                    this.preview(path);
                    this.selectedFiles = [path];
                    this.initMenu('file');
                });
            });
            document.querySelectorAll('table#files tbody tr').forEach(element => {
                element.addEventListener('click', event => {
                    element.classList.toggle('selected');
                    let path = helper.getPath(element.querySelector('td:nth-child(1) a').href);
                    // if (!path.endsWith('/')) this.preview(path);
                    this.selectedFiles = [... document.querySelectorAll('table#files tbody tr.selected')].map(x => helper.getPath(x.querySelector('td:nth-child(1) a').href));
                    this.initMenu('selections');
                });
            });
            $('#preview').show();
            document.getElementById('preview').querySelectorAll('*[data-preview]').forEach(element => {
                switch (element.getAttribute('data-preview')) {
                    case 'close':
                        element.addEventListener('click', event => {
                            this.close();
                            this.initMenu();
                        });
                        break;
                    case 'title':
                        this.elemTitle = element;
                        break;
                    case 'menu':
                        this.elemMenu = element;
                        break;
                    case 'content':
                        this.elemContent = element;
                        break;
                }
            });
            this.elemTitle.innerText = helper.getFilename(HFS.folder.slice(0, -1));
            this.initMenu();
        }
        delete(items) {
            dialog.confirm('{.!Delete @items@?.}'.replace('@items@', items.map(x => helper.getFilename(x)).join('; ')), () => {
                let xhr = new XMLHttpRequest();
                xhr.open('POST', HFS.folder);
		        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
                xhr.onload = () => {
                    dialog.alert('{.!Success.}', () => location.href = (items[0] == HFS.encodedFolder ? '../' : './'));
                }
                xhr.send(`action=delete&selection=${items.join('&selection=')}`);
            });
        }
        move(items) {
            dialog.prompt('{.!Move items to:.}', (target) => {
                let xhr = new XMLHttpRequest();
                xhr.open('POST', './?mode=section&id=ajax.move');
		        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
                xhr.onload = () => {
                    dialog.alert('{.!Success.}', () => location.href = (items[0] == HFS.encodedFolder ? '../' : './'));
                }
                xhr.send(`path=${helper.getDirname(items[0])}&from=${items.map(x => helper.getFilename(x)).join(':')}&to=${target}&token=${HFS.sid}`);
            });
        }
        rename(items) {
            if (items.length > 1) {
                dialog.alert('{.!Can only rename 1 file.}');
                return;
            }
            dialog.prompt('{.!Rename item to:.}', (target) => {
                let xhr = new XMLHttpRequest();
                xhr.open('POST', './?mode=section&id=ajax.rename');
		        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
                xhr.onload = () => {
                    dialog.alert('{.!Success.}', () => location.href = (items[0] == HFS.encodedFolder ? '../' : './'));
                }
                xhr.send(`from=${items.join(':')}&to=${target}&token=${HFS.sid}`);
            });
        }
        comment(items) {
            dialog.prompt('{.!Enter comment:.}', (comment) => {
                let xhr = new XMLHttpRequest();
                xhr.open('POST', './?mode=section&id=ajax.comment');
		        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
                xhr.onload = () => {
                    dialog.alert('{.!Success.}', () => location.href = (items[0] == HFS.encodedFolder ? '../' : './'));
                }
                xhr.send(`files=${items.join(':')}&text=${comment}&token=${HFS.sid}`);
            });
        }
        archive(items) {
            let form = document.createElement('form');
            form.style.display = 'none';
            form.action = './?mode=archive&recursive';
            form.method = 'POST';
            items.forEach((v, i) => {
                form.append(document.createElement('input'));
                form.children[i].type = 'hidden';
                form.children[i].name = 'selection';
                form.children[i].value = helper.getFilename(v);
            });
            document.body.appendChild(form);
            form.submit();
        }
        initMenu(type = 'folder') {
            function createButton(name, action) {
                let a = document.createElement('a');
                let span = document.createElement('span');
                span.classList.add('menuitem');
                span.innerText = name;
                a.addEventListener('click', action.bind(this));
                a.href = 'javascript:';
                a.style.margin = '0 0.2em';
                a.appendChild(span);
                return a;
            }
            let mark = document.createElement('span');
            mark.style.margin = '0 0.2em';
            let menu = [mark];
            switch (type) {
                case 'folder':
                    mark.innerText = '{.!Folder:.}';
                    if (HFS.can_delete) {
                        menu.push(createButton('{.!Delete.}', () => this.delete([HFS.encodedFolder])));
                        if (HFS.can_move) {
                            menu.push(createButton('{.!Move.}', () => this.move([HFS.encodedFolder])));
                        }
                        if (HFS.can_rename) {
                            menu.push(createButton('{.!Rename.}', () => this.rename([HFS.encodedFolder])));
                        }
                        if (HFS.can_comment) {
                            menu.push(createButton('{.!Comment.}', () => this.comment([HFS.encodedFolder])));
                        }
                    }
                    break;
                case 'file':
                    mark.innerText = '{.!File:.}';
                    if (HFS.can_delete) {
                        menu.push(createButton('{.!Delete.}', () => this.delete(this.selectedFiles)));
                        if (HFS.can_move) {
                            menu.push(createButton('{.!Move.}', () => this.move(this.selectedFiles)));
                        }
                        if (HFS.can_rename) {
                            menu.push(createButton('{.!Rename.}', () => this.rename(this.selectedFiles)));
                        }
                        if (HFS.can_comment) {
                            menu.push(createButton('{.!Comment.}', () => this.comment(this.selectedFiles)));
                        }
                    }
                    break;
                case 'selections':
                    mark.innerText = '{.!Selections:.}';
                    menu.push(createButton('{.!Select All.}', () => document.querySelectorAll('table#files tbody tr').forEach(e => e.classList.add('selected'))));
                    menu.push(createButton('{.!Invert.}', () => document.querySelectorAll('table#files tbody tr').forEach(e => e.classList.toggle('selected'))));
                    if (HFS.can_delete) {
                        menu.push(createButton('{.!Delete.}', () => this.delete(this.selectedFiles)));
                        if (HFS.can_move) {
                            menu.push(createButton('{.!Move.}', () => this.move(this.selectedFiles)));
                        }
                        if (HFS.can_rename) {
                            menu.push(createButton('{.!Rename.}', () => this.rename(this.selectedFiles)));
                        }
                        if (HFS.can_comment) {
                            menu.push(createButton('{.!Comment.}', () => this.comment(this.selectedFiles)));
                        }
                    }
                    menu.push(createButton('{.!Archive.}', () => this.archive(this.selectedFiles)));
                    break;
            }
            this.elemMenu.querySelectorAll('*').forEach(e => e.remove());
            if (menu.length > 1) for (let i of menu) this.elemMenu.appendChild(i);
        }
        close() {
            this.elemContent.querySelectorAll('*').forEach(e => e.remove());
            this.elemTitle.innerText = helper.getFilename(HFS.folder.slice(0, -1));
        }
        preview(url) {
            this.close();
            this.elemTitle.innerText = helper.getFilename(url);
            let type = 'unknown';
            for (let i in statics.typeMap) {
                if (statics.typeMap[i].some(format => url.toLowerCase().endsWith(format))) {
                    type = i;
                    break;
                }
            }
            let wrapperContent = document.createElement('div');
            let wrapperActions = document.createElement('div');
            switch (type) {
                case 'audio':
                    let audio = document.createElement('audio');
                    audio.controls = 'controls';
                    audio.src = url;
                    wrapperContent.appendChild(audio);
                    audio.play();
                    let a0 = document.createElement('a');
                    a0.href = 'javascript:';
                    a0.innerText = '[ {.!Move to mini player.} ]';
                    a0.addEventListener('click', event => {
                        this.close.bind(this)();
                        player.sequence = 'shuffle';
                        player.nowplaying = 0;
                        let number = player.songlistShuffled.map(x => helper.getPath(x)).indexOf(url);
                        player.play(number);
                    });
                    wrapperActions.appendChild(a0);
                    break;
                case 'video':
                    let video = document.createElement('video');
                    video.controls = 'controls';
                    video.src = url;
                    wrapperContent.appendChild(video);
                    video.play();
                    break;
                case 'image':
                    let img = document.createElement('img');
                    img.src = url;
                    wrapperContent.appendChild(img);
                    let a1 = document.createElement('a');
                    a1.href = 'javascript:';
                    a1.innerText = '[ {.!Start Slideshow.} ]';
                    a1.addEventListener('click', event => {
                        this.close.bind(this)();
                        this.slideshow();
                    });
                    wrapperActions.appendChild(a1);
                    break;
                case 'doc':
                    let iframe = document.createElement('iframe');
                    iframe.src = url;
                    wrapperContent.appendChild(iframe);
                    break;
                default:
                    let span = document.createElement('span');
                    span.classList.add('nopreview');
                    span.innerText = '{.!No preview available.}';
                    wrapperContent.appendChild(span);
                    break;
            }
            this.elemContent.appendChild(wrapperContent);
            let download = document.createElement('a');
            let span = document.createElement('span');
            span.innerText = '[ {.!Download.} ]';
            download.appendChild(span);
            download.classList.add('download');
            download.href = url;
            download.download = helper.getFilename(url);
            wrapperActions.appendChild(download);
            this.elemContent.appendChild(wrapperActions);
        }
        slideshow() {
            let pictures = statics.filelist.filter(x => statics.typeMap['image'].some(y => x.endsWith(y)));
            let slideshow = document.querySelector('.slideshow');
            let imgs = slideshow.querySelectorAll('img');
            let n = 0;
            document.body.style.overflow = 'hidden';
            function switchslide() {
                imgs[1].src = pictures[n];
                imgs[1].style.opacity = '1';
                setTimeout(() => {
                    imgs[0].src = pictures[n++];
                    n %= pictures.length;
                    imgs[1].style.opacity = '0';
                }, 1000);
            }
            let interval = setInterval(switchslide, 5000);
            switchslide();
            slideshow.oncontextmenu = event => {
                event.preventDefault();
                $(slideshow).hide();
                document.body.style.overflow = '';
                clearInterval(interval);
            }
            $(slideshow).show();
        }
    }
    window.addEventListener('DOMContentLoaded', () => window.previewer = new Previewer());

    class ThumbsManager {
        constructor() {
            this.buttonShowThumb = document.getElementById('showthumb');
            this.buttonShowThumb.addEventListener('click', this.showThumb.bind(this));
            if (statics.filelist.some(x => statics.typeMap['image'].some(y => x.endsWith(y)))) {
                $(this.buttonShowThumb).show();
            };
            this.shown = false;
        }
        showThumb() {
            if (this.shown) return;
            this.shown = true;
            let items = document.querySelectorAll('table#files tbody tr td:nth-child(1)');
            items.forEach(element => {
                let a = element.querySelector('a');
                if (statics.typeMap['image'].some(x => a.href.endsWith(x))) {
                    let img = document.createElement('img');
                    img.classList.add('thumb');
                    img.loading = 'lazy';
                    img.src = a.href;
                    element.prepend(img);
                }
            });
        }
    }
    window.addEventListener('DOMContentLoaded', () => window.thumbs_manager = new ThumbsManager());
// </script>

[upload]
{.add header|Cache-Control: no-cache, max-age=0.}
{.get-common-html|
    <title>{.!Upload.}</title>
|
    <section class="linebottom" style="text-align: left;">
        <a href="./">⇦ {.!Back.}</a>
        {.if|{.can mkdir.}|
            <a id="newfolder" class="invert" style="float: right;" href="javascript:">📁 {.!New Folder.}</a>
        .}
    </section>
    <section>
        <p>{.!Upload to:.}%folder%</p>
        <p>{.!Free space left:.}%diskfree%B</p>
        <form id="uploadform" action="./" target="_parent" method="POST" enctype="multipart/form-data">
            <p data-upload="inputs"><input type="file" name="0" multiple /><br /></p>
            <a class="invert" href="javascript:" data-upload="add">{.!Add.}</a>
            <input type="submit" value="{.!Upload.}" />
        </form>
    </section>
    <script>
        class Uploader {
            constructor() {
                this.count = 1;
                document.getElementById('newfolder').addEventListener('click', this.createfolder.bind(this));
                document.getElementById('uploadform').querySelectorAll('*[data-upload]').forEach(element => {
                    switch (element.getAttribute('data-upload')) {
                        case 'inputs':
                            this.inputs = element;
                            break;
                        case 'add':
                            element.addEventListener('click', this.add.bind(this));
                            break;
                    }
                });
            }
            add() {
                let input = document.createElement('input');
                input.type = 'file';
                input.multiple = 'multiple';
                input.name = this.count++;
                this.inputs.appendChild(input);
                let br = document.createElement('br');
                this.inputs.appendChild(br);
            }
            createfolder() {
                dialog.prompt('{.!Input folder name.}', i => {
                    let xhr = new XMLHttpRequest();
                    xhr.open('POST', './?mode=section&id=ajax.mkdir');
					xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
                    xhr.onload = () => {
                        let message = xhr.responseText.trim();
                        switch (message) {
                            case 'Bad Token':
                                dialog.alert('{.!Bad session. Please try again..}', () => location.href = '.');
                                break;
                            case 'Forbidden':
                                dialog.alert('{.!Illegal action.}');
                                break;
                            case 'Duplicate':
                                dialog.alert('{.!Folder already exists.}');
                                break;
                            case 'OK':
                                dialog.alert('{.!Done..}', () => location.href = './');
                                break;
                            default:
                                dialog.alert(`{.!Error:.}${message}`);
                                break;
                        }
                    }
                    xhr.send(`name=${i}&token=${HFS.sid}`);
                });
            }
        }
        window.addEventListener('DOMContentLoaded', event => window.uploader = new Uploader());
    </script>
.}

[upload-results]
{.add header|Cache-Control: no-cache, max-age=0.}
{.get-common-html|
    <title>{.!Upload Result.}</title>
    <style>
        body {
            text-align: left;
        }
        .success {
            color: #66ff66;
        }
        .failed {
            color: #ff6666;
        }
    </style>
|
    <section class="linebottom">
        <a href="./">⇦ {.!Back.}</a>
    </section>
    <h1>{.!Upload Result.}</h1>
    <p>%uploaded-files%</p>
    <script>
        window.addEventListener('DOMContentLoaded', event => {
            if (document.querySelector('.failed') != null) {
                dialog.alert('{.!There are some files failed to upload..}');
            } else {
                dialog.alert('{.!All files are uploaded successfully.}', () => location.href = './');
            }
        });
    </script>
.}

[upload-success]
<b class="success">{.!Success.}</b>: %item-name% - %item-size%B - %speed% KB/s<br />

[upload-failed]
<b class="failed">{.!FAILED.}</b>: %item-name% - %reason%<br />

{.comment|
    IMPORTANT:
        Through these macros are from original template,
        they are heavily modified, and maybe cannot fit your need.
        Please check how macros exactly work if going to adapt.
.}

[+special:alias]
check session=if|{.{.cookie|HFS_SID_.} != {.postvar|token.}.}|{:{.cookie|HFS_SID_|value=|expires=-1.} {.break|result=Bad Session.}:}
can mkdir=and|{.get|can upload.}|{.!option.newfolder.}
can comment=and|{.get|can upload.}|{.!option.comment.}
can rename=and|{.get|can delete.}|{.!option.rename.}
can change pwd=member of|can change password
can move=or|1|1
escape attr=replace|"|"|$1
commentNL=if|{.pos|<br|$1.}|$1|{.replace|{.chr|10.}|<br />|$1.}
add bytes=switch|{.cut|-1||$1.}|,|0,1,2,3,4,5,6,7,8,9|$1 Bytes|K,M,G,T|$1Bytes

[ajax.mkdir|no log|public]
{.check session.}
{.set|x|{.postvar|name.}.}
{.break|if={.pos|\|var=x.}{.pos|/|var=x.}|result=Forbidden.}
{.break|if={.not|{.can mkdir.}.}|result=Forbidden.}
{.set|x|{.force ansi|%folder%{.^x.}.}.}
{.break|if={.exists|{.^x.}.}|result=Duplicate.}
{.break|if={.not|{.length|{.mkdir|{.^x.}.}.}.}|result=Forbidden.}
{.add to log|> .. {.!User.} %user% {.!created folder.} "{.^x.}".}
{.pipe|OK.}

[ajax.rename|no log|public]
{.check session.}
{.break|if={.not|{.can rename.}.}|result=Forbidden.}
{.break|if={.is file protected|{.postvar|from.}.}|result=Forbidden.}
{.break|if={.is file protected|{.postvar|to.}.}|result=Forbidden.}
{.set|x|{.force ansi|{.postvar|from.}.}.}
{.set|y|{.force ansi|%folder%{.postvar|to.}.}.}
{.break|if={.not|{.exists|{.^x.}.}.}|result=Not Found.}
{.break|if={.exists|{.^y.}.}|result=Duplicate.}
{.break|if={.not|{.length|{.rename|{.^x.}|{.^y.}.}.}.}|result=Failed.}
{.add to log|> .. {.!User.} %user% {.!renamed.} "{.^x.}" {.!to.} "{.^y.}".}
{.pipe|OK.}

[ajax.move|no log|public]
{.check session.}
{.set|to|{.force ansi|{.postvar|to.}.}.}
{.break|if={.not|{.and|{.can move.}|{.get|can delete.}|{.get|can upload|path={.^to.}.}/and.}.} |result=Forbidden.}
{.set|log|> .. {.!Moving items to.} {.^to.}.}
{.for each|filename|{.replace|:|{.no pipe||.}|{.force ansi|{.postvar|from.}.}.}|{:
	{.break|if={.is file protected|var=filename.}|result=Forbidden.}
	{.set|x|{.force ansi|{.postvar|path.}.}{.^filename.}.}
	{.set|y|{.force ansi|{.postvar|path.}.}{.^to.}/{.^filename.}.}
	{.if not |{.exists|{.^x.}.}|{:{.^x.}: {.!Not found.}:}|{:
		{.if|{.exists|{.^y.}.}|{:{.^y.}: {.!Duplicate.}:}|{:
			{.set|comment| {.get item|{.^x.}|comment.} .}
			{.set item|{.^x.}|comment=.} {.comment| this must be done before moving, or it will fail.}
			{.if|{.length|{.move|{.^x.}|{.^y.}.}.} |{:
				{.move|{.^x.}.md5|{.^y.}.md5.}
				{.set|log|{.chr|13.}> .. {.^filename.} -> {.^y.}|mode=append.}
				{.set item|{.^y.}|comment={.^comment.}.}
			:} | {:
				{.set|log|{.chr|13.}> !! {.^filename.}: {.!Move failed.}|mode=append.}
				{.maybe utf8|{.^filename.}.}: {.!Not moved.}
			:}/if.}
		:}/if.}
	:}.}
	{.chr|13.}
:}.}
{.add to log|{.^log.}.}

[ajax.comment|no log|public]
{.check session.}
{.break|if={.not|{.can comment.}.} |result=Forbidden.}
{.for each|filename|{.replace|:|{.no pipe||.}|{.postvar|files.}.}|{:
	 {.break|if={.is file protected|var=filename.}|result=Forbidden.}
	 {.set item|{.force ansi|{.^filename.}.}|comment={.encode html|{.force ansi|{.postvar|text.}.}.}.}
:}.}
{.pipe|OK.}

[ajax.changepwd|public|no log]
{.check session.}
{.break|if={.not|{.can change pwd.}.} |result=Forbidden.}
{.if|{.=|{.sha256|{.get account||password.}.}|{.force ansi|{.postvar|old.}.}.}|
	{:{.if|{.length|{.set account||password={.force ansi|{.base64decode|{.postvar|new.}.}.}.}/length.}|OK|Failed.}:}|
	{:Unauthorized:}
.}


[login|public]
{.add header|Cache-Control: no-cache, max-age=0.}
{.get-common-html|
    {.if|%user%|
    <title>{.!Manage Account.}</title>
    |
    <title>{.!Login.}</title>
    .}
|
    {.if|%user%|
    <section>
        <h1>{.!Manage Account.}</h1>
        <noscript>
            <p>{.!Javascript required.}</p>
        </noscript>
        <p>
            <span>%user%</span><br />
            <a id="logout" class="invert" href="javascript:">{.!Logout.}</a>
        </p>
        <form id="changepwd">
            <p>{.!Change password.}</p>
            <input type="password" name="old" placeholder="{.!Old password.}" /><br />
            <input type="password" name="new" placeholder="{.!New password.}" /><br />
            <input type="password" name="verify" placeholder="{.!Enter again.}" /><br />
            <input type="submit" value="{.!OK.}" />
        </form>
        <script src='/~sha256.js'></script>
        <script>
            class AccountManager {
                constructor() {
                    this.formChangepwd = document.getElementById('changepwd');
                    this.passwords = this.formChangepwd.querySelectorAll('input[type="password"]');
                    this.formChangepwd.addEventListener('submit', event => {
                        event.preventDefault();
                        if (this.passwords[1].value != this.passwords[2].value) {
                            dialog.alert('{.!New password not match.}');
                            this.passwords[1].value = '';
                            this.passwords[2].value = '';
                            return
                        }
                        let xhr = new XMLHttpRequest();
                        xhr.open('POST', './?mode=section&id=ajax.changepwd');
		                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                        xhr.onload = () => {
                            let message = xhr.responseText.trim();
                            switch (message) {
                                case 'OK':
                                    dialog.alert('{.!Success.}', () => location.href = location.hash.slice(1));
                                    if (localStorage.getItem('password') != null) {
                                        localStorage.setItem('password', btoa(this.passwords[1].value));
                                    }
                                    break;
                                case 'Forbidden':
                                case 'Failed':
                                    dialog.alert('{.!Failed.}', () => location.href = location.hash.slice(1));
                                    break;
                                case 'Unauthorized':
                                    dialog.alert('{.!Old password is incorrect.}');
                                    this.passwords[0].value = '';
                                    break;
                            }
                        }
                        xhr.send(`token=${HFS.sid}&old=${SHA256.hash(this.passwords[0].value)}&new=${btoa(unescape(encodeURIComponent(this.passwords[1].value)))}`);
                    });
                    document.getElementById('logout').addEventListener('click', event => {
                        fetch('/?mode=logout').then(r => location.href = location.hash.slice(1));
                    });
                }
            }
            window.addEventListener('DOMContentLoaded', () => window.account_manager = new AccountManager());
        </script>
    </section>
    |
    <section>
        <h1>Login</h1>
        <noscript>
            <p>{.!Javascript required.}</p>
        </noscript>
        <form>
            <input type="text" name="username" placeholder="{.!Username.}" /><br />
            <input type="password" name="password" placeholder="{.!Password.}" /><br />
            <label><input type="checkbox" name="remember" /> {.!Remember credentials.}</label>
            <input type="submit" value="{.!Login.}" />
        </form>
        <script src='/~sha256.js'></script>
        <script>
            class LoginManager {
                constructor() {
                    this.inputUsername = document.querySelector('input[name="username"]');
                    this.inputPassword = document.querySelector('input[name="password"]');
                    this.inputRemember = document.querySelector('input[name="remember"]');
                    this.form = document.querySelector('form');
                    this.form.addEventListener('submit', event => {
                        event.preventDefault();
                        this.login.bind(this)();
                    });
                    if (localStorage.getItem('username') != null && localStorage.getItem('password') != null) {
                        this.inputRemember.checked = true;
                        this.inputUsername.value = localStorage.getItem('username');
                        this.inputPassword.value = atob(localStorage.getItem('password'));
                    }
                }
                login() {
                    let username = this.inputUsername.value;
                    let password = this.inputPassword.value;
                    let token = HFS.sid;
                    let xhr = new XMLHttpRequest();
                    xhr.open('POST', '/?mode=login');
                    let formdata = new FormData();
                    formdata.append('user', username);
                    if (typeof SHA256 == 'undefined') {
                        formdata.append('password', password);
                    } else {
                        let hashed = SHA256.hash(SHA256.hash(password).toLowerCase() + token).toLowerCase();
                        formdata.append('passwordSHA256', hashed);
                    }
                    xhr.onload = () => {
                        let message = xhr.responseText.trim();
                        switch (message) {
                            case 'ok':
                                if (this.inputRemember.checked) {
                                    localStorage.setItem('username', username);
                                    localStorage.setItem('password', btoa(password));
                                } else {
                                    localStorage.removeItem('username');
                                    localStorage.removeItem('password');
                                }
                                dialog.alert('{.!Success.}', () => location.href = location.hash.slice(1));
                                break;
                            case 'bad password':
                                dialog.alert('{.!Incorrect password.}', () => location.reload());
                                this.inputPassword.value = '';
                                break;
                            case 'username not found':
                                dialog.alert('{.!User not found.}');
                                this.inputUsername.value = '';
                                this.inputPassword.value = '';
                                break;
                            default:
                                dialog(`{.!Error:.}${message}`);
                                break;
                        }
                    }
                    xhr.send(formdata);
                }
            }
            window.addEventListener('DOMContentLoaded', () => window.login_manager = new LoginManager());
        </script>
    </section>
    .}
.}


[error-page]
{.add header|Cache-Control: no-cache, max-age=0.}
%content%

[overload]
{.disconnect.}

[max contemp downloads]
{.if|{.match|*.php*;*.js;*.py;*.vbs*;*.exe|%url%.}|{:{.disconnect.}:}.}
{.redirect|/~server-busy-page.html#{.filepath|%url%.}.}

[server-busy-page.html|public]
{.get-common-html|
    <title>{.!Server Busy.}</title>
|
    <section class="linebottom">
        <a href="javascript: location.href = location.hash.slice(1);" class="invert">{.!Retry.}</a>
    </section>
    <h1>{.!Server Busy.}</h1>
    <p>{.!Please try again later..}</p>
.}

[not found]
{.if|{.match|*.php*;*.js;*.py;*.vbs*;*.exe|%url%.}|{:{.disconnect.}:}.}
{.redirect|/~404-page.html.}

[404-page.html|public]
{.get-common-html|
    <title>{.!404: Not Found.}</title>
|
    <section class="linebottom">
        {.if|{.=|{.cut|-1||%url%.}|/.}|
            <a href="../">⇦ {.!Back.}</a>
        |
            <a href="./">⇦ {.!Back.}</a>
        .}
    </section>
    <h1>{.!404: Not Found.}</h1>
    <p>{.!You have found a 404 page..}</p>
    <script>
        setTimeout(() => document.querySelector('a').click(), 3000);
    </script>
.}

[unauth]
{.redirect|/~login.}

[deny]
{.disconnect.}

[ban]
{.disconnect.}


[takeback-general.css|public|no log|cache]
/* <style> /**/
body {
    margin: 0;
    font-family: 'Takeback-Define-Font', 'Monda', sans-serif;
    background-color: black;
    font-size: 1.2em;
    color: white;
    text-align: center;
}
.animator-show { transform: inherit; }
.animator-hide { transform: scaleY(0); }

.background {
    position: fixed;
    top: 0;
    width: 100%;
    height: 100%;
	background: center / cover;
    background-image:
        radial-gradient(white, rgba(255,255,255,.2) 2px, transparent 40px),
        radial-gradient(white, rgba(255,255,255,.15) 1px, transparent 30px),
        radial-gradient(white, rgba(255,255,255,.1) 2px, transparent 40px),
        radial-gradient(white, rgba(255,255,255,.08) 3px, transparent 60px),
        radial-gradient(rgba(255,255,255,.4), rgba(255,255,255,.1) 2px, transparent 30px);
    background-size: 550px 550px, 350px 350px, 250px 250px, 950px 950px, 150px 150px;
    background-position: 0 0, 40px 60px, 130px 270px, 640px 240px, 70px 100px;
    z-index: -2;
}
.background-image {
    position: fixed;
    top: 0;
    width: 100%;
    height: 100%;
	background: center / cover;
    background-image: url('{.!_background_image.}');
    background-size: 550px 550px, 350px 350px, 250px 250px, 950px 950px, 150px 150px;
    background-position: 0 0, 40px 60px, 130px 270px, 640px 240px, 70px 100px;
    z-index: -2;
}
.background-mask {
    position: fixed;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.4);
    z-index: -1;
}
h1 {
    font-size: 1.8em;
}
section#tooltip {
    position: fixed;
    bottom: 3.6em;
    width: 100%;
    min-height: 2em;
    border-top: 1px solid currentColor;
    border-bottom: 1px solid currentColor;
    background-color: rgba(0, 0, 0, 0.8);
}
a:link, a:visited {
    color: white;
    background-color: transparent;
}
a:hover {
    color: #333333;
    background-color: white;
}
a:active {
    color: white;
    background-color: transparent;
    text-shadow: 0 0 4px white;
}
a {
    transition: all 0.3s;
    text-decoration: none;
}
a.invert:link, a.invert:visited {
    color: #333333;
    background-color: white;
}
a.invert:hover {
    color: white;
    background-color: transparent;
    border: 1px solid currentColor;
}
a.invert:active {
    color: white;
    background-color: transparent;
    text-shadow: 0 0 4px white;
}
a.invert {
    transition: all 0.3s;
    text-decoration: none;
    border: 1px solid transparent;
    padding: 0 0.1em;
}
hr, .linebottom {
    margin: 0;
    border-bottom: 1px solid white;
}
#dialog {
    position: fixed;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.8);
    transition: opacity 0.6s;
}
.dialog {
    position: fixed;
    width: 60%;
    left: 20%;
    top: 33%;
    border: 1px solid currentColor;
}
.dialog .prompt-input {
    width: 12em;
    font-size: 1.2em;
    height: 1em;
    border: 1px solid currentColor;
}
@media (max-width: 950px) {
    section#tooltip {
        bottom: unset;
        top: 1.8em;
    }
}
/* </style> */
// </style>

[takeback-filelist.css|public|no log|cache]
/* <style> /**/
.search {
    display: inline;
    white-space: nowrap;
}
.search input[type="search"] {
    width: 16em;
    border-radius: 0;
    border: 1px solid white;
    background-color: white;
    height: 3em;
}
.search input[type="submit"] {
    width: 3em;
    border-radius: 0;
    border: 1px solid white;
    background-color: white;
    height: 3em;
    transition: all 0.3s;
}
.searchbutton:hover {
    background-color: transparent;
}
.part0 h1 {
    font-size: 1.2em;
    font-weight: normal;
    margin: 0;
}
.part0 nav {
    width: 100%;
    text-align: left;
    border-bottom: 1px solid currentColor;
}
.part0 nav .right {
    float: right;
}
@keyframes blinkgreen {
    0% {
        color: green;
    }
    50% {
        color: #66ee66;
    }
    100% {
        color: green;
    }
}
.part0 p {
    margin: 0;
}
.part0 p a span {
    color: green;
    animation: blinkgreen 5s ease-in-out 0s infinite;
}
.part1 {
    width: 100%;
    overflow-x: auto;
}
.part1 table#files {
    min-width: 75%;
    margin: auto;
    white-space: nowrap;
}
.part1 table#files td:nth-child(1) {
    width: 75%;
    text-align: left;
}
.part1 table#files td:nth-child(1) img.thumb {
    height: 8em;
    vertical-align: middle;
}
.part1 table#files td:nth-child(2) {
    width: 15%;
    text-align: center;
}
.part1 table#files td:nth-child(3) {
    width: 10%;
    text-align: right;
}
.part1 table#files thead td:nth-child(3) {
    text-align: center;
}
.part1 table#files thead td {
    background-color: white;
    color: #333333;
    font-weight: bold;
}
.part1 table#files thead td a:hover {
    color: #333333;
}
.part1 table#files tbody tr {
    outline: 1px solid transparent;
    transition: all 0.3s;
}
.part1 table#files tbody tr p {
    margin: 0;
    margin-left: 1em;
    border-left: 1px solid white;
    padding-left: 1em;
}
.part1 table#files tbody tr:hover {
    outline: 1px solid currentColor;
}
.part1 table#files tbody tr.selected {
    outline: 1px solid yellow;
}
.part1 table#files .folder td:nth-child(3),
.part1 table#files .link td:nth-child(3) {
    color: gray;
    font-style: italic;
    text-align: center;
}
.part1 table#files tr td {
	height: 32px;
}
.part2 .blank {
    height: 20em;
}
.part3 .left, .part3 .right {
    position: fixed;
    bottom: 0em;
    display: inline-block;
}
.part3 .left #audioplayer, .part3 .right #preview {
    background-color: rgba(0, 0, 0, 0.8);
}
.part3 .left {
    left: 0;
    text-align: left;
}
.part3 .right {
    right: 0;
    min-width: 24em;
}
.part3 .right #preview .close {
    float: right;
}
.part3 .right #preview .close span {
    color: #ff6666;
}
.part3 .right #preview .title {
    text-align: left;
}
.part3 .right #preview video, .part3 .right #preview img {
    max-height: 16em;
}
.part3 .right #preview iframe {
    width: 24em;
    height: 16em;
    border: none;
    background-color: white;
}
.part3 .right #preview .nopreview {
    color: yellow;
}
.part3 .right #preview a span.menuitem {
    color: rgb(255, 160, 96);
    text-decoration: underline;
    font-size: 0.9em;
}
.part3 .right #preview a.download span {
    color: cyan;
}
.slideshow {
    position: fixed;
    top: 0;
    width: 100%;
    height: 100%;
    text-align: center;
    background-color: black;
}
.slideshow img {
    height: 100%;
    display: block;
    transition: all 1s;
    position: absolute;
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
.arrow {
    position: relative;
    animation: swing 1s ease-in-out 0s infinite;
}
.arrow::after {
    content: '>>';
    font-style: italic;
}

@media (max-width: 950px) {
    .part3 .left {
        bottom: 3.6em;
        overflow-x: visible;
        white-space: nowrap;
    }
    .part3 .right {
        min-width: unset;
        width: 100%;
    }
}

/* Folder */
table#files a[href$="/"]::before {
	content: "📁";
	color: #FB0;
	display: inline-block;
	position: relative;
	width: 1.75em;
	text-align: center;
}

/* Unknown File */
td a::before {
	content: "\1f4c4";
	color: #BCC;
	display: inline-block;
	position: relative;
	width: 1.75em;
	text-align: center;
}

/* Other */
td a[href$=";"]::before,    /* javascript: ...; */
td a[href$=":"]::before,    /* javascript: */
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
	content: "\1f4f7";
	color: black
}

/* Working Picture (Photoshop & GIMP) */
a[href$=".psd"]::before,
a[href$=".xcf"]::before {
	content: "📸";
	color: #5AE
}

/* Audio/Music */
a[href$=".mp3"]::before,
a[href$=".MP3"]::before,
a[href$=".aac"]::before,
a[href$=".m4a"]::before,
a[href$=".wav"]::before,
a[href$=".ogg"]::before {
	content: "\1f50a\FE0E";
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
	content: "\1f4fa";
	color: teal
}

/* Compressed/Storage Pack */
a[href$=".tar"]::before,
a[href$=".gz"]::before,
a[href$=".xz"]::before,
a[href$=".rar"]::before,
a[href$=".7z"]::before,
a[href$=".zip"]::before {
	content: "\1f381";
	color: brown
}

/* Installation Pack */
a[href$=".msi"]::before,
a[href$=".tar.gz"]::before,
a[href$=".deb"]::before,
a[href$=".rpm"]::before {
	content: "📦";
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
	content: "\1f537";
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
	content: "⌨";
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
	content: "📝";
	color: gray;
}

/* E-Books */
a[href$=".epub"]::before,
a[href$=".PDF"]::before,
a[href$=".pdf"]::before {
	content: "📕";
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
	content: "📑";
	color: thistle;
}

/* Flash */
a[href$=".swf"]::before {
	content: "⚡";
	color: gold;
}

/* Icon */
a[href$=".ICO"]::before,
a[href$=".ico"]::before {
	content: "🥚";
	color: wheat;
}

/* (Data) Image */
a[href$=".iso"]::before,
a[href$=".img"]::before,    /* '.img' is a floppy💾 image💿 */
a[href$=".dda"]::before {
	content: "💿";
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
table#files a[href^="https://"]::before {
	content: "🌎";
	color: #5AE
}

@media (min-width:950px) {
    ::-webkit-scrollbar {
        width: 10px;
        height: 10px;
        background-color: transparent;
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
        box-shadow: inset 1px 0 0 rgba(0,0,0,.14), inset -1px -1px 0 rgba(0,0,0,.07);
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

[monda-font.css|public|no log|cache]
{.add header|Cache-Control: public, max-age=31536000.}
/* <style> /* */
@font-face { font-family: 'Monda';
	src: url('data:application/x-font-ttf;base64,AAEAAAASAQAABAAgRkZUTWXx2TAAAKE8AAAAHEdERUYDnAVLAAChWAAAADRHUE9TRrZNAwAAoYwAAAhkR1NVQoUFkl0AAKnwAAAAZE9TLzK8NmN8AAABqAAAAFZjbWFwf0tdrAAACNQAAAO2Y3Z0ICj/AGAAABasAAAAOGZwZ20x/KCVAAAMjAAACZZnYXNwAAAAEAAAoTQAAAAIZ2x5ZsqTYEcAABpQAAB/5GhlYWQCjGS+AAABLAAAADZoaGVhE/sJFAAAAWQAAAAkaG10eB3Q/fkAAAIAAAAG1GxvY2HUZ/WcAAAW5AAAA2xtYXhwAugKZwAAAYgAAAAgbmFtZc8OhBwAAJo0AAAG3nBvc3QAAwAAAAChFAAAACBwcmVwFQScMAAAFiQAAACFAAEAAAABAADbbxJ5Xw889QAJCAAAAAAAzNqNfQAAAADM3oz+/zL9DAqECDoAAAAIAAIAAAAAAAAAAQAACZ38lQAAC0b/1/+DCoQAAQAAAAAAAAAAAAAAAAAAAbUAAQAAAbUAWQAHAEAABAACACYANABsAAAAkgmWAAMAAgABA80BkAAFAAAFMwWZAAABHgUzBZkAAAPXAGYCEgAAAgAFAwAAAAAAAKAAAO9AACBLAAAAAAAAAABuZXd0AEAAIPsECZ38lQAACZ0DawAAAJMAAAAAAAAC7ABEAAAAAAKqAAACAAAAAwABGAN6ALAFBABWBRcAkAgAAKwF3ACwA4AAswMAAKwDAAB8BAAAYwQAAKICgQDABAAAogJ0ALoDAABABOIAhATiAM4E4gCkBOIA0ATiAI8E4gCtBOIAsgTiAL0E4gCEBOIAlwMAAQADAAD4BOIAnATiAOAE4gDQBNgAswgAAWoFlABWBYwA2gWwALYF8gDaBOcA2gSHANoGFAC6BfgA1ARsAL4EtgBmBYoA2gR5ANoG8gDaBjoA2gYKALoFLgDaBgYAugW4ANoFGACQBLQAVAYCAMgFagBWCAAAcAU4AF4FJgAwBNoAtAMAAQADAABAAwAAwwTpAJoDoQAOAmgAcwSUAIQEtAC6BFYAlASwAJQEhgCUAxYAbgSiAJQEygC6AlQAzgJaAA0EgAC6ArgAvgdEALoEygC6BJYAlASuALoEsACUAxoAugPgAI4DSABQBMgAsARQAEAGTgA0BCAAQAReAEwDxACMA7gAngKyAQADuACAA3EAQAIAAAADAAEYBFYAlAT5AKYEfQB0BSYAMAKiAP4D6gCQBAEAngb4AJwEFQC6BB4AYANgAGIEAACiBvgAnAIBACAEDADCBBEAzwQcAL4ElQDIAmgAhQEzAAAE4gCoAZwAbAIAAHgEGgDPA/8AmwQeAH4H/wCkB/8ApAf/AMcE2ACTBZQAVgWUAFYFlABWBZQAVgWUAFYFlABWBpYAYgWwALYE5wDaBOcA2gTnANoE5wDaBGwAvgRsAL4EbAC+BGwAvgS/AEwGOgDaBgoAugYKALoGCgC6BgoAugYKALoDzQCBBgoAugYCAMgGAgDIBgIAyAYCAMgFJgAwBSgA1AUBAL4ElACEBJQAhASUAIQElACEBJQAhASUAIQGzQCDBFYAlASGAJQEhgCUBIYAlASGAJQCVP/2AlQAzgJUAA4CVP/KBIYAlgTKALoElgCUBJYAlASWAJQElgCUBJYAlAQBAGQElgCUBMgAsATIALAEyACwBMgAsAReAEwEqgCxBF4ATAWUAFYElACEBZQAVgSUAIQFlABWBJQAhAWwALYEVgCUBbAAtgRWAJQFsAC2BFYAlAWwALYEVgCUBfIA2gSwAJQEvwBMBLAAlATnANoEhgCUBOcA2gSGAJQE5wDaBIYAlATnANoEhgCUBOcA2gSGAJQGFAC6BKIAlAYUALoEogCUBhQAugSiAJQGFAC6BKIAlAX4ANQEygC6BgAAkATIAB0EbAC+AlQAAwRsAL4CVABkBGwAvgJUAEoEbAC+AlQAewRsAL4CVADOCSIAvgSuAM4EtgBmAloACgWKANoEgAC6BHwAugR5ANoCuAC+BHkA2gK4AL4EeQDaArgAvgR5ANoEVAC+BHkANALEADQGOgDaBMoAugY6ANoEygC6BjoA2gTKALoEygC6Bi4A1ATKALoGCgC6BJYAlAYKALoElgCUBgoAugSWAJQGFQC3BsYAlgW4ANoDGgC6BbgA2gMaALoFuADaAxoAsgUYAJAD4ACOBRgAkAPgAI4FGACQA+AAjgUYAJAD4ACOBLQAVANIAFAEtABUA0gAUAS0AFQDSAA6BgIAyATIALAGAgDIBMgAsAYCAMgEyACwBgIAyATIALAGAgDIBMgAsAYCAMgEyACwCAAAcAZOADQFJgAwBF4ATAUmADAE2gC0A8QAjATaALQDxACMBNoAtAPEAIwDegCN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AAIBQAACAgxBAAAAAVAAAQENAUIREhADESslIQEBIQEzAaYCT/7aAgb76gGysY8EHftUBaYAAAD//wDaAAAFDActECcBdgHuAWITBgAlAAAACbEAAbgBYrApKwD//wC6/+oEIAdTECcBdgGaAYgTBgBFAAAACbEAAbgBiLApKwD//wDaAAAFPActECcBdgI4AWITBgAnAAAACbEAAbgBYrApKwD//wCU/+oD9gdTECcBdgFyAYgTBgBHAAAACbEAAbgBiLApKwD//wDaAAAEDwctECcBdgGiAWITBgApAAAACbEAAbgBYrApKwD//wBuAAAC6AdTECcBdgEKAYgTBgBJAAAACbEAAbgBiLApKwD//wDaAAAGGActECcBdgKmAWITBgAwAAAACbEAAbgBYrApKwD//wC6AAAGlAWpECcBdgLU/94TBgBQAAAACbEAAbj/3rApKwD//wDaAAAErgctECcBdgHyAWITBgAzAAAACbEAAbgBYrApKwD//wC6/mgEGgWpECcBdgGY/94TBgBTAAAACbEAAbj/3rApKwD//wCQ/+oEjActECcBdgG8AWITBgA2AAAACbEAAbgBYrApKwD//wCO/+oDbAWpECcBdgEq/94TBgBWAAAACbEAAbj/3rApKwD//wBUAAAEYActECcBdgGIAWITBgA3AAAACbEAAbgBYrApKwD//wBQ//gC1AbdECcBdgDAARITBgBXAAAACbEAAbgBErApKwD//wBwAAAHkAe0ECcAQwJXAdITBgA6AAAACbEAAbgB0rApKwD//wA0AAAGGgYwECcAQwF+AE4TBgBaAAAACLEAAbBOsCkrAAD//wBwAAAHkAe0ECcAdgNGAdITBgA6AAAACbEAAbgB0rApKwD//wA0AAAGGgYwECcAdgJtAE4TBgBaAAAACLEAAbBOsCkrAAD//wBwAAAHkAcUECcAagIAAW4TBgA6AAAACbEAArgBbrApKwD//wA0AAAGGgWQECcAagEm/+oTBgBaAAAACbEAArj/6rApKwD//wAwAAAE9ge0ECcAQwDqAdITBgA8AAAACbEAAbgB0rApKwD//wBM/moEJAYwECcAQwCPAE4TBgBcAAAACLEAAbBOsCkrAAAAAQACAl4CFwLcAAMAHUAaAAABAQBLAAAAAU8CAQEAAUMAAAADAAMRAw8rEzUhFQICFQJefn4AAAABAAIBkgRKAiQAAwAdQBoAAAEBAEsAAAABTwIBAQABQwAAAAMAAxEDDysTNSEVAgRIAZKSkgAA//8BAAOBAgEFvBEPAA8CwQRqwAAACbEAAbgEarApKwD//wEAA4ECAQW8EQcADwBABNMACbEAAbgE07ApKwAAAP//AQD+rgIBAOkQBgAPQAD//wEAA4EDnQW8EC8ADwLBBGrAABEPAA8EXQRqwAAAErEAAbgEarApK7EBAbgEarApKwAA//8BAAOBA50FvBAnAA8AQATTEQcADwHcBNMAErEAAbgE07ApK7EBAbgE07ApKwAA//8BAP6uA50A6RAnAA8B3AAAEAYAD0AAAAEAWAAAAyIFpgALAChAJQACAgxBBAEAAAFPAwEBAQ9BBgEFBQ0FQgAAAAsACxERERERBxMrIREhNSERMxEhFSERAVz+/AEEvAEK/vYDo4EBgv5+gfxdAAABAHAAAAM6BaYAEwA2QDMHAQEIAQAJAQBXAAQEDEEGAQICA08FAQMDD0EKAQkJDQlCAAAAEwATERERERERERERCxcrIREhNSERITUhETMRIRUhESEVIREBdP78AQT+/AEEvAEK/vYBCv72AZmBAYmBAYL+foH+d4H+ZwAAAQC0ASoDGwOFAAcAF0AUAAEAAAFNAAEBAFEAAAEARRMRAhArAAYgJhA2IBYDG5D+t46PAUmPAcCWlQEwlpYA//8AugAABqIA8hAnABEE6AAAECcAEQJ0AAAQBgARAAAABwDR/+0KhAW1ABAAHAAsADgASABUAFgBDEuwGlBYQCkLBw4DAAkFAgIEAAJZAAEBA1EMAQMDFEEQCA8DBAQGURENCgMGBhUGQhtLsCFQWEAtCwcOAwAJBQICBAACWQABAQNRDAEDAxRBEQENDQ1BEAgPAwQEBlEKAQYGFQZCG0uwMVBYQDELBw4DAAkFAgIEAAJZAAwMDEEAAQEDUQADAxRBEQENDQ1BEAgPAwQEBlEKAQYGFQZCG0A3CwEHCQEFAgcFWQ4BAAACBAACWQAMDAxBAAEBA1EAAwMUQREBDQ0NQRAIDwMEBAZRCgEGBhUGQllZWUAuVVU6OR4dAQBVWFVYV1ZRUEtKQUA5SDpINTQvLiUkHSweLBkYExIJBwAQARASDisBMjc2NTU0JiMmBwYGFRUUFiQGICY1NTQ2IBYXFQEyNzY1NTQmIgcGBhUVFBYkBiAmNTU0NiAWFxUBMjc2JzU0JiIHBgYVFRQWJAYgJjU1NDYgFhcVAQEzAQH7cRwQTT09HTcdTQF8iv65h4UBToMCAyJxHBBNeh03HU0BfIr+uYeFAU6DAgHdchwQAU16HTcdTQF8iv65h4UBToMC+D0CH5X95gMGYzZdXZRUAQwWbVhflmBPw8O4Nbq5vrQ2/FRjNl1dlFQMFmxYX5ZgT8PDuDW6ub60Nv75YzZdXZRUDBZsWF+WYE/Dw7g1urm+tDb+mAWm+loAAQCuAFACUgPUAAUABrMCAAEmKyUBARcDEwHG/ugBEZPPz1ABwgHCRv6E/oQAAAAAAQC0AFACWAPUAAUABrMEAAEmKyUnEwM3AQFHk8/PjAEYUEYBfAF8Rv4+AAABABAAAALwBeIAAwAYQBUAAAAOQQIBAQENAUIAAAADAAMRAw8rMwEzARACKbf92wXi+h4AAQD/AmYDsgXiAA4AL0AsAwECAwFABAECBQEABgIAWAADBwEGAwZTAAEBDgFCAAAADgAOERERERIRCBQrATUhNQEzASE1MxUzFSMVArH+TgFnjf6kARpxkJACZs9cAlH9ruvrW88AAAABAAH/6gUUBbwANACKthMSAgMFAUBLsAlQWEAwAAsACgoLXgYBAwcBAgEDAlcIAQEJAQALAQBXAAUFBFEABAQUQQAKCgxSAAwMFQxCG0AxAAsACgALCmYGAQMHAQIBAwJXCAEBCQEACwEAVwAFBQRRAAQEFEEACgoMUgAMDBUMQllAEzQyLy4pKCUkEREWGRMRERETDRcrJCY1NSM1MzUjNTMSNzYgFhcWFQc0LgIiBwYHBhUVIRUhFSEVIRUUFiA3Njc2NTMUBwYhIAEMVrW1tbUDoYsCE/AeDr8yMXDuREQwXAFn/pkBZ/6ZugGXODgNB78/dP67/u9t3ZwThrSGATJwYZOdRmERkmcsIRAPJUe+GIa0hjK8fzAwXDJG2likAAAAAgCFAv4GSQWmAAwAFAAItRANAQACJisBETMTEzMRIxEDIwMRIREjNSEVIxEDTca4usR/rKGz/Y/UAi/UAv4CqP5jAZ39WAIz/nIBjv3NAjZycv3KAAAAAAIAUgFeA/4F4QAFAAgACLUIBgIAAiYrEzUBMwEVJSEBUgGOqgF0/QkCR/7pAV58BAf7+XyQA0kABACg//IGYAWwAAoAEgAeACsADUAKJiAaFBALAQAEJisBESEgFxUUBiMjEREzMjc1NCMjAAQgJBIQAiQgBAIQAAQgJAIQEiQgBBIQAgKUAUIBAQZ7mbK6hgJ/w/6XASEBZwEgoKD+4P6Z/t+hBB7+7/6a/q/DwwFRAZkBUsFyAT8DQvUOcYH+swGnhxih/NOnpwEkAWkBJKen/tz+mP5FccABUgGbAVHAwP6v/pj+7wABAI4BtwMBAmEAAwAGswEAASYrEzUhFY4CcwG3qqoA//8AQAAAAsAF4hAGABIAAAABAGwE/QE5BcsAAwAGswEAASYrEzUzFWzNBP3OzgAAAAMAQAHlBjIEhgALAC0AOQAKtzQuHQ0GAAMmKwEyNjc3JiYjIgYUFgI2MzIWFxc3Njc2MzIWFhQGBiMiJyYnJwYHBiMiJyY1NDcFIgYHBxYWMzI2NCYBeCGqRUVrySFKUlJ9dz5w9kkdIKKYRDFhjkJCjmF94jQeHrCdQjJhR4lMBGEhq0VFW9ohSlJSAmhqNjVPd3qoeQHlOZA6Fxh7Nhhkl66VY6IlGhqgQBsyYL+EYxplMjJJiXmoegAAAQCN/oQCxgW8ABYABrMKAAEmKxMiJzUWMzInETQ2MzIXFSYjIgYVERQG+zY4ETh4AXiZLzkMIlU6e/6EB3wCfAUGpo8GfAFZRfsAkocAAAACAEACewMxBLQAEQAjAAi1GRIHAAImKwAWMzI1MxQGIyInJiMiFSM0NhIWMzI1MxQGIyInJiMiFSM0NgFvziVuYXpYV6Y2HW5herXOJW5helhXpjYdbmF6A4J1Z3eCWB1nd4IBMnVnd4JYHWd3ggD//wDgAAAEAgXiECcBoADyAAAQBgAgAAD//wCO/wQEEwR4ECYAHwAAEQcAQgCA/2wACbEBAbj/bLApKwD//wCs/w4ERgR4ECYAIQAAEQcAQgCe/3YACbEBAbj/drApKwAAAgB0AAAD3AWmAAUACQAItQgGAgACJishAQEzAQEnEwMBAeD+lAFsqgFS/q5T9/f+8ALVAtH9L/0roAI1Aif92QAAAAABAG4AAAXYBeEAIQA6QDcIAQUFBFEHAQQEDkEKAgIAAANPCQYCAwMPQQwLAgEBDQFCAAAAIQAhIB8eHSEjEiEjEREREQ0XKyERIREjESM1MzU0NjMzFyMiFRUhNTQ2MzMXIyIVFSEVIREED/3MvLGxoaV3DHSZAjShpXcMdJkBAf7/A5b8agOWjqGTiYWFs6GTiYWFs478agAAAAACAG4AAASgBeEAAwAYAElARgAFBQRRAAQEDkEKAQEBAE8AAAAMQQgBAgIDTwYBAwMPQQsJAgcHDQdCBAQAAAQYBBgXFhUUExIQDg0LCAcGBQADAAMRDA8rATUzFQERIzUzNTQ2MzMXIyIVFSERIxEhEQPkvPx/sbGhpXcMdJkCxbz99wTjw8P7HQOWjqKTiIWEtPvcA5b8agAAAAABAG7/+AV0BeEAHgA+QDsAAQEHUQAHBw5BBQEDAwJPBgECAg9BAAgIAFEECQIAAA0AQgEAHRsYFhMSERAPDg0MCwoIBgAeAR4KDisFIiYnJjURISIVFSEVIREjESM1MzU0NjMhERQWMzMHBShddi1U/qCZAQH+/7yxsaGlAitMdyEWCBwnSeID9oWzjvxqA5aOoZOJ+4OATp4AAAACAG4AAAe2BeEAAwAnAFhAVQoBBwcGUQkBBgYOQQ8BAQEATwAAAAxBDQQCAgIFTwsIAgUFD0EQDgwDAwMNA0IEBAAABCcEJyYlJCMiIR8dHBoXFhQSEQ8MCwoJCAcGBQADAAMREQ8rATUzFQERIREjESM1MzU0NjMzFyMiFRUhNTQ2MzMXIyIVFSERIxEhEQb6vPx//aa8sbGhpXcMdJkCWqGldwx0mQLFvP33BOPDw/sdA5b8agOWjqGTiYWFs6GTiYWFs/vcA5b8agABAG7/+AhXBeEALQBNQEoKAQEBCVEMAQkJDkEHBQIDAwJPCwgCAgIPQQANDQBPBgQOAwAADQBCAQAsKiclIiEfHRwaFxYVFBMSERAPDg0MCwoIBgAtAS0PDisFIiYnJjURISIVFSEVIREjESERIxEjNTM1NDYzMxcjIhUVITU0NjMhERQWMzMHCAtddi1U/qCZAQH+/7z92byxsaGldwx0mQInoaUCK0x3IRYIHCdJ4gP2hbOO/GoDlvxqA5aOoZOJhYWzoZOJ+4OATp4AAAAAAAAgAYYAAQAAAAAAAABdAAAAAQAAAAAAAQAFAF0AAQAAAAAAAgAHAGIAAQAAAAAAAwANAGkAAQAAAAAABAANAGkAAQAAAAAABQBLAHYAAQAAAAAABgANAMEAAQAAAAAABwAlAM4AAQAAAAAACAAMAPMAAQAAAAAACQAMAPMAAQAAAAAACwAfAP8AAQAAAAAADAAfAP8AAQAAAAAADQCQAR4AAQAAAAAADgAaAa4AAQAAAAAAEAAFAF0AAQAAAAAAEQAHAGIAAwABBAkAAAC6AcgAAwABBAkAAQAKAoIAAwABBAkAAgAOAowAAwABBAkAAwAaApoAAwABBAkABAAaApoAAwABBAkABQCWArQAAwABBAkABgAaA0oAAwABBAkABwBKA2QAAwABBAkACAAYA64AAwABBAkACQAYA64AAwABBAkACwA+A8YAAwABBAkADAA+A8YAAwABBAkADQEgBAQAAwABBAkADgA0BSQAAwABBAkAEAAKAoIAAwABBAkAEQAOAoxDb3B5cmlnaHQgKGMpIDIwMTIsIHZlcm5vbiBhZGFtcyAodmVybkBuZXd0eXBvZ3JhcGh5LmNvLnVrKSwgd2l0aCBSZXNlcnZlZCBGb250IE5hbWVzICdNb25kYSdNb25kYVJlZ3VsYXJNb25kYSBSZWd1bGFyVmVyc2lvbiAxIDsgdHRmYXV0b2hpbnQgKHYwLjkzLjgtNjY5ZikgLWwgOCAtciA1MCAtRyAyMDAgLXggMCAtdyAiZ0ciIC1XIC1jTW9uZGEtUmVndWxhck1vbmRhIGlzIGEgdHJhZGVtYXJrIG9mIHZlcm5vbiBhZGFtcy5WZXJub24gQWRhbXNodHRwOi8vY29kZS5uZXd0eXBvZ3JhcGh5LmNvLnVrVGhpcyBGb250IFNvZnR3YXJlIGlzIGxpY2Vuc2VkIHVuZGVyIHRoZSBTSUwgT3BlbiBGb250IExpY2Vuc2UsIFZlcnNpb24gMS4xLiBUaGlzIGxpY2Vuc2UgaXMgYXZhaWxhYmxlIHdpdGggYSBGQVEgYXQ6IGh0dHA6Ly9zY3JpcHRzLnNpbC5vcmcvT0ZMaHR0cDovL3NjcmlwdHMuc2lsLm9yZy9PRkwAQwBvAHAAeQByAGkAZwBoAHQAIAAoAGMAKQAgADIAMAAxADIALAAgAHYAZQByAG4AbwBuACAAYQBkAGEAbQBzACAAKAB2AGUAcgBuAEAAbgBlAHcAdAB5AHAAbwBnAHIAYQBwAGgAeQAuAGMAbwAuAHUAawApACwAIAB3AGkAdABoACAAUgBlAHMAZQByAHYAZQBkACAARgBvAG4AdAAgAE4AYQBtAGUAcwAgACcATQBvAG4AZABhACcATQBvAG4AZABhAFIAZQBnAHUAbABhAHIATQBvAG4AZABhACAAUgBlAGcAdQBsAGEAcgBWAGUAcgBzAGkAbwBuACAAMQAgADsAIAB0AHQAZgBhAHUAdABvAGgAaQBuAHQAIAAoAHYAMAAuADkAMwAuADgALQA2ADYAOQBmACkAIAAtAGwAIAA4ACAALQByACAANQAwACAALQBHACAAMgAwADAAIAAtAHgAIAAwACAALQB3ACAAIgBnAEcAIgAgAC0AVwAgAC0AYwBNAG8AbgBkAGEALQBSAGUAZwB1AGwAYQByAE0AbwBuAGQAYQAgAGkAcwAgAGEAIAB0AHIAYQBkAGUAbQBhAHIAawAgAG8AZgAgAHYAZQByAG4AbwBuACAAYQBkAGEAbQBzAC4AVgBlAHIAbgBvAG4AIABBAGQAYQBtAHMAaAB0AHQAcAA6AC8ALwBjAG8AZABlAC4AbgBlAHcAdAB5AHAAbwBnAHIAYQBwAGgAeQAuAGMAbwAuAHUAawBUAGgAaQBzACAARgBvAG4AdAAgAFMAbwBmAHQAdwBhAHIAZQAgAGkAcwAgAGwAaQBjAGUAbgBzAGUAZAAgAHUAbgBkAGUAcgAgAHQAaABlACAAUwBJAEwAIABPAHAAZQBuACAARgBvAG4AdAAgAEwAaQBjAGUAbgBzAGUALAAgAFYAZQByAHMAaQBvAG4AIAAxAC4AMQAuACAAVABoAGkAcwAgAGwAaQBjAGUAbgBzAGUAIABpAHMAIABhAHYAYQBpAGwAYQBiAGwAZQAgAHcAaQB0AGgAIABhACAARgBBAFEAIABhAHQAOgAgAGgAdAB0AHAAOgAvAC8AcwBjAHIAaQBwAHQAcwAuAHMAaQBsAC4AbwByAGcALwBPAEYATABoAHQAdABwADoALwAvAHMAYwByAGkAcAB0AHMALgBzAGkAbAAuAG8AcgBnAC8ATwBGAEwAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAf//AA8AAAABAAAAAMw9os8AAAAAzNmo7gAAAADM2o1yAAEAAAAMAAAAIgAqAAIAAwADAbAAAQGxAbIAAgGzAbQAAQAEAAAAAQAAAAIAAQAAAAAAAAABAAAACgA0AEIAA0RGTFQAHmdyZWsAFGxhdG4AHgAEAAAAAP//AAAABAAAAAD//wABAAAAAWtlcm4ACAAAAAEAAAABAAQAAgAAAAEACAACAy4ABAAAA9wFhAAVABMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD/8AAAAAD/vgAA/3z/vgAA/4wAAAAAAAAAAP/8//r//P/0AAD//gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP/8AAAAAAAAAAAAAP/6//L/+P/4AAAAAAAAAAAAAAAAAAAAAAAA/94AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD//gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA//IAAAAAAAD/+gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD/4AAA/+j/zAAA/9QAAAAAAAAAAAAAAAAAAAAAAAD/5gAA/8QAAAAAAAAAAP/0AAAAAP/8AAD/iP+IAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA//oAAP/8AAAAAAAAAAAAAAAAAAAAAAAA/+gAAAAAAAAAAAAAAAAAAAAAAAD/9P/0/8T/xAAAAAAAAAAAAAD/3AAAAAAAAAAAAAAAAAAAAAAAAP/y//L/2P/YAAAAAAAAAAAAAP/0//gAAAAAAAAAAAAAAAAAAAAA//b/+v/E/8QAAAAAAAAAAAAA//gAAAAA//QAAAAAAAAAAAAAAAD/9P/0/9j/2AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD//AAA//wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP/8AAD//AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP/8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD//AAA//oAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP/Y/9gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/9j/2AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD/2P/YAAAAAAAAAAAAAQBVACQAJgAnACkAKgAuAC8AMgAzADQANQA3ADkAOgA8AEQARQBIAEsAUABRAFIAUwBZAFoAXACCAIMAhACFAIYAhwCUAJUAlgCXAJgAmgCfALMAtAC1ALYAtwC4ALoAvwDAAMEAwgDEAMYA0ADnAOkBBgEIAQoBDgEPARABEQESARMBFgEYARoBJgE3ATkBOgFQAVIBXAFdAV4BXwFgAWIBagGEAYoBjAGOAZAAAgBGACQAJAABACYAJgACACcAJwADACkAKQAEACoAKgAFAC4ALgAGAC8ALwAHADIAMgADADMAMwAIADQANAADADUANQAJADcANwAKADkAOQALADoAOgAMADwAPAANAEQARAAOAEUARQAPAEgASAAQAEsASwARAFAAUQARAFIAUwAPAFkAWQASAFoAWgATAFwAXAAUAIIAhwABAJQAmAADAJoAmgADAJ8AnwANALMAswARALQAuAAPALoAugAPAL8AvwAUAMAAwAAPAMEAwQAUAMIAwgABAMQAxAABAMYAxgABANAA0AADAOcA5wARAOkA6QARAQYBBgARAQgBCAARAQoBCgARAQ4BDgADAQ8BDwAPARABEAADAREBEQAPARIBEgADARMBEwAPARYBFgAJARgBGAAJARoBGgAJASYBJgAKATcBNwATATkBOQAUAToBOgANAVABUAABAVIBUgABAVwBXAADAV0BXQAPAV4BXgADAV8BXwAPAWABYAAJAWIBYgAJAWoBagAKAYQBhAAPAYoBigATAYwBjAATAY4BjgATAZABkAAUAAIAbQAPAA8ADQARABEADgAkACQAAQAmACYAAgAqACoAAgAtAC0AAwAyADIAAgA0ADQAAgA2ADYABAA3ADcABQA4ADgABgA5ADkABwA6ADoACAA7ADsACQA8ADwACgBEAEQACwBGAEgADABSAFIADABUAFQADABYAFgADwBZAFkAEABaAFoAEQBcAFwAEgCCAIcAAQCJAIkAAgCUAJgAAgCaAJoAAgCbAJ4ABgCfAJ8ACgCiAKgACwCpAK0ADACyALIADAC0ALgADAC6ALoADAC7AL4ADwC/AL8AEgDBAMEAEgDCAMIAAQDDAMMACwDEAMQAAQDFAMUACwDGAMYAAQDHAMcACwDIAMgAAgDJAMkADADKAMoAAgDLAMsADADMAMwAAgDNAM0ADADOAM4AAgDPAM8ADADRANEADADVANUADADXANcADADZANkADADbANsADADdAN0ADADeAN4AAgDgAOAAAgDiAOIAAgDkAOQAAgEOAQ4AAgEPAQ8ADAEQARAAAgERAREADAESARIAAgETARMADAEUARQAAgEVARUADAEcARwABAEgASAABAEiASIABAEmASYABQEqASoABgErASsADwEsASwABgEtAS0ADwEuAS4ABgEvAS8ADwEwATAABgExATEADwEyATIABgEzATMADwE0ATQABgE1ATUADwE3ATcAEQE5ATkAEgE6AToACgFOAU4AAgFQAVAAAQFRAVEACwFSAVIAAQFTAVMACwFVAVUADAFXAVcADAFcAVwAAgFdAV0ADAFeAV4AAgFfAV8ADAFkAWQABgFlAWUADwFmAWYABgFnAWcADwFoAWgABAFqAWoABQGKAYoAEQGMAYwAEQGOAY4AEQGQAZAAEgABAAAACgAqADgAA0RGTFQAFGdyZWsAFGxhdG4AFAAEAAAAAP//AAEAAAABbGlnYQAIAAAAAQAAAAEABAAEAAAAAQAIAAEAGgABAAgAAgAGAAwBsgACAE8BsQACAEwAAQABAEk') format('truetype');
}
/* </style> */
// </style>
