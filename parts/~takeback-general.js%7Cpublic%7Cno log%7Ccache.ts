
// Declare Window members here
interface Window {
    tooltip_manager: TooltipManager;
    dialog: Dialog;
}

class Helper {
    getFilename(path: string) {
        return decodeURIComponent(path.split('/').slice(-1)[0]);
    }
    getDirname(path: string) {
        return decodeURIComponent(path.split('/').slice(0, -1).join('/') + '/');
    }
    getPath(url: string) {
        return decodeURIComponent('/' + url.split('/').slice(3).join('/'));
    }
}
var helper = new Helper();

class Animator {
    elements: NodeListOf<HTMLElement> | Array<HTMLElement>;
    FRAME: number;
    classShow: string;
    classHide: string;
    constructor(selector: string | HTMLElement) {
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
        this.elements.forEach((element: HTMLElement) => {
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
        this.elements.forEach((element: HTMLElement) => {
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

function AnimatorConstructor (selector: string | HTMLElement) { return new Animator(selector); }

var $ = AnimatorConstructor;

class TooltipManager {
    elemTooltip: HTMLElement;
    constructor() {
        this.elemTooltip = document.getElementById('tooltip');
        document.querySelectorAll('*[data-tooltip]').forEach(element => {
            element.addEventListener('mouseover', event => this.show(element.getAttribute('data-tooltip')));
            element.addEventListener('mouseout', event => this.hide());
        });
    }
    show(message: string) {
        this.elemTooltip.innerText = message;
        $(this.elemTooltip).show();
    }
    hide() {
        $(this.elemTooltip).hide();
    }
}
window.addEventListener('DOMContentLoaded', () => window.tooltip_manager = new TooltipManager());

class Dialog {
    sectionDialog: HTMLElement;
    elemDialog: HTMLDivElement;
    elemText: HTMLParagraphElement;
    elemActions: HTMLParagraphElement;
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
    alert(message: string, callbackfn = () => undefined) {
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
    confirm(message: string, callbackfn = () => undefined) {
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
    prompt(message: string, callbackfn: Function = (input: string) => input) {
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
