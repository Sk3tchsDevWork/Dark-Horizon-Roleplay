function setOptions(options) {
    const parent = document.getElementById('options');

    if (parent === null) return;

    parent.replaceChildren();
    parent.style.transition = 'margin-top 0.4s';

    let minWidth = 0;

    for (let i = 0; i < options.length; i++) {
        const option = options[i];

        const element = document.createElement('li');
        element.innerHTML =
            (option.icon && `<i class='${option.icon} fa-fw'>` || '') +
            `</i>${option.label}`;
        element.classList.add('option');

        parent.appendChild(element);

        // Temporarily disable transition
        let transition = element.style.transition;
        element.style.transition = 'none';

        // Temporarily add selected class
        element.classList.add('selected');

        const width = element.offsetWidth;
        minWidth = Math.max(minWidth, width);

        // Remove it after the width is measured
        element.classList.remove('selected');

        // Add back transition
        setTimeout(() => (element.style.transition = transition), 300);
    }

    const optionsList = document.getElementsByClassName('option');

    for (let i = 0; i < optionsList.length; i++) {
        optionsList[i].style.minWidth = `${minWidth + 20}px`;
    }

    optionsList[0].classList.add('selected');
}

function getOptions() {
    const options = document.getElementsByClassName('option');
    const filtered = [];

    for (let i = 0; i < options.length; i++) {
        if (options[i].style.display === 'block') {
            filtered.push(options[i]);
        }
    }

    return filtered;
}

function select(index) {
    // Magical calculation
    const offset = index * 39;
    const options = getOptions();

    for (let i = 0; i < options.length; i++) {
        if (options[i]?.classList)
            options[i].classList.remove('selected');
    }

    if (options[index]?.classList)
        options[index].classList.add('selected');
    document.getElementById('options').style.marginTop = `-${offset}px`;
}

function updateOptions(canInteract) {
    let elements = document.getElementsByClassName('option');

    for (let i = 0; i < canInteract.length; i++) {
        const display = canInteract[i] ? 'block' : 'none';

        if (elements[i] && elements[i].style.display != display) {
            elements[i].style.display = display;
        }
    }
}

window.addEventListener('message', ({ data }) => {
    if (data.action === 'set_options') {
        setOptions(data.options);
    } 
    else if (data.action === 'update_options') {
        updateOptions(data.canInteract);
    } 
    else if (data.action === 'set_index') {
        select(data.index);
    } 
    else if (data.action === 'show') {
        const prompt = document.getElementById('prompt');
        prompt.classList.remove('hidden');
    } 
    else if (data.action === 'hide') {
        const prompt = document.getElementById('prompt');

        if (prompt?.classList)
            prompt.classList.add('hidden');
        
        setTimeout(() => {
            const options = document.getElementById('options');

            options.style.transition = 'none';
            options.style.marginTop = null;
            options.replaceChildren();
        }, 100);
    }
    else if (data.action === 'show_objective') {
        document.getElementById('objective').classList.remove('hidden');
        document.getElementsByClassName('title')[0].textContent = data.title;
        document.getElementsByClassName('content')[0].textContent = data.content;
    }
    else if (data.action === 'hide_objective') {
        document.getElementById('objective').classList.add('hidden');
    }
    else if (data.action === 'show_bars') {
        const barsDiv = document.getElementById('bars');
        barsDiv.classList.remove('hidden');
        const existingLabels = Array.from(document.querySelectorAll('.bar-label span')).map(label => label.textContent);
        let newLabels = data.bars.map(bar => bar.label);
        
        if (JSON.stringify(existingLabels) !== JSON.stringify(newLabels)) {
            barsDiv.innerHTML = '';
            data.bars.forEach(bar => {
                const barContainer = document.createElement('div');
                barContainer.className = 'bar-container';
                
                const barLabel = document.createElement('div');
                barLabel.className = 'bar-label';
                
                const icon = document.createElement('i');
                icon.className = `fas fa-${bar.icon} fa-fw fa-sm`;
                
                const labelText = document.createElement('span');
                labelText.textContent = bar.label;
                
                barLabel.appendChild(icon);
                barLabel.appendChild(labelText);
                
                const progress = document.createElement('div');
                progress.className = 'progress';
                
                const progressBar = document.createElement('div');
                progressBar.className = 'progress-bar';
                progressBar.style.width = `${bar.percentage}%`;
                progressBar.style.backgroundColor = bar.color;
                
                progress.appendChild(progressBar);
                barContainer.appendChild(barLabel);
                barContainer.appendChild(progress);
                barsDiv.appendChild(barContainer);
            });
        } else {
            data.bars.forEach(bar => {
                const existingBarLabel = Array.from(document.querySelectorAll('.bar-label span')).find(label => label.textContent === bar.label);
                if (existingBarLabel) {
                    const progressBar = existingBarLabel.closest('.bar-container').querySelector('.progress-bar');
                    progressBar.style.width = `${bar.percentage}%`;
                    progressBar.style.backgroundColor = bar.color;
                }
            });
        }
    }
    else if (data.action === 'hide_bars') {
        document.getElementById('bars').classList.add('hidden');
    }
    else if (data.action === 'show_npc') {
        showNpcDialog(data);
    }
    else if (data.action === 'hide_npc') {
        hideNpcDialog();
    }
    else if (data.action === 'next_question') {
        updateNpcQuestion(data);
    }
});

// Function to handle text typing effect
let currentTypeInterval = null; // Track the current typing interval

function typeText(element, text, speed = 30) {
    // Clear any ongoing typing animation
    if (currentTypeInterval) {
        clearInterval(currentTypeInterval);
        currentTypeInterval = null;
    }
    
    element.textContent = '';
    element.classList.add('typing');
    
    let i = 0;
    currentTypeInterval = setInterval(() => {
        if (i < text.length) {
            element.textContent += text.charAt(i);
            i++;
        } else {
            clearInterval(currentTypeInterval);
            currentTypeInterval = null;
            element.classList.remove('typing');
        }
    }, speed);
}

// NPC Dialog System - Refactored for better reusability
const NPCDialog = {
    // DOM element references
    elements: {
        dialog: null,
        question: null,
        answersContainer: null,
        numberInputContainer: null,
        itemsContainer: null,
        numberInput: null,
        submitButton: null
    },

    // Track if interaction is locked
    interactionLocked: false,

    // Initialize element references
    init() {
        this.elements.dialog = document.getElementById('npc-interaction');
        this.elements.question = document.querySelector('.npc-question');
        this.elements.answersContainer = document.querySelector('.npc-answers-container');
        this.elements.numberInputContainer = document.querySelector('.npc-number-input-container');
        this.elements.itemsContainer = document.querySelector('.npc-items-container');
        this.elements.numberInput = document.querySelector('.npc-number-input');
        this.elements.submitButton = document.querySelector('.npc-submit-button');
        
        // Add escape key listener
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && !this.elements.dialog.classList.contains('hidden')) {
                this.hide();
                this.sendResponse({ type: 'escape', value: null });
            }
        });
    },

    // Show or update the dialog with new content
    update(data) {
        // Initialize elements if not already done
        if (!this.elements.dialog) this.init();
        
        // Reset interaction lock when showing a new question
        this.interactionLocked = false;
        
        // Clear previous content
        this.clearContent();
        
        // Update header if provided
        if (data.header) {
            const nameElement = this.elements.dialog.querySelector('.npc-name');
            const idElement = this.elements.dialog.querySelector('.npc-id');
            
            if (nameElement && data.header.name) {
                nameElement.textContent = data.header.name;
            }
            
            if (idElement && data.header.specifier) {
                idElement.textContent = data.header.specifier;
            }
        }
        
        // Add question with typing effect
        typeText(this.elements.question, data.question);
        
        // Determine which type of interaction to show
        if (data.answers && Array.isArray(data.answers)) {
            this.showAnswers(data.answers);
        } else if (data.answerNumberInput) {
            this.showNumberInput(data.answerNumberInput);
        } else if (data.answerItems && Array.isArray(data.answerItems)) {
            this.showItems(data.answerItems);
        }
        
        // Show the dialog
        this.elements.dialog.classList.remove('hidden');
    },
    
    // Clear all content containers
    clearContent() {
        this.elements.answersContainer.innerHTML = '';
        this.elements.itemsContainer.innerHTML = '';
    },
    
    // Hide all interaction containers
    hideAllContainers() {
        this.elements.answersContainer.style.display = 'none';
        this.elements.numberInputContainer.classList.add('hidden');
        this.elements.itemsContainer.classList.add('hidden');
    },
    
    // Show answer options
    showAnswers(answers) {
        this.hideAllContainers();
        this.elements.answersContainer.style.display = 'flex';
        
        answers.forEach(answer => {
            const answerElement = document.createElement('div');
            answerElement.className = `npc-answer ${getAnswerType(answer.id)}`;
            answerElement.dataset.id = answer.id;
            
            // Create icon if provided
            if (answer.icon) {
                const icon = document.createElement('i');
                // Check if the icon already has a prefix (fas, far, fab, etc.)
                if (answer.icon.startsWith('fa')) {
                    icon.className = `${answer.icon} fa-fw`;
                } else {
                    // Add the default 'fas' prefix if not provided
                    icon.className = `fas fa-${answer.icon} fa-fw`;
                }
                answerElement.appendChild(icon);
            }
            
            // Add label text
            const labelText = document.createTextNode(answer.label);
            answerElement.appendChild(labelText);
            
            // Add click event
            answerElement.addEventListener('click', () => {
                // Only process click if interaction is not locked
                if (!this.interactionLocked) {
                    // Lock interaction after click
                    this.interactionLocked = true;
                    this.sendResponse({ id: answer.id });
                }
            });
            
            this.elements.answersContainer.appendChild(answerElement);
        });
    },
    
    // Show number input
    showNumberInput(placeholder) {
        this.hideAllContainers();
        this.elements.numberInputContainer.classList.remove('hidden');
        
        // Reset and focus the input
        this.elements.numberInput.placeholder = placeholder;
        this.elements.numberInput.value = '';
        this.elements.numberInput.focus();
        
        // Remove previous event listeners
        const newSubmitButton = this.elements.submitButton.cloneNode(true);
        const newNumberInput = this.elements.numberInput.cloneNode(true);
        
        this.elements.submitButton.replaceWith(newSubmitButton);
        this.elements.numberInput.replaceWith(newNumberInput);
        
        // Update references
        this.elements.submitButton = newSubmitButton;
        this.elements.numberInput = newNumberInput;
        
        // Add event listeners
        this.elements.submitButton.addEventListener('click', () => {
            // Only process click if interaction is not locked
            if (!this.interactionLocked) {
                this.handleNumberSubmit();
            }
        });
        
        this.elements.numberInput.addEventListener('keypress', (e) => {
            // Only process keypress if interaction is not locked
            if (e.key === 'Enter' && !this.interactionLocked) {
                this.handleNumberSubmit();
            }
        });
    },
    
    // Handle number input submission
    handleNumberSubmit() {
        const value = this.elements.numberInput.value.trim();
        if (value !== '') {
            // Lock interaction after submission
            this.interactionLocked = true;
            this.sendResponse({ value: parseInt(value, 10) });
        }
    },
    
    // Show items list
    showItems(items) {
        this.hideAllContainers();
        this.elements.itemsContainer.classList.remove('hidden');
        
        items.forEach(item => {
            const itemElement = document.createElement('div');
            itemElement.className = 'npc-item';
            itemElement.dataset.name = item.name;
            
            // Create item image
            const itemImage = document.createElement('img');
            itemImage.className = 'npc-item-image';
            itemImage.src = item.imageUrl || 'https://via.placeholder.com/40?text=?';
            itemImage.alt = item.label;
            itemImage.onerror = function() {
                this.src = 'https://via.placeholder.com/40?text=!';
            };
            
            // Create item details container
            const itemDetails = document.createElement('div');
            itemDetails.className = 'npc-item-details';
            
            // Create item label
            const itemLabel = document.createElement('div');
            itemLabel.className = 'npc-item-label';
            itemLabel.textContent = item.label;
            
            // Assemble the item element
            itemDetails.appendChild(itemLabel);
            itemElement.appendChild(itemImage);
            itemElement.appendChild(itemDetails);
            
            // Add click event
            itemElement.addEventListener('click', () => {
                // Only process click if interaction is not locked
                if (!this.interactionLocked) {
                    // Lock interaction after click
                    this.interactionLocked = true;
                    this.sendResponse({ itemName: item.name });
                }
            });
            
            this.elements.itemsContainer.appendChild(itemElement);
        });
    },
    
    // Send response back to the game
    sendResponse(data) {
        // Send a single unified response with type field
        fetch(`https://${GetParentResourceName()}/npc_response`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({
                ...data
            })
        });
    },
    
    // Hide the dialog
    hide() {
        this.elements.dialog.classList.add('hidden');
        // Reset interaction lock when hiding
        this.interactionLocked = false;
    }
};

// Replace the old functions with the new system
function showNpcDialog(data) {
    NPCDialog.update(data);
}

function updateNpcQuestion(data) {
    NPCDialog.update(data);
}

function hideNpcDialog() {
    NPCDialog.hide();
}

// Helper function to determine answer type based on id
function getAnswerType(id) {
    // This is a simple logic that can be customized
    // Currently using a convention where ids starting with:
    // - "pos_" are positive (green)
    // - "neg_" are negative (red)
    // - others are neutral (blue)
    if (id.startsWith('pos_')) return 'positive';
    if (id.startsWith('neg_')) return 'negative';
    return 'neutral';
}