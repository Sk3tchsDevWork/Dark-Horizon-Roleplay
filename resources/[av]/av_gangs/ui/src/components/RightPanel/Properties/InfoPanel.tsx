import { Box, Text } from "@mantine/core";
import classes from "./propertieStyle.module.css";

export const InfoPanel = ({ lang }: any) => {
  const { panel } = lang.properties;
  return (
    <Box className={classes.panelBox}>
      <Text className={classes.text} ta="center" fz="lg" fw={500}>
        {panel.header}
      </Text>
      <Text className={classes.text} fz="md" fw={500} mt="sm">
        {panel.upgrades}
      </Text>
      <Text className={classes.text} fz="sm" c="dimmed" ml="xs" mt="xs">
        <strong>{panel.stash}</strong>
        {panel.stash2}
      </Text>
      <Text className={classes.text} fz="sm" c="dimmed" ml="xs" mt={4}>
        <strong>{panel.production}</strong>
        {panel.production2}
      </Text>
      <Text className={classes.text} fz="sm" c="dimmed" ml="xs" mt={4}>
        <strong>{panel.security}</strong>
        {panel.security2}
      </Text>
    </Box>
  );
};
