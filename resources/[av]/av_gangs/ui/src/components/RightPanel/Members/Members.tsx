import React, { useState, useEffect } from "react";
import {
  Box,
  Button,
  Group,
  TextInput,
  rem,
  LoadingOverlay,
  Table,
  Avatar,
  ActionIcon,
  Tooltip,
} from "@mantine/core";
import { IconSearch, IconEdit, IconEraser } from "@tabler/icons-react";
import { fetchNui, useNuiEvent } from "../../../hooks/useNuiEvents";
import { useRecoilValue } from "recoil";
import { Identifier, Lang, Permissions } from "../../../reducers/atoms";
import MemberTable from "./MemberTable";
import { Member } from "../../../types/types";
import { sortData } from "./utils";
import { EditPanel } from "./EditPanel";
import classes from "./memberStyle.module.css";
import { Confirm } from "./Confirm";

const Members: React.FC = () => {
  const permissions = useRecoilValue(Permissions);
  const identifier = useRecoilValue(Identifier);
  const [loaded, setLoaded] = useState(false);
  const [showConfirm, setShowConfirm] = useState(false);
  const [showEdit, setShowEdit] = useState(false);
  const [member, setMember] = useState<any>({});
  const [members, setMembers] = useState<Member[]>([]);
  const [search, setSearch] = useState("");
  const [sortedData, setSortedData] = useState<Member[]>(members);
  const [sortBy, setSortBy] = useState<keyof Member | null>(null);
  const [reverseSortDirection, setReverseSortDirection] = useState(false);
  const lang: any = useRecoilValue(Lang);

  useNuiEvent("updateMember", (member: Member) => {
    const newList = members.map((m) =>
      m.identifier === member.identifier ? member : m
    );
    setMember([]);
    setMembers(newList);
    setSortedData(newList);
  });

  const setSorting = (field: keyof Member) => {
    const reversed = field === sortBy ? !reverseSortDirection : false;
    setReverseSortDirection(reversed);
    setSortBy(field);
    setSortedData(sortData(members, { sortBy: field, reversed, search }));
  };

  const handleSearchChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    const { value } = event.currentTarget;
    setSearch(value);
    setSortedData(
      sortData(members, {
        sortBy,
        reversed: reverseSortDirection,
        search: value,
      })
    );
  };

  const handleEdit = (data: Member) => {
    setMember(data);
    setShowEdit(true);
  };

  const handleDelete = (data: Member) => {
    setShowConfirm(true);
    setMember(data);
  };
  const deleteMember = async (identifier: string) => {
    const resp = await fetchNui("av_gangs", "deleteMember", identifier);
    if (!resp) return;
    const newList = members.filter(
      (member) => member.identifier !== identifier
    );
    setMember([]);
    setMembers(newList);
    setSortedData(newList);
  };
  const handleInvite = async () => {
    const resp = await fetchNui("av_gangs", "invite");
    if (resp) {
      setMembers(resp);
      setSortedData(resp);
    }
  };

  const hasPermission = (myPermissions: string[], tabPermissions: string[]) => {
    return tabPermissions.some((permission) =>
      myPermissions.includes(permission)
    );
  };
  const rows = sortedData.map((row, index) => (
    <Table.Tr key={row.playerName + index} fz="xs">
      <Table.Td>
        <Avatar src={row.photo} size={30} />
      </Table.Td>
      <Table.Td>{row.playerName}</Table.Td>
      <Table.Td>{row.rank}</Table.Td>
      <Table.Td>{row.joined}</Table.Td>
      <Table.Td>
        <Group gap="sm">
          {hasPermission(permissions, ["isBoss", "members"]) && (
            <Tooltip color="dark.4" label={lang.members.editMember}>
              <ActionIcon
                size="sm"
                variant="subtle"
                color="cyan.4"
                onClick={() => {
                  handleEdit(row);
                }}
              >
                <IconEdit style={{ width: "70%", height: "70%" }} />
              </ActionIcon>
            </Tooltip>
          )}
          {hasPermission(permissions, ["isBoss", "members"]) ||
          identifier == row.identifier ? (
            <Tooltip
              color="dark.4"
              label={
                identifier == row.identifier
                  ? lang.members.leave
                  : lang.members.remove
              }
            >
              <ActionIcon
                size="sm"
                variant="subtle"
                color="red.4"
                onClick={() => {
                  handleDelete(row);
                }}
              >
                <IconEraser style={{ width: "70%", height: "70%" }} />
              </ActionIcon>
            </Tooltip>
          ) : null}
        </Group>
      </Table.Td>
    </Table.Tr>
  ));

  useEffect(() => {
    const fetchData = async () => {
      const resp = await fetchNui("av_gangs", "getMembers");
      if (resp) {
        setMembers(resp);
        setSortedData(resp);
      }
      setTimeout(() => {
        setLoaded(true);
      }, 100);
    };
    fetchData();
  }, []);

  return (
    <>
      {!loaded ? (
        <Box
          style={{
            display: "flex",
            alignContent: "center",
            alignItems: "center",
            height: "100%",
          }}
        >
          <LoadingOverlay
            visible
            zIndex={1000}
            loaderProps={{ color: "teal", type: "dots" }}
            overlayProps={{ radius: "sm", blur: 2, opacity: 0 }}
          />
        </Box>
      ) : (
        <>
          {showEdit && (
            <EditPanel member={member} show={setShowEdit} lang={lang} />
          )}
          {showConfirm && (
            <Confirm
              member={member}
              deleteMember={deleteMember}
              showConfirm={setShowConfirm}
              lang={lang}
            />
          )}
          <Group gap="sm" mb="md" preventGrowOverflow={false} grow>
            <TextInput
              placeholder={lang.search}
              leftSection={
                <IconSearch
                  style={{ width: rem(16), height: rem(16) }}
                  stroke={1.5}
                />
              }
              value={search}
              onChange={handleSearchChange}
              classNames={classes}
              opacity={showEdit || showConfirm ? 0 : 1}
            />
            {hasPermission(permissions, ["isBoss", "members"]) && (
              <Button
                color="teal"
                maw="15%"
                opacity={showEdit || showConfirm ? 0 : 1}
                onClick={handleInvite}
              >
                {lang.members.invite}
              </Button>
            )}
          </Group>
          <Box className={classes.members}>
            <MemberTable
              sortBy={sortBy}
              reverseSortDirection={reverseSortDirection}
              setSorting={setSorting}
              rows={rows}
              lang={lang}
            />
          </Box>
        </>
      )}
    </>
  );
};

export default Members;
