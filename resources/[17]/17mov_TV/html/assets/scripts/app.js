let keyDetectActive = false;
let creatorActive = false
const Apps = [
	{
		name: "OnlyTube",
		color: "ff1a35",
		description:
			"Dive into a world of diverse content, from DIY tutorials to viral sensations. Your daily dose of entertainment and knowledge.",
	},
	{
		name: "OnlyStream",
		color: "823cff",
		description:
			"Experience live broadcasts where gamers, artists, and creators connect in real-time. Feel the pulse of streaming culture.",
	},
	{
		name: "OnlyMusic",
		color: "f28c2c",
		hidden: true,
		description:
			"Immerse yourself in melodious tunes, uncover emerging artists, or revisit timeless tracks. A symphony for your ears.",
	},
	{
		name: "OnlyClips",
		color: "823cff",
		description:
			"Relive the most iconic and unforgettable moments. Bite-sized entertainment for those who cherish highlights.",
	},
	{
		name: "OnlyVideo",
		color: "5fe5d1",
		description:
			"Discover a variety of short and impactful videos. From raw footages to remarkable edits, every clip tells a story.",
	},
	{
		name: "OnlyBrowser",
		color: "5468ee",
		description:
			"Navigate the vast web. From articles to images, every search brings you closer to what matters most.",
	},
];

const OpenApp = (appName) => {
	const dialogEl = document.querySelector(".dialog");
	const dialogWrapperEl = dialogEl.querySelector(".dialog-wrapper");
	const app = Apps.find((app) => app.name === appName);

	dialogWrapperEl.innerHTML = `
        <div class="card option ${app.name.toLowerCase()}">
            <header>
                <img src="assets/images/${app.name}.svg" alt="" />
                <h1>${app.name.replace("Only", "Only<span>") + "</span>"}</h1>
            </header>
            <p style = "padding: 10px 0">
                ${app.description}
            </p>
            <button onclick="Play('${app.name}')">Open link</button>
            <svg
                xmlns="http://www.w3.org/2000/svg"
                width="203"
                height="157"
                viewBox="0 0 203 157"
                fill="none"
                class="decoration"
            >
                <path
                    d="M0 0C22.8537 78.504 88.4252 137.136 168.986 151.103L203 157H2C0.895433 157 0 156.105 0 155V0Z"
                    fill="white"
                    fill-opacity="0.05"
                />
            </svg>
        </div>
        <div class="card option link">
            <input type="text" placeholder="Paste Link..." />
            <div class="close">
                <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="16"
                    height="16"
                    viewBox="0 0 16 16"
                    fill="none"
                >
                    <path
                        d="M16.0987 12.4291L11.7848 8.11572L16.0973 3.80275C16.1398 3.76027 16.1735 3.70984 16.1965 3.65434C16.2195 3.59883 16.2314 3.53934 16.2314 3.47926C16.2314 3.41918 16.2195 3.35969 16.1965 3.30418C16.1735 3.24868 16.1398 3.19825 16.0973 3.15576L13.0763 0.134024C12.9905 0.0482091 12.8741 0 12.7527 0C12.6313 0 12.5149 0.0482091 12.4291 0.134024L8.11589 4.44698L3.80339 0.134024C3.63181 -0.0377855 3.32798 -0.0377855 3.15617 0.134024L0.134429 3.1553C0.0487265 3.2412 0.000595083 3.35758 0.000595083 3.47891C0.000595083 3.60025 0.0487265 3.71663 0.134429 3.80252L4.44762 8.11572L0.133739 12.4294C0.0480926 12.5153 0 12.6317 0 12.753C0 12.8743 0.0480926 12.9907 0.133739 13.0766L3.15502 16.0981C3.19749 16.1406 3.24793 16.1744 3.30346 16.1974C3.35899 16.2205 3.41851 16.2323 3.47863 16.2323C3.53874 16.2323 3.59827 16.2205 3.6538 16.1974C3.70933 16.1744 3.75977 16.1406 3.80224 16.0981L8.11589 11.7844L12.4298 16.0979C12.5192 16.1871 12.6358 16.232 12.7534 16.232C12.8709 16.232 12.9877 16.1871 13.0772 16.0979L16.099 13.0764C16.1847 12.9905 16.2329 12.8741 16.2329 12.7527C16.2328 12.6313 16.1846 12.5149 16.0987 12.4291Z"
                        fill="#FF1A35"
                    />
                </svg>
            </div>
        </div>
    `;

	dialogEl.style.display = null;
	requestAnimationFrame(() => {
		dialogEl.style.opacity = "1";
	});

	dialogEl.querySelector(".close").onclick = () => {
		dialogEl.style.opacity = "0";
		setTimeout(() => {
			dialogEl.style.display = "none";
		}, 300);
	};
};

const Play = (appName) => {
	const dialogEl = document.querySelector(".dialog");
	const inputEl = dialogEl.querySelector("input");
	const link = inputEl.value.trim();

	inputEl.classList.remove("wrong");

	if (link.startsWith("http://") || link.startsWith("https://")) {
		Post("playLink", {
			link,
			platform: appName,
		});

		const tv = document.querySelector(".tv");
		tv.style.opacity = "0";
		setTimeout(() => {
			tv.style.display = "none";
			dialogEl.style.display = "none"
			dialogEl.style.opacity = "0"

		}, 300);
	} else {
		inputEl.classList.add("wrong");
	}
};

const Post = (endpoint, body = {}) => {
    fetch(`https://${GetParentResourceName()}/${endpoint}`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json; charset=UTF-8",
        },
        body: JSON.stringify(body),
    }).catch(() => {});
};

window.onload = () => {
	const screen = document.querySelector(".screen-wrapper");

	Apps.forEach((app) => {
		const card = document.createElement("div")
		card.className = `card option ${app.name.toLowerCase()}`
		card.id = app.name.toLowerCase()

		if (app.hidden) card.style.display = "none";

		card.innerHTML += `
			<header>
				<img src="assets/images/${app.name}.svg" alt="" />
				<h1>${
					app.name.replace("Only", "Only<span>") + "</span>"
				}</h1>
			</header>
			<p>
				${app.description}
			</p>
			<button onclick="OpenApp('${
				app.name
			}')">Click to open app</button>
			<svg
				xmlns="http://www.w3.org/2000/svg"
				width="203"
				height="157"
				viewBox="0 0 203 157"
				fill="none"
				class="decoration"
			>
				<path
					d="M0 0C22.8537 78.504 88.4252 137.136 168.986 151.103L203 157H2C0.895433 157 0 156.105 0 155V0Z"
					fill="white"
					fill-opacity="0.05"
				/>
			</svg>
        `;

		screen.appendChild(card)
	});

	window.addEventListener("keydown", (e) => {
		const key = e.key.toLowerCase();

		if (key === "escape") {
			const tv = document.querySelector(".tv");
			tv.style.opacity = "0";
			setTimeout(() => {
				tv.style.display = "none";
			}, 300);
			Post("exit");
			if (creatorActive) {
				creatorActive = false
				const creator = document.querySelector(".creator");
				creator.style.opacity = "0";
				setTimeout(() => {
					creator.style.display = "none";
				}, 300);
				Post("abort");
			}
		}
		if (keyDetectActive) {
			if (key === "arrowup") Post("keyPress", "up");
			if (key === "arrowdown") Post("keyPress", "down");
			if (key === "arrowright") Post("keyPress", "right");
			if (key === "arrowleft") Post("keyPress", "left");
			if (key === "w") Post("keyPress", "w");
			if (key === "s") Post("keyPress", "s");
			if (key === "a") Post("keyPress", "a");
			if (key === "d") Post("keyPress", "d");
			if (key === "shift") Post("keyPress", "shift");
			if (key === "left") Post("keyPress", "shift");
			if (key === "shift") Post("keyPress", "shift");
		}
	});

	window.addEventListener("click", () => {
		if (keyDetectActive) {
			keyDetectActive = false;
			creatorActive = false
			const creator = document.querySelector(".creator");
			creator.style.opacity = "0";
			setTimeout(() => {
				creator.style.display = "none";
			}, 300);
			Post("SubmitPosition");
		}
	});

	window.addEventListener("contextmenu", () => {
		if (keyDetectActive) {
			keyDetectActive = false;
			creatorActive = false
			const creator = document.querySelector(".creator");
			creator.style.opacity = "0";
			setTimeout(() => {
				creator.style.display = "none";
			}, 300);
			Post("abort");
		}
	});

	window.addEventListener("message", (e) => {
		const { action } = e.data;

		switch (action) {
			case "startScript":
				keyDetectActive = true;
				creatorActive = true
				document.querySelector("#heading").textContent = e.data.heading;
				const creator = document.querySelector(".creator");
				creator.style.display = null;
				requestAnimationFrame(() => {
					creator.style.opacity = "1";
				});
				break;
			case "UpdateRotations":
				document.querySelector("#pitch").textContent = e.data.x;
				document.querySelector("#heading").textContent = e.data.heading;
				document.querySelector("#roll").textContent = e.data.y;
				break;
			case "PopUpTvMenu":
				const tv = document.querySelector(".tv");
				tv.style.display = null;
				requestAnimationFrame(() => {
					tv.style.opacity = 1;
				});
				SetValue(".input-slider", e.data.volume)
				break;
			case "turnOnSoundcloud":
				document.querySelector("#onlymusic").style.display = null;
				break;
			default:
				break;
		}
	});
};
