import { Box, Group, Text, Progress } from "@mantine/core";
import classes from "./progressStyle.module.css";
import { useRecoilValue } from "recoil";
import { Gang } from "../../../reducers/atoms";
import { calculateLevel } from "../../../hooks/calculateLevel";

export const ProgressBar = ({ lang }: any) => {
  const gang = useRecoilValue(Gang);
  const result = calculateLevel(gang.level, gang.max);
  return (
    <>
      <Group justify="space-between">
        <Text fz="xs" fw={500}>
          {lang.header.influence}
        </Text>
        <Text
          ml="auto"
          fz="xs"
          fw={500}
        >{`${lang.header.level} ${result.level}`}</Text>
      </Group>
      <Progress.Root size="xl" h={13}>
        <Progress.Label
          className={classes.label}
        >{`${result.remaining} / ${gang.max}`}</Progress.Label>
        <Progress.Section value={result.percentage} color="teal" />
      </Progress.Root>
    </>
  );
};
