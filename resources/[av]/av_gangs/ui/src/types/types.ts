interface Permission {
  value: string;
  label: string;
}

export interface GangType {
  name: string;
  label: string;
  logo: string;
  level: number;
  members: number;
  missions: number;
  graffitis: number;
  max: number;
  dailyMax: number;
  daily: number;
  strain: string;
  permissions: Permission[];
}

export interface Member {
  identifier: string;
  playerName: string;
  name: string;
  rank: string;
  photo: string;
  joined: string;
  permissions: Permission[];
}

type UpgradeKeys = "stash" | "production" | "security";

interface Price {
  price: number;
  level: number;
}

export interface PropertyType {
  identifier: string;
  entry: Object;
  working: boolean;
  label: string;
  type: string;
  shell: string;
  photo: string;
  upgrades: {
    [key in UpgradeKeys]: number;
  };
  raided: boolean;
  isOpen: boolean;
  nextCook: number;
  availableUpgrades: {
    [key in UpgradeKeys]: {
      label: string;
      prices: Price[];
      value: UpgradeKeys;
    };
  };
}
