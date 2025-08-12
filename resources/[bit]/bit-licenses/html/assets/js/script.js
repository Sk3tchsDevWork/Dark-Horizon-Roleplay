document.addEventListener("DOMContentLoaded", function () {
	const idcard = document.getElementById("idcard");
	const lspd = document.getElementById("lspd");
	const lssd = document.getElementById("lssd");
	const press = document.getElementById("press");
	const ems = document.getElementById("ems");
	const driving = document.getElementById("dlic");
	const weapon = document.getElementById("wlic");
	const fishing = document.getElementById("fishing");
	const hunting = document.getElementById("hunting");
	const fire = document.getElementById("fire");
	const taxi = document.getElementById("taxi");
	const vcar = document.getElementById("dlic_car");
	const vmotorcycle = document.getElementById("dlic_motorcycle");
	const vtruck = document.getElementById("dlic_truck");
	const vboat = document.getElementById("dlic_boat");
	const vplane = document.getElementById("dlic_plane");
	const vhelicopter = document.getElementById("dlic_helicopter");

	const licenseElements = {
		idcard,
		lspd,
		lssd,
		press,
		ems,
		driving,
		weapon,
		fishing,
		hunting,
		fire,
		taxi,
	};

	const vehicleTypes = {
		car: vcar,
		motorcycle: vmotorcycle,
		truck: vtruck,
		boat: vboat,
		plane: vplane,
		helicopter: vhelicopter,
	};

	function display(show) {
		document.getElementById("body").style.display = show ? "flex" : "none";
	}

	function hideAll() {
		Object.values(licenseElements).forEach((el) => (el.style.display = "none"));
	}

	function setText(id, text) {
		const el = document.getElementById(id);
		if (el) el.textContent = text;
	}

	function setImage(id, src) {
		const el = document.getElementById(id);
		if (el) el.src = src;
	}

	function setVehicleColors(vehicles) {
		Object.entries(vehicleTypes).forEach(([type, el]) => {
			el.style.color = vehicles[type] ? "#000000" : "#adadad";
		});
	}

	function genderText(gender) {
		return gender == 0 ? "M" : "F";
	}

	function getLast8Chars(text) {
		return text.length > 8 ? text.slice(-8) : text;
	}

	window.addEventListener("message", ({ data: item }) => {
		if (item.type !== "showLicense") return;
		display(item.status);
		if (!item.status) return;

		hideAll();
		const { name, lastname, birthday, identity, jobgrade, gender } = item.userinfo;
		const fullName = `${name} ${lastname}`;
		const g = genderText(gender);

		switch (item.license) {
			case "idcard":
				idcard.style.display = "flex";
				setText("idcard-name", name);
				setText("idcard-lastname", lastname);
				setText("idcard-state", item.userinfo.state);
				setText("idcard-birth", birthday);
				setText("idcard-gender", g);
				setText("idcard-identifier", getLast8Chars(identity));
				setText("idcard-sign", fullName);
				setImage("idcard-photo", item.userimg);
				break;

			case "lspd":
				lspd.style.display = "flex";
				setText("lspd-name", name);
				setText("lspd-grade", jobgrade);
				setText("lspd-identifier", getLast8Chars(identity));
				setImage("lspd-photo", item.userimg);
				break;

			case "lssd":
				lssd.style.display = "flex";
				setText("lssd-name", fullName);
				setText("lssd-grade", jobgrade);
				setText("lssd-identifier", getLast8Chars(identity));
				setImage("lssd-photo", item.userimg);
				break;

			case "press":
				press.style.display = "flex";
				setText("press-name", fullName);
				setText("press-grade", jobgrade);
				setText("press-identifier", getLast8Chars(identity));
				setText("press-sign", fullName);
				setImage("press-photo", item.userimg);
				break;

			case "ems":
				ems.style.display = "flex";
				setText("ems-name", fullName);
				setText("ems-grade", jobgrade);
				setText("ems-identifier", getLast8Chars(identity));
				setImage("ems-photo", item.userimg);
				break;

			case "driving":
				driving.style.display = "flex";
				setVehicleColors(item.vehicles);
				setText("dlic-name", name);
				setText("dlic-lastname", lastname);
				setText("dlic-birth", birthday);
				setText("dlic-gender", g);
				setImage("dlic-photo", item.userimg);
				break;

			case "weapon":
				weapon.style.display = "flex";
				setText("wlic-name", name);
				setText("wlic-lastname", lastname);
				setText("wlic-birth", birthday);
				setText("wlic-identity", getLast8Chars(identity));
				setImage("wlic-photo", item.userimg);
				break;

			case "fishing":
				fishing.style.display = "flex";
				setText("fishing-name", fullName);
				setText("fishing-identity", getLast8Chars(identity));
				break;

			case "hunting":
				hunting.style.display = "flex";
				setText("hunting-name", fullName);
				setText("hunting-identity", getLast8Chars(identity));
				break;

			case "fire":
				fire.style.display = "flex";
				setText("fire-name", name);
				setText("fire-lastname", lastname);
				setText("fire-grade", jobgrade);
				setText("fire-identity", getLast8Chars(identity));
				setImage("fire-photo", item.userimg);
				break;

			case "taxi":
				taxi.style.display = "flex";
				setText("taxi-name", name);
				setText("taxi-lastname", lastname);
				setText("taxi-grade", jobgrade);
				setText("taxi-identity", getLast8Chars(identity));
				setImage("taxi-photo", item.userimg);
				break;
		}
	});

	document.onkeyup = function (e) {
		if (e.which === 27) {
			$.post("https://bit-licenses/exit", JSON.stringify({}));
		}
	};
});
