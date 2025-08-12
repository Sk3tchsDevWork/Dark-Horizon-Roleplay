const createIDCardUI = () => {
    const style = document.createElement('style');
    style.innerHTML = `
        @font-face {
            font-family: "Courier New", Courier, monospace;
        }

        body, html {
            width: 50%;
            height: 50%;
            margin: 0;
            padding: 0;
        }

        p {
            padding: 0;
            margin: 0;
            text-transform: uppercase;
            color: #9e9e9e00;
            font-size: 12px;
        }

        #id-card {
            position: relative;
            display: none;
            margin: 280px 1400px 0 0;
            left: 10vh;
            width: 300px;
            height: 191px;
            padding: 54px 17px 10px 144px;
            background: url("assets/images/lawyer.png") no-repeat center center;
            background-size: cover;
        }

        #name {
            font-family: sans-serif;
            font-weight: normal;
            font-size: 23px;
            color: #000000;
            text-align: left;
        }

        #fln {
            position: absolute;
            top: 10px;
            left: 19px;
        }

        #barid {
            font-weight: normal;
            font-size: 12px;
            font-variant: small-caps;
            color: #000000;
        }

        #bs {
            position: absolute;
            top: 38px;
            left: 42px;
        }

        #date {
            font-weight: normal;
            font-size: 12px;
            font-variant: small-caps;
            text-transform: uppercase;
            color: #000000;
        }

        #da {
            position: absolute;
            top: 53px;
            left: 107px;
        }
    `;
    document.head.appendChild(style);

    const idCard = document.createElement('div');
    idCard.id = 'id-card';
    idCard.innerHTML = `
        <div id="fln"><p id="name"></p></div>
        <div id="bs"><p id="barid"></p></div>
        <div id="da"><p id="date"></p></div>
    `;
    document.body.appendChild(idCard);
};

const open = (data) => {
    $('#name').css('color', '#FFFFFF').text(data.name);
    $('#barid').css('color', '#FFFFFF').text(data.barid);
    $('#date').css('color', '#FFFFFF').text(data.date);

    $('#id-card').css('background-image', 'url(assets/images/lawyer.png)').show();
};

const close = () => {
    $('#name').text('');
    $('#barid').text('');
    $('#date').text('');
    $('#id-card').hide();
};

window.addEventListener('load', () => {
    if (typeof $ === 'undefined') {
        console.error('jQuery is required for this UI.');
        return;
    }

    createIDCardUI();

    window.addEventListener('message', function (event) {
        switch (event.data.action) {
            case "open":
                open(event.data);
                break;
            case "close":
                close();
                break;
        }
    });
});

