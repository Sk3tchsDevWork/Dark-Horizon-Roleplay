window.addEventListener('load', () => {
    console.log("UI script loaded");
    fetch(`https://${GetParentResourceName()}/getBankInfo`, {
        method: 'POST',
        body: JSON.stringify({})
    });
});

window.addEventListener('message', (event) => {
    if (event.data.type === 'updateBankInfo') {
        document.getElementById('account-name').textContent = event.data.account_name || 'Unknown';
        document.getElementById('account-balance').textContent = event.data.account_balance ? `$${event.data.account_balance}` : 'N/A';
        document.getElementById('account-type').textContent = event.data.account_type || 'N/A';
    }
});