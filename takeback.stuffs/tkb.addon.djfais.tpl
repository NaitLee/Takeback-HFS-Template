
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
