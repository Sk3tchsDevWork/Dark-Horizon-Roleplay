import { Box } from "@mantine/core";
import classes from "./adminStyle.module.css";
import { TabComponent } from "./Tabs/Tabs";
import { useState } from "react";
import { Gangs } from "./Gangs/Gangs";
import { NewGang } from "./NewGang/NewGang";

export const Admin = () => {
  const [activeTab, setActiveTab] = useState<string | null>("gangs");
  return (
    <Box className={classes.container}>
      <Box className={classes.box}>
        <TabComponent activeTab={activeTab} setTab={setActiveTab} />
        <Box className={classes.tabs} p="sm">
          {activeTab == "gangs" && <Gangs />}
          {activeTab == "newGang" && <NewGang />}
        </Box>
      </Box>
    </Box>
  );
};
