import { Tabs, rem } from "@mantine/core";
import { IconSkull, IconPencilPlus } from "@tabler/icons-react";
import classes from "./tabStyle.module.css";
import { useRecoilValue } from "recoil";
import { Lang } from "../../../reducers/atoms";

interface Properties {
  activeTab: string | null;
  setTab: (option: string | null) => void;
}

export const TabComponent = ({ activeTab, setTab }: Properties) => {
  const lang: any = useRecoilValue(Lang);
  const iconStyle = { width: rem(12), height: rem(12) };
  return (
    <Tabs
      variant="default"
      defaultValue="gangs"
      color="red.4"
      classNames={classes}
      allowTabDeactivation={false}
      onChange={(e) => {
        setTab(e);
      }}
    >
      <Tabs.List>
        <Tabs.Tab value="gangs" leftSection={<IconSkull style={iconStyle} />}>
          {lang.admin.gangsTab}
        </Tabs.Tab>
        {activeTab == "gangs" && (
          <Tabs.Tab
            value="newGang"
            leftSection={<IconPencilPlus style={iconStyle} />}
            ml="auto"
            c="teal"
          >
            {lang.admin.newGangTab}
          </Tabs.Tab>
        )}
      </Tabs.List>
    </Tabs>
  );
};
