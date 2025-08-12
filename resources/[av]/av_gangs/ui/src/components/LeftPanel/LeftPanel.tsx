import { Stack, Box, Text, Group } from "@mantine/core";
import classes from "./leftStyle.module.css";
import { useRecoilValue } from "recoil";
import { Gang, Lang } from "../../reducers/atoms";
import { IconArrowLeft } from "@tabler/icons-react";

interface Properties {
  tab: string;
  setTab: (option: string) => void;
}

export const LeftPanel = ({ tab, setTab }: Properties) => {
  const gang = useRecoilValue(Gang);
  const lang: any = useRecoilValue(Lang);
  return (
    <Stack className={classes.container} gap="xs">
      <Box className={classes.box}>
        <Text fw={500}>Members</Text>
        <Text fz="xs" c="dimmed">
          {lang.leftPanel.activeMembers}
        </Text>
        <Box className={classes.data}>{gang.members}</Box>
      </Box>
      <Box className={classes.box}>
        <Text fw={500}>{lang.leftPanel.strain}</Text>
        <Text fz="xs" c="dimmed">
          {lang.leftPanel.strainName}
        </Text>
        <Box className={classes.data} p={3}>
          {gang.strain}
        </Box>
      </Box>
      <Box className={classes.box}>
        <Text fw={500}>{lang.leftPanel.graffitis}</Text>
        <Text fz="xs" c="dimmed">
          {lang.leftPanel.graffitisCount}
        </Text>
        <Box className={classes.data}>{gang.graffitis}</Box>
      </Box>
      {tab !== "home" && (
        <Box
          className={classes.home}
          color="teal.3"
          variant="default"
          onClick={() => {
            setTab("home");
          }}
        >
          <Group justify="center" gap="sm">
            <IconArrowLeft
              stroke={2}
              style={{ width: "12px", height: "12px" }}
            />
            <Text fz="sm">{lang.return}</Text>
          </Group>
        </Box>
      )}
    </Stack>
  );
};
