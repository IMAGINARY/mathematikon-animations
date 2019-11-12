(function () {
    let getCanvas = () => undefined;

    function getCanvasP5JS() {
        if (p5.instance !== null && typeof p5.instance.canvas !== 'undefined')
            return p5.instance.canvas;
        else return undefined;
    }

    function getCanvasProcessingJS() {
        if (Processing.getInstanceById('sketch') !== undefined)
            return document.getElementById('sketch');
        else
            return undefined;
    }

    const urlSearchParam = new URLSearchParams(window.location.search);
    if (urlSearchParam.has('capture')) {
        window.capturer = new CCapture({
            framerate: 60,
            format: 'webm',
            quality: 100,
            verbose: true,
        });

        let isCapturing = false;

        function capture() {
            requestAnimationFrame(capture);
            const canvas = getCanvas();
            if (canvas !== undefined) {
                if (!isCapturing) {
                    capturer.start();
                    isCapturing = true;
                }
                console.log(canvas.width, canvas.height);
                capturer.capture(canvas);
            }
        }

        requestAnimationFrame(capture);
    }

    function addButton() {
        const button = document.createElement('input');
        button.type = 'button';
        button.value = 'Stop capture';
        button.disabled = !urlSearchParam.has('capture');
        button.onclick = () => {
            capturer.stop();
            capturer.save();
            button.disabled = true;
        };

        const form = document.createElement('form');
        form.appendChild(button);

        window.addEventListener('DOMContentLoaded', () => document.body.appendChild(form));
    }

    function init(which) {
        switch (typeof which) {
            case 'object':
                getCanvas = () => canvas;
                break;
            case 'function':
                getCanvas = which;
                break
            case 'string':
                switch (which) {
                    case "p5.js":
                        getCanvas = getCanvasP5JS;
                        break;
                    case "processing.js":
                        getCanvas = getCanvasProcessingJS;
                        break;
                    default:
                        console.error("Unknown init tag:", which);
                        break;
                }
                break;
            default:
                console.error("init called without a parameter");
                break;
        }
        addButton();
    }

    if (typeof window.IMAGINARY === 'undefined')
        window.IMAGINARY = {};

    window.IMAGINARY.Capture = {
        init: init,
    };
})();