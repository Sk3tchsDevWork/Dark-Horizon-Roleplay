console.log('helllooo')
document.documentElement.style.setProperty('--main-color', 'cyan'); // Bright green

window.addEventListener('message', async (event) => {
    if (event.data?.type === 'showUI') {
        document.getElementById('bodycam-card').style.display = 'flex'
         document.getElementById('bodycam-card').style.top = event.data.top || '3vh'
         document.getElementById('bodycam-card').style.right = event.data.right || '3vh'
        console.log(JSON.stringify(event.data))
        if (event.data.color !== undefined) {
            document.documentElement.style.setProperty('--main-color', event.data.color);
        }
        if (event.data.name !== undefined) {
            document.getElementById('name').innerHTML = event.data.name
        } else {
            document.getElementById('name').innerHTML = ''
        }
        if (event.data.job !== undefined) {
            document.getElementById('job').innerHTML = event.data.job
        } else {
            document.getElementById('job').innerHTML = ''
        }
        if (event.data.grade !== undefined) {
            document.getElementById('role').innerHTML = event.data.grade
        } else {
            document.getElementById('role').innerHTML = ''
        }
        if (event.data.imageURL !== undefined) {
            document.getElementById('plyrimg').src = `https://nui-img/${event.data.imageURL}/${event.data.imageURL}?v=${Date.now()}`
        } else {
            document.getElementById('plyrimg').src = 'images/player.png'
        }
        if (event.data.station !== undefined) {
            document.getElementById('type').innerHTML = event.data.station
        } else {
            document.getElementById('type').innerHTML = 'LIVE CAM STATION'
        }
        if (event.data.status !== undefined) {
            document.getElementById('mode').innerHTML = event.data.status
        } else {
            document.getElementById('mode').innerHTML = 'LIVE'
        }

    }
    if (event.data?.type === 'changeStatus') {
        if (event.data.status !== undefined) {
            document.getElementById('mode').innerHTML = event.data.status
        } else {
            document.getElementById('mode').innerHTML = 'LIVE'
        }
    }
    if (event.data?.type === 'hideUI') {
        document.getElementById('bodycam-card').style.display = 'none'

    }
});