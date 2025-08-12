-- Just in case u want to change the ox_lib text ui to a different one

function showTextUI(text, options) -- I personally don't use the options from ox_lib
    if isTextUIOpen() then
        hideTextUI()
    end
    lib.showTextUI(text, options)
end

function hideTextUI()
    lib.hideTextUI()
end

function isTextUIOpen()
    return lib.isTextUIOpen()
end

exports("showTextUI", showTextUI)
exports("hideTextUI", hideTextUI)
exports("isTextUIOpen", isTextUIOpen)
