-- Minigame used when cracking a laptop password
function crackMinigame()
    if GetResourceState('av_alphabet') == "started" then
        return exports['av_alphabet']:start('both', 15, 10)
    end
    return true
end