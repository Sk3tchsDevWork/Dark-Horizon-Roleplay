import { useState } from "react";
import { Box, Grid, Image, Text } from "@mantine/core";
import { useRecoilValue } from "recoil";
import { Gang, Lang, Permissions } from "../../../reducers/atoms";
import { calculateLevel } from "../../../hooks/calculateLevel";
import classes from "./homeStyle.module.css";

interface Properties {
  setTab: (option: string) => void;
}

const Home = ({ setTab }: Properties) => {
  const lang: any = useRecoilValue(Lang);
  const [hover, setHover] = useState(999);
  const gang = useRecoilValue(Gang);
  const permissions = useRecoilValue(Permissions);
  const level = calculateLevel(gang.level, gang.max);
  const hasPermission = (myPermissions: string[], tabPermissions: string[]) => {
    return tabPermissions.some((permission) =>
      myPermissions.includes(permission)
    );
  };
  const tabs = [
    {
      tab: "members",
      image: "members.png",
      label: lang.home.members,
      level: 0,
      span: 8,
      permissions: [],
    },
    {
      tab: "settings",
      image: "settings.webp",
      label: lang.home.settings,
      level: 0,
      span: 4,
      permissions: ["isBoss"],
    },
    {
      tab: "missions",
      image: "missions.png",
      label: lang.home.missions,
      level: 0,
      span: 4,
      permissions: ["isBoss", "missions"],
    },
    {
      tab: "blackmarket",
      image: "blackmarket.png",
      label: lang.home.blackmarket,
      level: 0,
      span: 4,
      permissions: ["isBoss", "blackmarket"],
    },
    {
      tab: "properties",
      image: "properties.webp",
      label: lang.home.properties,
      level: 0,
      span: 4,
      permissions: ["isBoss", "properties"],
    },
  ];
  return (
    <Grid gutter="sm" className={classes.container}>
      {tabs.map((option, index) => (
        <Grid.Col span={option.span} key={option.tab}>
          <Box className={classes.box}>
            <Box className={classes.textBox}>
              {option.tab == "members" ? (
                <>
                  <Text
                    className={classes.text}
                    fz="xl"
                    fw={500}
                    onClick={() => {
                      setTab(option.tab);
                    }}
                  >
                    {option.label}
                  </Text>
                </>
              ) : (
                <>
                  {level.level >= option.level &&
                  hasPermission(permissions, option.permissions) ? (
                    <>
                      <Text
                        className={classes.text}
                        fz="xl"
                        fw={500}
                        onClick={() => {
                          setTab(option.tab);
                        }}
                      >
                        {option.label}
                      </Text>
                    </>
                  ) : (
                    <Box
                      display="block"
                      ta="center"
                      onMouseEnter={() => {
                        setHover(index);
                      }}
                      onMouseLeave={() => {
                        setHover(999);
                      }}
                    >
                      <Text className={classes.text} fz="xl" fw={500}>
                        {lang.home.locked}
                      </Text>
                      {hover === index && (
                        <Text fz="xs" fw={500} c="dimmed">
                          {lang.home.noPermissions}
                        </Text>
                      )}
                    </Box>
                  )}
                </>
              )}
            </Box>
            <Image className={classes.image} src={`tabs/${option.image}`} />
          </Box>
        </Grid.Col>
      ))}
    </Grid>
  );
};

export default Home;
