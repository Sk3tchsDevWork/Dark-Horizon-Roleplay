import { useState } from "react";
import { Box, Button, Text, NumberInput, TextInput } from "@mantine/core";
import { fetchNui } from "../../../hooks/useNuiEvents";
import classes from "./style.module.css";
import { useRecoilValue } from "recoil";
import { Lang } from "../../../reducers/atoms";

export const NewGang = () => {
  const lang: any = useRecoilValue(Lang);
  const [name, setName] = useState<string>("");
  const [boss, setBoss] = useState<string | number>("");
  const handleCreate = () => {
    fetchNui("av_gangs", "newGang", { name, boss });
    setName("");
    setBoss("");
  };
  return (
    <Box className={classes.wrapper}>
      <Box className={classes.container}>
        <Box className={classes.box}>
          <Text fw={500} fz="md" ta="center">
            {lang.admin.createGang}
          </Text>
          <TextInput
            value={name}
            styles={{
              input: {
                backgroundColor: "transparent",
              },
            }}
            mt="md"
            label={lang.admin.gangName}
            placeholder={lang.admin.warning}
            required
            size="xs"
            onChange={(e) => {
              setName(e.target.value);
            }}
          />
          <NumberInput
            value={boss}
            styles={{
              input: {
                backgroundColor: "transparent",
              },
            }}
            label={lang.admin.bossId}
            placeholder={lang.playerId}
            mt="md"
            min={1}
            size="xs"
            allowDecimal={false}
            allowNegative={false}
            onChange={(e) => {
              setBoss(e);
            }}
          />
          <Button
            mt="md"
            ml="auto"
            mr="auto"
            size="xs"
            color="teal"
            variant="light"
            fullWidth
            ta="center"
            disabled={!name}
            onClick={handleCreate}
          >
            {lang.create}
          </Button>
        </Box>
      </Box>
    </Box>
  );
};
