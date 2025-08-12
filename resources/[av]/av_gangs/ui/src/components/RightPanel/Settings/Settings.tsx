import { useState } from "react";
import {
  Box,
  Group,
  TextInput,
  Button,
  Text,
  NumberInput,
} from "@mantine/core";
import { useRecoilState, useRecoilValue } from "recoil";
import { Gang, Lang } from "../../../reducers/atoms";
import classes from "./settingStyle.module.css";
import { fetchNui } from "../../../hooks/useNuiEvents";

const Settings = () => {
  const [gang, setGang] = useRecoilState(Gang);
  const [answer, setAnswer] = useState<number | string>(0);
  const lang: any = useRecoilValue(Lang);
  const deleteGang = () => {
    if (answer !== 4) return;
    const name = gang.name;
    fetchNui("av_gangs", "deleteGang", name);
  };
  const saveGang = () => {
    fetchNui("av_gangs", "updateGang", gang);
  };
  const handleUpdate = (field: string, value: string) => {
    const newGang = { ...gang, [field]: value };
    setGang(newGang);
  };
  const handleImage = async (value: string) => {
    const newGang = { ...gang, ["logo"]: value };
    setGang(newGang);
  };
  return (
    <Box className={classes.container}>
      <Group w="100%">
        <Text fw={500} fz="sm">
          {lang.settings.logo}
        </Text>
        <TextInput
          value={gang.logo}
          size="xs"
          w="30%"
          onChange={(e) => {
            handleImage(e.target.value);
          }}
        />
        <Button size="xs" color="teal" variant="subtle" onClick={saveGang}>
          {lang.settings.update}
        </Button>
      </Group>
      <Group mt="md" w="100%">
        <Text fw={500} fz="sm">
          {lang.leftPanel.strainName}
        </Text>
        <TextInput
          value={gang.strain}
          size="xs"
          w="30%"
          onChange={(e) => {
            handleUpdate("strain", e.target.value);
          }}
        />
        <Button size="xs" color="teal" variant="subtle" onClick={saveGang}>
          {lang.settings.update}
        </Button>
      </Group>
      <Group mt="md" w="100%">
        <Text fw={500} fz="sm">
          {lang.admin.deleteGang}
        </Text>
        <NumberInput
          placeholder="2+2 = ?"
          size="xs"
          w="10%"
          onChange={(e) => {
            setAnswer(e);
          }}
        />
        <Button
          size="xs"
          color="teal"
          variant="subtle"
          disabled={answer !== 4}
          onClick={deleteGang}
        >
          {lang.confirm}
        </Button>
      </Group>
    </Box>
  );
};

export default Settings;
