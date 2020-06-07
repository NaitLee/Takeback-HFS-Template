
[sym-randombg]

<script>
function randomOneIn(sth) {
    return sth[Math.floor(Math.random()*sth.length)];
}
var linkGettingList = '/pic/img/bg/?tpl=list&folders-filter=\\&recursive';
var xhr1 = new XMLHttpRequest();
xhr1.open('get', linkGettingList);
xhr1.onreadystatechange = function () {
    if (xhr1.readyState === 4) {
        var lines = xhr1.responseText;
        var bgImgLocs = lines.split('\n');
        var selectedImage = randomOneIn(bgImgLocs);
        console.log("Selected image for bg: \n" + selectedImage);
        bg.style.backgroundImage = "url("+selectedImage+")";
    }
}
xhr1.send();
</script>
