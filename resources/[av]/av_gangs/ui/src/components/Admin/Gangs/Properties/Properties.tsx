import { useState, useEffect } from "react";
import { Box, Table, ActionIcon, Tooltip, Group, Text } from "@mantine/core";
import {
  IconGps,
  IconEraser,
  IconPackage,
  IconScanEye,
  IconUsersGroup,
  IconLock,
  IconLockOpen,
} from "@tabler/icons-react";
import { fetchNui } from "../../../../hooks/useNuiEvents";
import { useRecoilValue } from "recoil";
import { Lang } from "../../../../reducers/atoms";
import PropertyTable from "./PropertyTable";
import { PropertyType } from "../../../../types/types";
import classes from "./propertyStyle.module.css";
import { Loading } from "../../../Loading";
import { Timer } from "./Timer";

interface Properties {
  gang: string;
}
type UpgradeKeys = "security" | "production" | "stash";

const icons: { [key in UpgradeKeys]: React.ReactElement } = {
  security: <IconScanEye style={{ width: 14, height: 14 }} />,
  production: <IconUsersGroup style={{ width: 14, height: 14 }} />,
  stash: <IconPackage style={{ width: 14, height: 14 }} />,
};

export const Properties = ({ gang }: Properties) => {
  const [loaded, setLoaded] = useState(false);
  const [properties, setProperties] = useState<PropertyType[]>([]);
  const lang: any = useRecoilValue(Lang);

  const deleteProperty = async (type: string, identifier: string) => {
    fetchNui("av_gangs", "deleteProperty", { type, identifier, gang });
    const newList = properties.filter(
      (property) => property.identifier !== identifier
    );
    setProperties(newList);
  };
  const setGPS = (coords: any) => {
    fetchNui("av_gangs", "setGPS", coords);
  };
  const toggleDoor = (type: string, identifier: string) => {
    const copy = [...properties];
    const item = copy.find((obj) => obj.identifier === identifier);
    if (item) {
      item.isOpen = !item.isOpen;
    }
    setProperties(copy);
    fetchNui("av_gangs", "toggleDoor", { type, identifier, gang });
  };
  const rows = properties.map((row) => (
    <Table.Tr key={row.identifier} fz="xs">
      <Table.Td>{row.label}</Table.Td>
      <Table.Td>{row.type}</Table.Td>
      <Table.Td>
        <Timer deadline={row.nextCook} />
      </Table.Td>
      <Table.Td>
        <Group>
          {Object.keys(row.upgrades).map((upgrade) => {
            const key = upgrade as UpgradeKeys;
            return (
              <Tooltip
                label={lang.properties[key]}
                key={key}
                color="gray.7"
                fz="xs"
              >
                <Group gap={2}>
                  {icons[key]}
                  <Text fz="xs" c="gray.5">
                    {row.upgrades[key]}
                  </Text>
                </Group>
              </Tooltip>
            );
          })}
        </Group>
      </Table.Td>
      <Table.Td>
        <Group gap="sm">
          <Tooltip color="gray.7" label={`Set GPS`} fz="xs">
            <ActionIcon
              size="sm"
              variant="subtle"
              color="cyan.4"
              onClick={() => {
                setGPS(row.entry);
              }}
            >
              <IconGps style={{ width: "70%", height: "70%" }} />
            </ActionIcon>
          </Tooltip>
          <Tooltip
            color="gray.7"
            label={row.isOpen ? lang.open : lang.closed}
            fz="xs"
          >
            <ActionIcon
              size="sm"
              variant="subtle"
              color={row.isOpen ? `teal` : `yellow`}
              onClick={() => {
                toggleDoor(row.type, row.identifier);
              }}
            >
              {row.isOpen ? (
                <IconLockOpen style={{ width: "70%", height: "70%" }} />
              ) : (
                <IconLock style={{ width: "70%", height: "70%" }} />
              )}
            </ActionIcon>
          </Tooltip>
          <Tooltip color="gray.7" label={lang.admin.deleteProperty} fz="xs">
            <ActionIcon
              size="sm"
              variant="subtle"
              color="red.4"
              onClick={() => {
                deleteProperty(row.type, row.identifier);
              }}
            >
              <IconEraser style={{ width: "70%", height: "70%" }} />
            </ActionIcon>
          </Tooltip>
        </Group>
      </Table.Td>
    </Table.Tr>
  ));

  useEffect(() => {
    const fetchData = async () => {
      const resp = await fetchNui("av_gangs", "adminProperties", gang);
      if (resp) {
        setProperties(resp);
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
            <PropertyTable rows={rows} lang={lang} />
          </Box>
        </>
      )}
    </>
  );
};
