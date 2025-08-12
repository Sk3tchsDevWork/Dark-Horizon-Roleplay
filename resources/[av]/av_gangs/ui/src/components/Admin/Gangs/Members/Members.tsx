import { useState, useEffect } from "react";
import { Box, Table, ActionIcon, Tooltip, Avatar } from "@mantine/core";
import { IconEraser } from "@tabler/icons-react";
import { fetchNui } from "../../../../hooks/useNuiEvents";
import { useRecoilValue } from "recoil";
import { Lang } from "../../../../reducers/atoms";
import MemberTable from "./MemberTable";
import { Member } from "../../../../types/types";
import { Loading } from "../../../Loading";
import classes from "./memberStyle.module.css";

interface Properties {
  gang: string;
}

export const Members = ({ gang }: Properties) => {
  const [loaded, setLoaded] = useState(false);
  const [members, setMembers] = useState<Member[]>([]);
  const lang: any = useRecoilValue(Lang);

  const deleteMember = (identifier: string) => {
    fetchNui("av_gangs", "deleteMember2", { identifier, gang });
    const newList = members.filter(
      (member) => member.identifier !== identifier
    );
    setMembers(newList);
  };

  const rows = members.map((row, index) => (
    <Table.Tr key={row.playerName + index} fz="xs">
      <Table.Td>
        <Avatar src={row.photo} size={30} />
      </Table.Td>
      <Table.Td>{row.playerName}</Table.Td>
      <Table.Td>{row.rank}</Table.Td>
      <Table.Td>{row.joined}</Table.Td>
      <Table.Td>
        <Tooltip color="gray.7" label={lang.removeMember} fz="xs">
          <ActionIcon
            size="sm"
            variant="subtle"
            color="red.4"
            onClick={() => {
              deleteMember(row.identifier);
            }}
          >
            <IconEraser style={{ width: "70%", height: "70%" }} />
          </ActionIcon>
        </Tooltip>
      </Table.Td>
    </Table.Tr>
  ));

  useEffect(() => {
    const fetchData = async () => {
      const resp = await fetchNui("av_gangs", "adminMembers", gang);
      if (resp) {
        setMembers(resp);
      }
      setTimeout(() => {
        setLoaded(true);
      }, 100);
    };
    fetchData();
  }, [gang]);

  return (
    <>
      {!loaded ? (
        <Loading />
      ) : (
        <>
          <Box className={classes.members}>
            <MemberTable rows={rows} lang={lang} />
          </Box>
        </>
      )}
    </>
  );
};
