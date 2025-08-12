import { atom } from "recoil";
import { GangType } from "../types/types";

export const Lang = atom<Object>({
  key: "lang",
  default: {},
});

export const Gang = atom<GangType>({
  key: "gang",
  default: {
    name: "lossantosvagos",
    label: "Los Santos Vagos",
    logo: "https://r2.fivemanage.com/QmVAYSlqeAlD4IxVbdvu5/VagosSpray.png",
    level: 5000,
    members: 3,
    missions: 2,
    graffitis: 11,
    max: 2500,
    daily: 0,
    dailyMax: 0,
    strain: "",
    permissions: [
      { value: "members", label: "Members" },
      { value: "missions", label: "Missions" },
      { value: "labs", label: "Labs" },
      { value: "stashes", label: "Stashes" },
      { value: "blackmarket", label: "Black Market" },
    ],
  },
});

export const Permissions = atom<any>({
  key: "permissions",
  default: {},
});

export const Identifier = atom<string>({
  key: "identifier",
  default: "",
});
