import { Box, Text } from "@mantine/core";
import classes from "./infoStyle.module.css";

export const InfoPanel = ({ lang }: any) => {
  const { blackmarket } = lang;
  return (
    <Box className={classes.panelBox}>
      <Text className={classes.text} ta="center" fz="lg" fw={500}>
        {blackmarket.info.header}
      </Text>
      <Text className={classes.text} fz="sm" c="dimmed" ml="xs" mt="xs">
        <strong>{blackmarket.info.entrance}</strong>
        {blackmarket.info.entranceText}
      </Text>
      <Text className={classes.text} fz="sm" c="dimmed" ml="xs" mt="xs">
        {blackmarket.info.admin}
      </Text>
    </Box>
  );
};
