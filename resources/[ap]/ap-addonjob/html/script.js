$("#docsUI").hide();
$("#image-form-container").hide();

let config = {};
let ApplicationData = {};

addEventListener("message", async function (event) {
  var eventData = event.data;

  if (eventData.type == "openJobApplicationUI") {
    ApplicationData = eventData.data
    showApplicationUI();
  } else if (eventData.type == "closeJobApplicationUI") {
    closeApplicationUI();
  } else if (eventData.type == "openLogoUI") {
    openLogoUI(eventData.data);
  }
});

function openLogoUI(data) {
  console.log(JSON.stringify(data))
  const uiContainer = document.createElement('div');
  uiContainer.classList.add('fixed', 'top-0', 'left-0', 'w-full', 'h-full', 'flex', 'justify-center', 'items-center', 'bg-gray-900', 'bg-opacity-50', 'hidden');

  const uiBox = document.createElement('div');
  uiBox.classList.add('rounded-lg', 'p-8', 'bg-[#25262B]');

  const currentLabel = document.createElement('label');
  currentLabel.textContent = 'Current Image:';
  currentLabel.classList.add('block', 'text-[#C1C2C5]', 'font-bold', 'mb-2');

  const imgCurrent = document.createElement('img');
  imgCurrent.classList.add('w-64', 'h-64', 'object-contain', 'mb-4');
  imgCurrent.src = data.management.logo;
  imgCurrent.style.display = 'block';

  const inputLabel = document.createElement('label');
  inputLabel.textContent = 'Image URL:';
  inputLabel.classList.add('block', 'text-[#C1C2C5]', 'font-bold', 'mb-2');

  const inputField = document.createElement('input');  //[#1971c2]
  inputField.setAttribute('type', 'text');
  inputField.setAttribute('placeholder', 'Enter image URL');
  inputField.classList.add('w-full', 'border', 'border-[#373a40]', 'bg-[#25262b]', 'rounded', 'py-2', 'px-3', 'mb-4', 'leading-tight', 'focus:outline-none', 'focus:border-[#1971c2]', 'focus:ring-[#1971c2]', 'placeholder-[#b6b7ba]', 'text-[#b6b7ba]');

  const imgPreview = document.createElement('img');
  imgPreview.classList.add('w-64', 'h-64', 'object-contain', 'mb-4');
  imgPreview.style.display = 'none';

  const submitButton = document.createElement('button');
  submitButton.textContent = 'Submit';
  submitButton.classList.add('inline-block', 'align-middle', 'bg-blue-500', 'hover:bg-blue-700', 'text-white', 'font-bold', 'py-2', 'px-4', 'rounded', 'focus:outline-none', 'focus:shadow-outline');
  submitButton.style.display = 'none';

  inputField.addEventListener('input', function(e) {
    const url = e.target.value;
    if (url.match(/\.(jpeg|jpg|gif|png)$/) != null) {
      imgPreview.src = url;
      imgPreview.style.display = 'block';
      submitButton.style.display = 'block';
    } else {
      imgPreview.style.display = 'none';
      submitButton.style.display = 'none';
    }
  });

  submitButton.addEventListener('click', function() {
    const url = inputField.value;
    luaFunction(url);
    uiContainer.style.display = 'none';
  });

  onkeydown = (event) => {
    const charCode = event.key;
    if (charCode == "Escape") {
      uiContainer.style.display = 'none';
      $.post(`https://${GetParentResourceName()}/managementMenu`, JSON.stringify(data));
    }
  };

  uiBox.appendChild(currentLabel);
  uiBox.appendChild(imgCurrent);
  uiBox.appendChild(inputLabel);
  uiBox.appendChild(inputField);
  uiBox.appendChild(imgPreview);
  uiBox.appendChild(submitButton);
  uiContainer.appendChild(uiBox);
  document.body.appendChild(uiContainer);

  uiContainer.style.display = 'flex';

  function luaFunction(url) {
    data.management.logo = url
    $.post(`https://${GetParentResourceName()}/updateLogo`, JSON.stringify(data));
  }
}

async function fetchConfigData() {
  await $.post(
    `https://${GetParentResourceName()}/getApplicationConfig`,
    JSON.stringify({}),
    function (fetchedConfig) {
      config.type = fetchedConfig.type;
      config.title = fetchedConfig.title;
      config.logo = fetchedConfig.logo;
      config.from = fetchedConfig.from;
      config.description = fetchedConfig.description;
      config.information = fetchedConfig.information;
      config.extended_information = fetchedConfig.extended_information;
    }
  );

  const documentUI = document.getElementById("docsUI");

  let informationLables = "";
  let extendedInformationLabels = "";
  let extendedInformationGrid = "";

  config.information.forEach((inputField) => {
    if (inputField.type === "text_input") {
      informationLables += `
        <div>
          <label for="${
            inputField.id
          }" class="block mb-2 text-sm font-medium text-gray-900">${
        inputField.label
      }</label>
          <input ${
            config.type === "show" || config.type === "create" ? `disabled value="${inputField.value}"` : ""
          } type="text" id="${
        inputField.id
      }" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm block w-full p-2.5" placeholder="${
        inputField.placement
      }" ${inputField?.required === "true" ? `required` : ``}>
        </div>
      `;
    }
  });

  config.extended_information.forEach((extendedInputField) => {
    if (extendedInputField.type === "text_area") {
      extendedInformationLabels += `
      <div>
        <label for="${
          extendedInputField.id
        }" class="block mb-2 text-sm font-medium text-gray-900">${
        extendedInputField.label
      }</label>
        <textarea ${
          config.type === "show" ? `disabled` : ""
        } rows="3" type="text" id="${
        extendedInputField.id
      }" class="mb-2 mt-0 resize-y bg-gray-50 border border-gray-300 text-gray-900 text-sm block w-full p-2.5" maxlength="3800" placeholder="${
        extendedInputField.placement
      }" ${extendedInputField?.required === "true" ? `required` : ``}>${
        config.type === "show" ? extendedInputField.value : ""
      }</textarea>
      </div>
    `;
    } else if (extendedInputField.type === "text_input") {
      extendedInformationGrid += `
      <div>
        <label for="${
          extendedInputField.id
        }" class="block mb-2 text-sm font-medium text-gray-900">${
        extendedInputField.label
      }</label>
        <input ${
          config.type === "show"
            ? `disabled value="${extendedInputField.value}"`
            : ""
        } type="text" id="${
        extendedInputField.id
      }" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm block w-full p-2.5" placeholder="${
        extendedInputField.placement
      }" ${extendedInputField?.required === "true" ? `required` : ``}>
      </div>
      `;
    }
  });

  documentUI.innerHTML = `
    <div class="flex flex-row justify-between items-center m-7">
      <img class="w-40 h-40" src="${config.logo}"/>
      <div class="ml-10 w-90">
        <h1 class="text-3xl whitespace-nowrap font-bold">${config.title}</h1>

        <div class="flex flex-col justify-start items-start mb-3 mt-3">
          <h2 class="font-bold">${config.description}</h2>
          <h2 class="font-medium">PLEASE FILL THE REQUIRED INPUTS</h2>
        </div>
      </div>
    </div>

    <form id="docsSubmit">
      <div class="m-7">
        <div class="mt-3 bg-black text-white text-center">
          <h3>APPLICANT INFORMATION</h3>
        </div>

        <div class="mt-3 grid gap-6 mb-6 md:grid-cols-2">
          ${informationLables}
        </div>

        <div class="mt-3 bg-black text-white text-center">
          <h3>APPLICATION</h3>
        </div>

        ${
          extendedInformationGrid === ""
            ? ``
            : `
        <div class="mt-3 grid gap-6 mb-6 md:grid-cols-2">
          ${extendedInformationGrid}
        </div>
        `
        }

        <div class="mt-3">
          ${extendedInformationLabels}
        </div>

        <div class="flex mb-0 flex-row justify-between items-center mt-3 text-center text-white">
        <button type="button" class="m-1 mb-0 p-3 bg-black mr-0 ml-0" onclick="closeApplicationUI('${config.type}')">Close</button>
            <div>
              <button id="submitSign" type="submit" ${
                config.type === "show"
                  ? 'disabled class="hidden m-1 mb-0 p-3 bg-black mr-0 ml-0"'
                  : "class='m-1 mb-0 p-3 bg-black mr-0 ml-0'"
              }>Submit</button>
            </div>
        </div>
      </div>
    </form>
  `;

  $(document).ready(function () {
    $("#docsSubmit").submit(function (e) {
      e.preventDefault();

      let information = {};
      let extended_information = {};

      $("form#docsSubmit :input").each(function () {
        var input = $(this);
        let inputVal = input.val();
        let inputId = input.attr("id");
        
        config.information.forEach((info) => {
          if (info.id === inputId) information[info.id] = inputVal;
        });

        config.extended_information.forEach((extendedInfo) => {
          if (extendedInfo.id === inputId) extended_information[extendedInfo.id] = inputVal;
          
        });
      });

      if (config.type == "create") {
        $.post('https://ap-addonjob/sendApplication', JSON.stringify({ApplicationData, extended_information, information}));
      } else if (config.type == "show") {
        $.post('https://ap-addonjob/viewApplication', JSON.stringify({ApplicationData, extended_information, information}));
      }
      closeApplicationUI(config.type);
    });
  });
}

function showApplicationUI() {
  fetchConfigData();
  $("#docsUI").show();
}

function closeApplicationUI(data) {
  $("#docsUI").hide();
  config = {};
  if (data == "create") {
    $.post(`https://${GetParentResourceName()}/close`);
  } else if (data == "show") {
    $.post('https://ap-addonjob/returnManagement', JSON.stringify({ApplicationData}));
  }
  ApplicationData = {};
}
