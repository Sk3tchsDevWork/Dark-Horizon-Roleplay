const Sliders = {};
let activeSlider = null;

const GetInput = (element) => {
	let className = element.className;

	while (className !== "input-slider") {
		element = element.parentNode;
		className = element.className;
	}

	return element;
};

const SetInput = (input, clientY) => {
	const dot = input.querySelector(".dot");
	const active = input.querySelector(".active");
	const { top, height } = input
		.querySelector(".slider")
		.getBoundingClientRect();
	let y = clientY - top;
	if (y < 0) y = 0;
	if (y > height) y = height;

	const volume = 1 - y / height
	dot.style.top = `${y}px`;
	active.style.height = `${height - y}px`;

	input.setAttribute("data-volume", volume);
	Post("changeVolume", {
		volume,
	})
};

const SetValue = (selector, volume) => {
	if (volume > 1) {
		volume = volume / 100
	}

	const input = document.querySelector(selector)
	const dot = input.querySelector(".dot");
	const active = input.querySelector(".active");

	const { height } = input
		.querySelector(".slider")
		.getBoundingClientRect();
	const y = (1 - volume) * height

	dot.style.top = `${y}px`;
	active.style.height = `${height - y}px`;

	input.setAttribute("data-volume", volume);
};

document.addEventListener("DOMContentLoaded", function() {
	document.querySelectorAll(".input-slider").forEach((input, idx) => {
		input.setAttribute("data-idx", idx);
		Sliders[idx] = input;

		input.addEventListener("mousedown", (e) => {
			const input = GetInput(e.target);
			const idx = input.getAttribute("data-idx");
			activeSlider = idx;
			SetInput(input, e.clientY);
		});

		window.addEventListener("mouseup", () => {
			activeSlider = null;
		});

		window.addEventListener("mousemove", (e) => {
			if (activeSlider === null) return;
			SetInput(Sliders[activeSlider], e.clientY);
		});
	});
})
