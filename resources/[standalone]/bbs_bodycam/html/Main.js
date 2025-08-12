let gameCanvas;
let pausedCanvas;
let outputCanvas;
let ctx;
let outputCtx;

let currentTrack;
let room;
let paused = false;

function createPausedCanvas(width, height) {
    pausedCanvas = document.createElement('canvas');
    pausedCanvas.width = width;
    pausedCanvas.height = height;
    const ctx = pausedCanvas.getContext('2d');

    ctx.fillStyle = 'black';
    ctx.fillRect(0, 0, width, height);
    ctx.font = '48px Arial';
    ctx.fillStyle = 'white';
    ctx.textAlign = 'center';
    ctx.fillText('Stream Paused', width / 2, height / 2);
}

function createOutputCanvas(width, height) {
    outputCanvas = document.createElement('canvas');
    outputCanvas.width = width;
    outputCanvas.height = height;
    outputCtx = outputCanvas.getContext('2d');
    return outputCanvas;
}

function compositePausedFrame() {
    outputCtx.clearRect(0, 0, outputCanvas.width, outputCanvas.height);
    outputCtx.drawImage(pausedCanvas, 0, 0);
}

function compositeGameFrame() {
    outputCtx.clearRect(0, 0, outputCanvas.width, outputCanvas.height);
    outputCtx.drawImage(gameCanvas, 0, 0);
}

async function publishNewTrack(newTrack, name) {
    if (currentTrack) {
        await room.localParticipant.unpublishTrack(currentTrack);
        currentTrack.stop();
    }
    currentTrack = newTrack;
    await room.localParticipant.publishTrack(currentTrack, { name });
}

let gameStreamInterval;

window.addEventListener('message', async (event) => {
    if (event.data?.type === 'start') {
        const width = event.data.width || 1280;
        const height = event.data.height || 720;

        gameCanvas = document.createElement('canvas');
        gameCanvas.width = width;
        gameCanvas.height = height;
        paused = false
        createPausedCanvas(width, height);
        const canvas = createOutputCanvas(width, height);

        MainRender.renderToTarget(gameCanvas);
        MainRender.resize(true);

        const stream = canvas.captureStream(event.data.fps || 20);
        const videoTrack = stream.getVideoTracks()[0];
        if (!room) {
            room = new LivekitClient.Room();
            console.log(event.data.ip, event.data.token)

            await room.connect(event.data.ip, event.data.token);
        }

        await publishNewTrack(videoTrack, 'video_from_canvas');
        if (gameStreamInterval) {
            clearInterval(gameStreamInterval);
        }
        gameStreamInterval = setInterval(() => {
            if (paused) {
                compositePausedFrame();
            } else {
                compositeGameFrame();
            }
        }, 15); // ~20 FPS
        console.log('Streaming right now!', room.name)
    }

    if (event.data?.type === 'pause') {
        if (!room || paused) return;
        paused = true;
        MainRender.stop();
        compositePausedFrame();
    }

    if (event.data?.type === 'resume') {
        if (!room || !paused) return;
        paused = false;
        MainRender.renderToTarget(gameCanvas);
        MainRender.resize(true);
    }

    if (event.data?.type === 'stop') {
        if (!room) return;
        clearInterval(gameStreamInterval);
        MainRender.stop();
        await room.localParticipant.unpublishTrack(currentTrack);
        currentTrack.stop();
        currentTrack = null
        try {
            if (room) await room.disconnect();
        } catch (e) {
            console.warn("Error during disconnect:", e);
        }
        room = null;
        gameCanvas = null;
        pausedCanvas = null;
        outputCanvas = null;
        ctx = null;
        outputCtx = null;

    }
});
