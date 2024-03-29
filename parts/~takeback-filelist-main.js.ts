
// Declare Window members here
interface Window {
    statics: StaticsManager;
    tooltip_manager: TooltipManager;
    player: Player;
    dialog: Dialog;
    previewer: Previewer;
    thumbs_manager: ThumbsManager;
    HFS: {
        sid: string;
        folder: string;
        encodedFolder: string;
        can_delete: string;
        can_mkdir: string;
        can_comment: string;
        can_rename: string;
        can_move: string;
        version: string;
    }
}

interface Navigator {
    mediaSession: {
        metadata: Object;
        setActionHandler: (action: string, handler: Function) => void;
    };
}

declare var MediaMetadata: {
    new(object: {
        title?: string,
        artist?: string,
        album?: string,
        artwork?: {
            src?: string,
            sizes?: string,
            type?: string,
        }[]
    }): Object;
};

class StaticsManager {
    typeMap: Object;
    filelist: string[];
    constructor() {
        this.typeMap = {
            audio: ['.mp3', '.ogg', '.wav', '.m4a'],
            video: ['.mp4', '.ogv', '.mpv', '.webm'],
            image: ['.png', '.jpg', '.jpeg', '.gif', '.webp'],
            doc: ['.txt', '.html', '.htm'],
            playlist: ['.m3u', '.m3u8']
        }
        this.filelist = [];
        document.querySelectorAll<HTMLAnchorElement>('table#files tbody tr td:nth-child(1) a').forEach((element) => this.filelist.push(helper.uniformURI(element.href)));
    }
}
window.addEventListener('DOMContentLoaded', () => window.statics = new StaticsManager());

class Player {
    sequence: string;
    playing: boolean;
    audio: HTMLAudioElement | HTMLVideoElement;
    songlist: string[];
    nowplaying: number;
    songlistShuffled: string[];
    elemStatus: HTMLElement;
    elemNowplaying: HTMLElement;
    lyricsArea: HTMLElement;
    constructor() {
        this.lyricsArea = document.querySelector('section.lyrics');
        this.sequence = 'shuffle';
        this.playing = false;
        if (navigator.mediaSession) {
            navigator.mediaSession.setActionHandler('play', () => this.play());
            navigator.mediaSession.setActionHandler('pause', () => this.pause());
            navigator.mediaSession.setActionHandler('stop', () => this.pause());
            navigator.mediaSession.setActionHandler('previoustrack', () => this.play(-1));
            navigator.mediaSession.setActionHandler('nexttrack', () => this.play(1));
        }
        this.songlist = window.statics.filelist.filter(filename => window.statics.typeMap['audio'].some(format => filename.toLowerCase().endsWith(format)));
        if (this.songlist.length != 0) $('#audioplayer').show();
        this.nowplaying = 0;
        this.songlistShuffled = this.songlist.sort((a, b) => 0.5 - Math.random());
        document.getElementById('audioplayer').querySelectorAll<HTMLElement>('*[data-player], *[data-player-alt]').forEach(element => {
            switch (element.getAttribute('data-player')) {
                case 'next':
                    element.addEventListener('click', () => {
                        this.play(1);
                    });
                    break;
                case 'pause':
                    element.addEventListener('click', () => {
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
        if (offset != 0 || this.audio.src == '') {
            let count = this.nowplaying + offset;
            if (count < 0) count = this.songlist.length + count;
            else if (count >= this.songlist.length) count = count % this.songlist.length;
            this.nowplaying = count;
            // Webkit browsers cannot handle <video> <track> src change properly
            // So create a new <video> everytime play
            this.audio = document.createElement('video');
            this.audio.classList.add('lyrics');
            this.lyricsArea.querySelectorAll('video').forEach(e => e.remove());
            this.lyricsArea.appendChild(this.audio);
            this.audio.onended = () => this.play(1);
            this.audio.onerror = () => this.play(1);
            this.audio.src = this.sequence == 'shuffle' ? this.songlistShuffled[count] : this.songlist[count];
            this.addLyricsFor(this.audio.src);
        }
        this.audio.play();
        this.elemStatus.innerText = '{.!Playing:.}';
        this.elemNowplaying.innerText = helper.getFilename(this.audio.src);
        this.playing = true;
        if (navigator.mediaSession) {
            let [title, artist] = window.helper.getFilename(this.audio.src).split(' - ').reverse();
            let filename = this.audio.src.split('.').slice(0, -1).join('.');
            let possibleArtworks = ['.jpg', '.png'].map(x => filename + x);
            let foundArtwork = possibleArtworks.filter(x => window.statics.filelist.indexOf(x) != -1)[0];
            navigator.mediaSession.metadata = new MediaMetadata({
                title: title,
                artist: artist,
                artwork: foundArtwork ? [{
                    src: foundArtwork,
                    type: 'image/' + foundArtwork.split('.').slice(-1)[0],
                    sizes: '192x192'
                }] : []
            });
        }
    }
    pause() {
        this.audio.pause();
        this.elemStatus.innerText = '{.!Paused:.}';
        this.playing = false;
    }
    convertLrcToVtt(lrc: string) {
        let lines = lrc.split('\n');
        return 'WEBVTT\n\n' + lines.map((item, index) => {
            if (/^\[[a-z]{2}:(.*?)\]$/.test(item) || item.trim() == '') return '';   // Delete metadata
            item += lines[index + 1] || '[59:59.99]';
            item = item.replace(/^\[(.+?)\](.*?)\[(.+?)\](.*?)$/,'\n$10 --> $30\n$2\n').replace(/ ?\/ ?/g, '\n');
            return item;
        }).join('\n');
    }
    addLyricsFor(file: string) {
        let lrcFile = helper.uniformURI(file.split('.').slice(0, -1).join('.') + '.lrc');
        if (window.statics.filelist.indexOf(lrcFile) == -1) {
            $(this.lyricsArea).hide();
            return;
        }
        fetch(lrcFile).then(r => r.text()).then(t => {
            let commonText = t.replace(/\r?\n/g, '\n');
            let vtt = this.convertLrcToVtt(commonText);
            // let track = this.lyricsArea.querySelector('track');
            let track = document.createElement('track');
            track.kind = 'captions';
            track.default = true;
            this.audio.appendChild(track);
            track.src = URL.createObjectURL(new Blob([vtt], {type: 'text/vtt;charset=utf-8'}));
            $(this.lyricsArea).show();
        });
    }
}
window.addEventListener('DOMContentLoaded', () => window.player = new Player());

class Previewer {
    selectedFiles: string[];
    elemTitle: HTMLElement;
    elemMenu: HTMLElement;
    elemContent: HTMLElement;
    // Also file control menu
    constructor() {
        this.selectedFiles = [];
        document.querySelectorAll<HTMLAnchorElement>('.part1 table#files tbody tr td:nth-child(1) a').forEach(element => {
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
            element.addEventListener('click', () => {
                element.classList.toggle('selected');
                this.selectedFiles = [... document.querySelectorAll('table#files tbody tr.selected')].map(x => helper.getPath(x.querySelector<HTMLAnchorElement>('td:nth-child(1) a').href));
                this.initMenu('selections');
            });
        });
        $('#preview').show();
        document.getElementById('preview').querySelectorAll<HTMLElement>('*[data-preview]').forEach(element => {
            switch (element.getAttribute('data-preview')) {
                case 'close':
                    element.addEventListener('click', () => {
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
        this.elemTitle.innerText = helper.getFilename(window.HFS.folder.slice(0, -1));
        this.initMenu();
    }
    delete(items: string[]) {
        window.dialog.confirm('{.!Delete @items@?.}'.replace('@items@', items.map(x => helper.getFilename(x)).join('; ')), () => {
            let xhr = new XMLHttpRequest();
            xhr.open('POST', window.HFS.folder);
	        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
            xhr.onload = () => {
                window.dialog.alert('{.!Success.}', () => location.href = (items[0] == window.HFS.folder ? '../' : './'));
            }
            xhr.send(`action=delete&selection=${items.join('&selection=')}`);
        });
    }
    move(items: string[]) {
        window.dialog.prompt('{.!Move items to:.}', (target: string) => {
            let xhr = new XMLHttpRequest();
            xhr.open('POST', './?mode=section&id=ajax.move');
	        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
            xhr.onload = () => {
                window.dialog.alert('{.!Success.}', () => location.href = (items[0] == window.HFS.folder ? '../' : './'));
            }
            xhr.send(`path=${helper.getDirname(items[0])}&from=${items.map(x => helper.getFilename(x)).join(':')}&to=${target}&token=${window.HFS.sid}`);
        });
    }
    rename(items: string[]) {
        if (items.length > 1) {
            window.dialog.alert('{.!Can only rename 1 file.}');
            return;
        }
        window.dialog.prompt('{.!Rename item to:.}', (target: string) => {
            let xhr = new XMLHttpRequest();
            xhr.open('POST', './?mode=section&id=ajax.rename');
	        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
            xhr.onload = () => {
                window.dialog.alert('{.!Success.}', () => location.href = (items[0] == window.HFS.folder ? '../' : './'));
            }
            xhr.send(`from=${items.join(':')}&to=${target}&token=${window.HFS.sid}`);
        });
    }
    comment(items: string[]) {
        window.dialog.prompt('{.!Enter comment:.}', (comment: string) => {
            let xhr = new XMLHttpRequest();
            xhr.open('POST', './?mode=section&id=ajax.comment');
	        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
            xhr.onload = () => {
                window.dialog.alert('{.!Success.}', () => location.href = (items[0] == window.HFS.folder ? '../' : './'));
            }
            xhr.send(`files=${items.join(':')}&text=${comment}&token=${window.HFS.sid}`);
        });
    }
    archive(items: string[]) {
        let form = document.createElement('form');
        form.style.display = 'none';
        form.action = './?mode=archive&recursive';
        form.method = 'POST';
        items.forEach((path) => {
            let input = document.createElement('input');
            form.append(input);
            input.type = 'hidden';
            input.name = 'selection';
            input.value = helper.getFilename(path.endsWith('/') ? path.slice(0, -1) : path);
        });
        document.body.appendChild(form);
        form.submit();
    }
    initMenu(type = 'folder') {
        function createButton(name: string, action: Function) {
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
                if (window.HFS.can_delete) {
                    menu.push(createButton('{.!Delete.}', () => this.delete([window.HFS.folder])));
                    if (window.HFS.can_move) {
                        menu.push(createButton('{.!Move.}', () => this.move([window.HFS.folder])));
                    }
                    if (window.HFS.can_rename) {
                        menu.push(createButton('{.!Rename.}', () => this.rename([window.HFS.folder])));
                    }
                    if (window.HFS.can_comment) {
                        menu.push(createButton('{.!Comment.}', () => this.comment([window.HFS.folder])));
                    }
                }
                break;
            case 'file':
                mark.innerText = '{.!File:.}';
                if (window.HFS.can_delete) {
                    menu.push(createButton('{.!Delete.}', () => this.delete(this.selectedFiles)));
                    if (window.HFS.can_move) {
                        menu.push(createButton('{.!Move.}', () => this.move(this.selectedFiles)));
                    }
                    if (window.HFS.can_rename) {
                        menu.push(createButton('{.!Rename.}', () => this.rename(this.selectedFiles)));
                    }
                    if (window.HFS.can_comment) {
                        menu.push(createButton('{.!Comment.}', () => this.comment(this.selectedFiles)));
                    }
                }
                break;
            case 'selections':
                mark.innerText = '{.!Selections:.}';
                menu.push(createButton('{.!Select All.}', () => document.querySelectorAll('table#files tbody tr').forEach(e => e.classList.add('selected'))));
                menu.push(createButton('{.!Invert.}', () => document.querySelectorAll('table#files tbody tr').forEach(e => e.classList.toggle('selected'))));
                menu.push(createButton('{.!Mask.}', () => window.dialog.prompt('{.!Enter mask to select.}', (mask: string) => {
                    let isRegex = /^\/.+\/$/.test(mask);
                    if (isRegex) mask = mask.slice(1, -1);
                    else mask = mask.replace(/\*/g, '.*').replace(/\?/, '.?');
                    document.querySelectorAll<HTMLAnchorElement>('table#files tbody tr td a').forEach(a => {
                        if (helper.uniformURI(a.href).match(new RegExp(mask)) !== null) {
                            a.parentElement.parentElement.classList.add('selected');
                        } else {
                            a.parentElement.parentElement.classList.remove('selected');
                        }
                    });
                })));
                if (window.HFS.can_delete) {
                    menu.push(createButton('{.!Delete.}', () => this.delete(this.selectedFiles)));
                    if (window.HFS.can_move) {
                        menu.push(createButton('{.!Move.}', () => this.move(this.selectedFiles)));
                    }
                    if (window.HFS.can_rename) {
                        menu.push(createButton('{.!Rename.}', () => this.rename(this.selectedFiles)));
                    }
                    if (window.HFS.can_comment) {
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
        this.elemTitle.innerText = helper.getFilename(window.HFS.folder.slice(0, -1));
    }
    convertSrtToVtt(srt: string) {
        return 'WEBVTT\n\n' + srt.replace(/\{\\([ibu])\}/g, '</$1>').replace(/\{\\([ibu])1\}/g, '<$1>').replace(/\{([ibu])\}/g, '<$1>').replace(/\{\/([ibu])\}/g, '</$1>').replace(/(\d\d:\d\d:\d\d),(\d\d\d)/g, '$1.$2').concat('\n\n');
    }
    preview(url: string) {
        this.close();
        this.elemTitle.innerText = helper.getFilename(url);
        let type = 'unknown';
        for (let i in window.statics.typeMap) {
            if (window.statics.typeMap[i].some((format: string) => url.toLowerCase().endsWith(format))) {
                type = i;
                break;
            }
        }
        let wrapperContent = document.createElement('div');
        let wrapperActions = document.createElement('div');
        switch (type) {
            case 'audio':
                let audio = document.createElement('audio');
                audio.controls = true;
                audio.src = url;
                wrapperContent.appendChild(audio);
                audio.play();
                let a0 = document.createElement('a');
                a0.href = 'javascript:';
                a0.innerText = '[ {.!Move to mini player.} ]';
                a0.addEventListener('click', () => {
                    this.close.bind(this)();
                    window.player.sequence = 'shuffle';
                    window.player.nowplaying = 0;
                    let number = window.player.songlistShuffled.map(x => helper.getPath(x)).indexOf(url);
                    window.player.play(number);
                });
                wrapperActions.appendChild(a0);
                break;
            case 'video':
                let video = document.createElement('video');
                video.controls = true;
                video.src = url;
                wrapperContent.appendChild(video);
                video.play();
                let srtName = video.src.split('.').slice(0, -1).join('.') + '.srt';
                let vttName = video.src.split('.').slice(0, -1).join('.') + '.vtt';
                if (window.statics.filelist.indexOf(vttName) != -1) {
                    let track = document.createElement('track');
                    track.default = true;
                    track.kind = 'captions';
                    track.src = vttName;
                    video.appendChild(track);
                } else if (window.statics.filelist.indexOf(srtName) != -1) {
                    let track = document.createElement('track');
                    track.default = true;
                    track.kind = 'captions';
                    fetch(srtName).then(r => r.text()).then(t => {
                        let commonText = t.replace(/\r?\n/g, '\n');
                        let vtt = this.convertSrtToVtt(commonText);
                        track.src = URL.createObjectURL(new Blob([vtt], {type: 'text/vtt;charset=utf-8'}));
                    });
                    video.appendChild(track);
                }
                break;
            case 'image':
                let img = document.createElement('img');
                img.src = url;
                wrapperContent.appendChild(img);
                let a1 = document.createElement('a');
                a1.href = 'javascript:';
                a1.innerText = '[ {.!Start Slideshow.} ]';
                a1.addEventListener('click', () => {
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
            case 'playlist':
                let span1 = document.createElement('span');
                span1.innerText = '{.!This is a playlist..}';
                wrapperContent.appendChild(span1);
                let a2 = document.createElement('a');
                a2.href = 'javascript:';
                a2.innerText = '[ {.!Play.} ]';
                a2.addEventListener('click', () => {
                    window.player.sequence = 'sequence';
                    window.player.nowplaying = -1;
                    fetch(url).then(r => r.text()).then(t => {
                        window.player.songlist = t.split('\n').map(x => {
                            return helper.uniformURI(((x[0] == '\'' && x.slice(-1) == '\'') || (x[0] == '"' && x.slice(-1) == '"')) ? x.slice(1, -1) : x);
                        }).filter(x => x.trim() != '');
                        window.player.play(1);
                        this.close.bind(this)();
                    });
                });
                wrapperActions.appendChild(a2);
                break;
            default:
                let span0 = document.createElement('span');
                span0.classList.add('nopreview');
                span0.innerText = '{.!No preview available.}';
                wrapperContent.appendChild(span0);
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
        let pictures = window.statics.filelist.filter(x => window.statics.typeMap['image'].some(y => x.endsWith(y)));
        let slideshow = document.querySelector<HTMLElement>('.slideshow');
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
    buttonShowThumb: HTMLElement;
    shown: boolean;
    constructor() {
        this.buttonShowThumb = document.getElementById('showthumb');
        this.buttonShowThumb.addEventListener('click', this.showThumb.bind(this));
        if (window.statics.filelist.some(x => window.statics.typeMap['image'].some(y => x.endsWith(y)))) {
            $(this.buttonShowThumb).show();
        };
        this.shown = false;
    }
    showThumb() {
        if (this.shown) return;
        this.shown = true;
        let items = document.querySelectorAll('table#files tbody tr td:nth-child(1)');
        let imgs: Array<HTMLImageElement> = [];
        items.forEach(element => {
            let a = element.querySelector('a');
            if (window.statics.typeMap['image'].some(x => a.href.toLowerCase().endsWith(x))) {
                let img = document.createElement('img');
                img.classList.add('thumb');
                // img.loading = 'lazy';    // Breaks our purpose
                img.setAttribute('data-src', a.href);
                element.prepend(img);
                imgs.push(img);
            }
        });
        let count = 0;
        function showNextThumb() {
            imgs[count].src = imgs[count].getAttribute('data-src');
            if (imgs[count + 1]) {
                imgs[count].addEventListener('load', () => {
                    setTimeout(showNextThumb, 181);
                });
            }
            count++;
        }
        showNextThumb();
    }
}
window.addEventListener('DOMContentLoaded', () => window.thumbs_manager = new ThumbsManager());
