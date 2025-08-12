import { Flex, Group, Image, Text, Box } from "@mantine/core";
import { ProgressBar } from "./ProgressBar/ProgressBar";
import { useRecoilValue } from "recoil";
import { Gang, Lang } from "../../reducers/atoms";
import { isEnvBrowser } from "../../hooks/useNuiEvents";
import classes from "./headerStyle.module.css";

export const Header = () => {
  const gang = useRecoilValue(Gang);
  const lang: any = useRecoilValue(Lang);
  return (
    <Group className={classes.header} p="sm" gap="sm">
      <Group gap="sm" mah={70}>
        <Image
          className={classes.image}
          src={gang.logo}
          h={70}
          fallbackSrc="https://files.fivemerr.com/images/802711ed-9bf4-4e79-b39e-4c53a9d8e540.png"
        />
        <Text className={classes.name} fz="md">
          {gang.label}
        </Text>
      </Group>
      {!isEnvBrowser() && (
        <Box className={classes.bar}>
          <ProgressBar lang={lang} />
        </Box>
      )}
      <Flex
        justify="flex-start"
        align="flex-end"
        direction="column"
        wrap="wrap"
        ml="auto"
      >
        <Text fz="xs" c="dimmed">
          {lang.header.daily}
        </Text>
        <Text
          fz="sm"
          c="gray.5"
          fw={500}
        >{`${gang.daily} / ${gang.dailyMax}`}</Text>
      </Flex>
    </Group>
  );
};
