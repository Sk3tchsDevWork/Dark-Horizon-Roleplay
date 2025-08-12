import { Box, Button, Text, Group } from "@mantine/core";
import classes from "./confirmStyle.module.css";

interface Properties {
  member: any;
  deleteMember: (identifier: string) => void;
  showConfirm: (state: boolean) => void;
  lang: any;
}

export const Confirm = ({
  member,
  deleteMember,
  showConfirm,
  lang,
}: Properties) => {
  const handleConfirm = () => {
    deleteMember(member.identifier);
    showConfirm(false);
  };
  return (
    <Box className={classes.container}>
      <Box className={classes.box}>
        <Text fw={500} fz="md" c="gray.3" ta="center">
          {lang.removeMember}
        </Text>
        <Text
          fz="sm"
          c="gray.6"
          mt="sm"
        >{`${lang.members.removeConfirmation} ${member.playerName}?`}</Text>
        <Group grow mt="md">
          <Button variant="subtle" color="teal" onClick={handleConfirm}>
            {lang.confirm}
          </Button>
          <Button
            variant="light"
            color="red"
            onClick={() => {
              showConfirm(false);
            }}
          >
            {lang.cancel}
          </Button>
        </Group>
      </Box>
    </Box>
  );
};
