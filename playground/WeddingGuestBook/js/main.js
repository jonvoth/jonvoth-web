//http://timtaubert.de/blog/2013/02/getusermedia-part-3-simple-motion-detection-in-a-live-video/
//http://timtaubert.de/demos/motion-detection/

window.requestAnimFrame = (function(){
	return  window.requestAnimationFrame   ||
			window.webkitRequestAnimationFrame ||
			window.mozRequestAnimationFrame    ||
			window.oRequestAnimationFrame      ||
			window.msRequestAnimationFrame     ||
			function( callback ){
				window.setTimeout(callback, 1000 / 60);
			};
})();

var buffers = [],
		bufidx = 0,
		viewportWidth,
		viewportHeight,
		videoWidth,
		videoHeight,
		liveVideoEl,
		liveCanvasEl,
		liveCanvasCtx,
		paintCanvasEl,
		paintCanvasCtx,
		snapshotEl,
		filmrollEl,
		cameraSuccess = function cameraSuccess(stream){
			liveVideoEl.src = window.webkitURL.createObjectURL(stream);
			draw();
		},
		cameraError = function cameraError(err){
			alert("Unable to get video stream! - "+err);
		},
		readFrame = function readFrame() {
			try {
				liveCanvasCtx.drawImage(liveVideoEl, 0, 0, liveCanvasEl.width, liveCanvasEl.height);
			} catch (e) {
				// The video may not be ready, yet.
				return null;
			}
			return liveCanvasCtx.getImageData(0, 0, liveCanvasEl.width, liveCanvasEl.height);
		},
		draw = function draw() {
			var frame = readFrame();

			if(frame) {
				markLightnessChanges(frame.data);
				liveCanvasCtx.putImageData(frame, 0, 0);
				paintCanvasCtx.clearRect(0, 0, viewportWidth, viewportHeight);
				paintCanvasCtx.drawImage(liveCanvasCtx.canvas, 0, 0, viewportWidth, viewportHeight);
			}
		},
		markLightnessChanges = function markLightnessChanges(data) {
			// Pick the next buffer (round-robin).
			var buffer = buffers[bufidx++ % buffers.length];

			for (var i = 0, j = 0; i < buffer.length; i++, j += 4) {
				// Determine lightness value.
				var current = lightnessValue(data[j], data[j + 1], data[j + 2]);

				// Set color to black.
				data[j] = data[j + 1] = data[j + 2] = 0;

				// Full opacity for changes.
				data[j + 3] = 255 * lightnessHasChanged(i, current);

				// Store current lightness value.
				buffer[i] = current;
			}
		},
		lightnessHasChanged = function lightnessHasChanged(index, value) {
			return buffers.some(function (buffer) {
				return Math.abs(value - buffer[index]) >= 15;
			});
		},
		lightnessValue = function lightnessValue(r, g, b) {
			return (Math.min(r, g, b) + Math.max(r, g, b)) / 255 * 50;
		},
		snap = function snap() {
			var c,
					img;

			// Make the canvas the same size as the live video
			snapshotEl.width = liveVideoEl.clientWidth;
			snapshotEl.height = liveVideoEl.clientHeight;

			// Draw a frame of the live video onto the canvas
			c = snapshotEl.getContext("2d");
			c.drawImage(liveVideoEl, 0, 0, snapshotEl.width, snapshotEl.height);

			// Create an image element with the canvas image data
			img = document.createElement("img");
			img.src = snapshotEl.toDataURL("image/png");
			img.style.padding = 5;
			img.width = snapshotEl.width / 2;
			img.height = snapshotEl.height / 2;

			// Add the new image to the film roll
			filmrollEl.appendChild(img);
		},
		init = function init(){
			var i = 0;

			viewportWidth = document.documentElement.clientWidth;
			viewportHeight = document.documentElement.clientHeight;
			liveVideoEl = document.getElementById("live");
			videoWidth = liveVideoEl.clientWidth;
			videoHeight = liveVideoEl.clientHeight;
			liveCanvasEl = document.getElementById("liveCanvas");
			liveCanvasCtx = liveCanvasEl.getContext("2d");
			liveCanvasEl.width = videoWidth;
			liveCanvasEl.height = videoHeight;
			paintCanvasEl = document.getElementById("paintCanvas");
			paintCanvasCtx = paintCanvasEl.getContext("2d");
			paintCanvasEl.width = viewportWidth;
			paintCanvasEl.height = viewportHeight;
			snapshotEl = document.getElementById("snapshot");
			filmrollEl = document.getElementById("filmroll");

			// Prepare buffers to store lightness data.
			for (i; i < 2; i++) {
				buffers.push(new Uint8Array(videoWidth * videoHeight));
			}

			//Get it started
			if(navigator.webkitGetUserMedia){
				navigator.webkitGetUserMedia({video:true, audio:false}, cameraSuccess, cameraError);
			}else if(navigator.GetUserMedia){
				navigator.GetUserMedia({video:true, audio:false}, cameraSuccess, cameraError);
			}
			(function animloop(){
				requestAnimFrame(animloop);
				draw();
			})();
		}

addEventListener("DOMContentLoaded", init);