const sfName = 'generic_texture_renderer';
const width = 1280;
const height = 720;
const Duis = []
let TickID
let volumeTick

var randomFixedInteger = function (length) {
    return Math.floor(Math.pow(10, length-1) + Math.random() * (Math.pow(10, length) - Math.pow(10, length-1) - 1));
}

async function loadScaleform(scaleform) {
    let scaleformHandle = RequestScaleformMovie(scaleform);
    if (HasScaleformMovieLoaded(scaleformHandle)) {
        return scaleformHandle
    }

    return new Promise(resolve => {
        const interval = setInterval(() => {
            if (HasScaleformMovieLoaded(scaleformHandle)) {
                clearInterval(interval);
                resolve(scaleformHandle);
            } else {
                scaleformHandle = RequestScaleformMovie(scaleform);
            }
      }, 0);
    });
}

function calcDistance(x1, y1, z1, x2, y2, z2) {
    var dx = x1 - x2;
    var dy = y1 - y2;
    var dz = z1 - z2;

    return Math.sqrt( dx * dx + dy * dy + dz * dz );
}

on("17movTV:Player:StopDUI", (id) => {
    let DuiObj = Duis[id].duiObj
    Duis[id] = undefined
    DestroyDui(DuiObj)
})

on("17movTV:Player:VolumeChange", (id, newVolume) => {
    if (Duis[id] != undefined) {
        Duis[id].newVolume = Math.round((newVolume + Number.EPSILON) * 100) / 100
    }
})

on("17movTV:Player:AddToPlayerList", async (link, id, x,y,z, scaleX, scaleY, obj, SFIndex, platform, volume, maxDistance) => {
    sfHandle = await loadScaleform(sfName + SFIndex);
    let table = []
    table.SFHandle = sfHandle
    table.duiObj = CreateDui(link, width, height);
    table.SFIndex = SFIndex
    table.dui = GetDuiHandle(table.duiObj);
    table.txd = randomFixedInteger(25)
    table.txn = randomFixedInteger(25)
    table.x = x
    table.y = y
    table.z = z
    table.obj = obj
    table.scaleX = scaleX
    table.scaleY = scaleY
    table.txdHasBeenSet = false
    table.volume = 0
    table.newVolume = Math.round((volume + Number.EPSILON) * 100) / 100
    table.platform = platform
    table.maxDistance = maxDistance

    CreateRuntimeTextureFromDuiHandle(CreateRuntimeTxd(table.txd), table.txn, table.dui)
    Duis[id] = table
})

on("QBCore:Client:OnPlayerLoaded", () => {
    SetScaleformMovieAsNoLongerNeeded(sfName + "1")
    SetScaleformMovieAsNoLongerNeeded(sfName + "2")
    SetScaleformMovieAsNoLongerNeeded(sfName + "3")
    SetScaleformMovieAsNoLongerNeeded(sfName + "4")
    SetScaleformMovieAsNoLongerNeeded(sfName + "5")
})

on("17movTV:PLAYER:StopMainThrd", () => {
    clearTick(TickID)
    clearTick(volumeTick)
})


on("17movTV:PLAYER:StartMainThrd", () => {
    TickID = setTick( async () => {
        for (var k in Duis){
            if (Duis[k] != undefined && Duis[k].x != undefined) {
                let myPos = GetEntityCoords(PlayerPedId())
                let distance = calcDistance(myPos[0], myPos[1], myPos[2], Duis[k].x, Duis[k].y, Duis[k].z) 
                if (distance < Duis[k].maxDistance) {
                    if (Duis[k].SFHandle !== null && !Duis[k].txdHasBeenSet) {
                        PushScaleformMovieFunction(Duis[k].SFHandle, 'SET_TEXTURE');
                        PushScaleformMovieMethodParameterString(Duis[k].txd); // txd
                        PushScaleformMovieMethodParameterString(Duis[k].txn); // txn
                        PushScaleformMovieFunctionParameterInt(0); // x
                        PushScaleformMovieFunctionParameterInt(0); // y
                        PushScaleformMovieFunctionParameterInt(width);
                        PushScaleformMovieFunctionParameterInt(height);
                        PopScaleformMovieFunctionVoid();
                        Duis[k].rotation = GetEntityRotation(Duis[k].obj);
                        Duis[k].txdHasBeenSet = true;
                    }
                    if (Duis[k].rotation[0] == 0) {
                        DrawScaleformMovie_3dNonAdditive(Duis[k].SFHandle, Duis[k].x, Duis[k].y, Duis[k].z, 0.0, GetEntityHeading(Duis[k].obj) * -1, 0.0, 2,2,2, Duis[k].scaleX * 1, Duis[k].scaleY * (9 / 16), 1, 2);
                    } else {
                        DrawScaleformMovie_3dNonAdditive(Duis[k].SFHandle, Duis[k].x, Duis[k].y, Duis[k].z, Duis[k].rotation[0], 0, Duis[k].rotation[2], 2,2,2, Duis[k].scaleX * 1, Duis[k].scaleY * (9 / 16), 1, 2);
                    }
                } else {
                    if (Duis[k] != undefined) {
                        DestroyDui(Duis[k].duiObj)
                        emit("17movTV:LeftArea", k)
                        emit("17movTV:ResetThisScaleform", Duis[k].SFIndex)
                        Duis[k] = undefined
                    }
                }
            }
        }
    });
    volumeTick = setTick( async () => {
        for (var k in Duis){
            if (Duis[k] != undefined && Duis[k].x != undefined) {
                if (Duis[k].volume != Duis[k].newVolume) {
                    Duis[k].volume = Duis[k].newVolume
                    let duiObj = Duis[k].duiObj
                    SendDuiMouseMove(duiObj, 75, 700)
                    await new Promise(r => setTimeout(r, 250));
                    if (Duis[k].platform == "OnlyTube") {
                        let newVolume = Math.ceil((Duis[k].newVolume / 10) * 50)
                        if (newVolume == 5) {
                            newVolume = 7
                        }
                        SendDuiMouseMove(duiObj, 99 + newVolume, 702)
                    } else if (Duis[k].platform == "OnlyClips" || Duis[k].platform == "OnlyVideo") {
                        let newVolume = Math.ceil((Duis[k].newVolume / 10) * 105)
                        SendDuiMouseMove(duiObj, 71 + newVolume, 702)
                    } else if (Duis[k].platform == "OnlyStream") {
                        let newVolume = Math.ceil((Duis[k].newVolume / 10) * 40)
                        SendDuiMouseMove(duiObj, 75 + newVolume, 702)
                    }

                    await new Promise(r => setTimeout(r, 5));
                    SendDuiMouseDown(duiObj, 'left')
                    await new Promise(r => setTimeout(r, 7));
                    SendDuiMouseUp(duiObj, 'left')
                    SendDuiMouseMove(duiObj, 75, 500)
                }

            }
        }
    })
});

on('onResourceStop', (resName) => {
    if (resName === GetCurrentResourceName()) {
        SetScaleformMovieAsNoLongerNeeded(sfName + "1")
        SetScaleformMovieAsNoLongerNeeded(sfName + "2")
        SetScaleformMovieAsNoLongerNeeded(sfName + "3")
        SetScaleformMovieAsNoLongerNeeded(sfName + "4")
        SetScaleformMovieAsNoLongerNeeded(sfName + "5")
    }
})

