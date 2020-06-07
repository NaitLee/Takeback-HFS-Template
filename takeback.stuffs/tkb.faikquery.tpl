
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
