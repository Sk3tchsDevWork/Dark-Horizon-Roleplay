Install these sounds into your interact-sound folder!

interact-sound\client\html\sounds


If you have a different version of interact-sound (such as the QB version) you may also need to add this code into your interact-sound:

Client:

RegisterNetEvent('InteractSound:PlayFromCoord_CL')
AddEventHandler('InteractSound:PlayFromCoord_CL',function(coord,maxDistance,soundFile,soundVolume)
    local CoordJoueur = GetEntityCoords(PlayerPedId())
    local distance = Vdist(coord.x,coord.y,coord.z,CoordJoueur.x,CoordJoueur.y,CoordJoueur.z)
    if distance < maxDistance then
        local Volume = (1-distance/maxDistance)*soundVolume
        SendNUIMessage({
            transactionType     = 'playSound',
            transactionFile     = soundFile,
            transactionVolume   = Volume
        })
    end
end)



Server:

RegisterServerEvent('InteractSound:PlayFromCoord')
AddEventHandler('InteractSound:PlayFromCoord',function(coord,maxDistance,soundfile,soundVolume)
    TriggerClientEvent('InteractSound:PlayFromCoord_CL',-1,coord,maxDistance,soundfile,soundVolume)
end)