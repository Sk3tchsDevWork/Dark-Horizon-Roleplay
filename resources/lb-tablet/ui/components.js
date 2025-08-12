if (!globalThis.componentsLoaded) {
    globalThis.componentsLoaded = true;

    globalThis.fetchNui = async (event, data, scriptName) => {
        scriptName = scriptName || globalThis.resourceName;

        if (scriptName !== globalThis.resourceName) {
            console.warn(`The app ${appName} (${globalThis.resourceName}) is fetching from another resource (${scriptName}), this will soon be blocked by FiveM. Read more: https://forum.cfx.re/t/5261145`);
        }

        try {
            const response = await fetch(`https://${scriptName}/${event}`, {
                method: 'post',
                body: JSON.stringify(data)
            });

            if (!response.ok) throw new Error(`${response.status} - ${response.statusText}`);

            return await response.json();
        } catch (err) {
            console.error(`Error fetching ${event} from ${scriptName}`, err);
        }
    };

    globalThis.onNuiEvent = (eventName, cb) => {
        window.addEventListener('message', (event) => {
            if (event.data?.action === eventName) {
                cb(event.data.data);
            }
        });
    };

    globalThis.useNuiEvent = globalThis.onNuiEvent;

    let settingsListeners = [];

    globalThis.onNuiEvent('settingsUpdated', (settings) => {
        globalThis.settings = settings;

        settingsListeners.forEach((cb) => cb(settings));
    });

    globalThis.onSettingsChange = (cb) => {
        settingsListeners.push(cb);
    };

    for (const [name, component] of Object.entries(globalThis.components)) {
        globalThis[name] = component;
    }

    let addedHandlers = [];

    function refreshInputs(inputs) {
        inputs.forEach((input) => {
            if (addedHandlers.includes(input)) return console.log('already added handler for', input);

            input.addEventListener('focus', () => globalThis.fetchTablet('toggleInput', true));
            input.addEventListener('blur', () => globalThis.fetchTablet('toggleInput', false));
        });
    }

    refreshInputs(document.querySelectorAll('input, textarea'));

    const inputObserver = new MutationObserver((mutations) => {
        mutations.forEach((mutation) => {
            mutation.addedNodes.forEach((node) => {
                if (node.childNodes.length > 0) refreshInputs(node.querySelectorAll('input, textarea'));
                if (node.tagName === 'INPUT' || node.tagName === 'TEXTAREA') refreshInputs([node]);
            });
        });
    });

    inputObserver.observe(document.body, { childList: true, subtree: true });

    globalThis.postMessage('componentsLoaded', '*');
}
