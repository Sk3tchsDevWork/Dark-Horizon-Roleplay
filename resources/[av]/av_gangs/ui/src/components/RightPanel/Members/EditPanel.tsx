import { useState } from "react";
import {
  Box,
  MultiSelect,
  TextInput,
  Text,
  Button,
  Group,
  Avatar,
} from "@mantine/core";
import { useRecoilValue } from "recoil";
import { Gang } from "../../../reducers/atoms";
import { Member } from "../../../types/types";
import classes from "./panelStyle.module.css";
import { fetchNui } from "../../../hooks/useNuiEvents";

interface Properties {
  member: Member;
  show: (state: boolean) => void;
  lang: any;
}

export const EditPanel = ({ member, show, lang }: Properties) => {
  const [tempMember, setTempMember] = useState(member);
  const gang = useRecoilValue(Gang);

  const defaultPermissions = gang.permissions
    .filter((permission: any) => member.permissions.includes(permission.value))
    .map((permission) => permission.value);

  const handleUpdate = (field: string, value: any) => {
    const updated = { ...tempMember, [field]: value };
    setTempMember(updated);
  };
  const handleSave = () => {
    fetchNui("av_gangs", "updateMember", tempMember);
    show(false);
  };
  return (
    <Box className={classes.container}>
      <Box className={classes.box}>
        <Text fz="lg" fw={500} ta="center">
          {tempMember?.playerName}
        </Text>
        <Avatar
          src={tempMember?.photo}
          className={classes.photo}
          w={85}
          h={85}
        />
        <TextInput
          label={lang.members.photo}
          value={tempMember?.photo}
          size="xs"
          onChange={(e) => {
            handleUpdate("photo", e.target.value);
          }}
        />
        <TextInput
          label={lang.members.rank}
          value={tempMember?.rank}
          size="xs"
          mt="sm"
          onChange={(e) => {
            handleUpdate("rank", e.target.value);
          }}
        />
        <MultiSelect
          label={lang.members.permissions}
          data={gang.permissions}
          defaultValue={defaultPermissions}
          size="xs"
          mt="sm"
          onChange={(e) => {
            handleUpdate("permissions", e);
          }}
        />
        <Group mt="md" grow>
          <Button
            size="xs"
            color="red"
            variant="light"
            onClick={() => {
              show(false);
            }}
          >
            {lang.cancel}
          </Button>
          <Button size="xs" color="teal" variant="light" onClick={handleSave}>
            {lang.save}
          </Button>
        </Group>
      </Box>
    </Box>
  );
};
