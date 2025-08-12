import { useState, useEffect } from "react";
import {
  Table,
  ActionIcon,
  Tooltip,
  Group,
  Image,
  Grid,
  Text,
  ScrollArea,
} from "@mantine/core";
import { IconGps, IconEraser } from "@tabler/icons-react";
import { fetchNui } from "../../../../hooks/useNuiEvents";
import { useRecoilValue } from "recoil";
import { Lang } from "../../../../reducers/atoms";
import GraffitiTable from "./GraffitiTable";
import classes from "./graffitiStyle.module.css";
import { Loading } from "../../../Loading";

interface Properties {
  gang: string;
}

export const Graffitis = ({ gang }: Properties) => {
  const [loaded, setLoaded] = useState(false);
  const [allGraffitis, setAllGraffitis] = useState([]);
  const [loading, setLoading] = useState(false);
  const [image, setImage] = useState("");
  const [currentIndex, setCurrentIndex] = useState(999);
  const lang: any = useRecoilValue(Lang);

  const handleImage = (url: string) => {
    setLoading(true);
    setTimeout(() => {
      setImage(url);
      setLoading(false);
    }, 100);
  };
  const deleteGraffiti = (identifier: number) => {
    const newList = allGraffitis.filter(
      (item: any) => item.identifier !== identifier
    );
    setAllGraffitis(newList);
    fetchNui("av_gangs", "deleteSpray", { identifier, gang });
  };
  const setGPS = (coords: any) => {
    fetchNui("av_gangs", "setGPS", coords);
  };
  const rows = allGraffitis.map((row: any, index: number) => (
    <Table.Tr key={row.identifier} fz="xs">
      <Table.Td
        c={index == currentIndex ? `teal` : `gray.4`}
        style={{ cursor: "pointer" }}
        onClick={() => {
          setCurrentIndex(index);
          handleImage(row.url);
        }}
      >
        {row.streetName ? row.streetName : `Unknown Street`}
      </Table.Td>
      <Table.Td>
        <Group gap="sm">
          <Tooltip color="gray.7" label={`Set GPS`} fz="xs">
            <ActionIcon
              size="sm"
              variant="subtle"
              color="cyan.4"
              onClick={() => {
                setGPS(row.coords);
              }}
            >
              <IconGps style={{ width: "70%", height: "70%" }} />
            </ActionIcon>
          </Tooltip>
          <Tooltip color="gray.7" label={`Delete`} fz="xs">
            <ActionIcon
              size="sm"
              variant="subtle"
              color="red.4"
              onClick={() => {
                deleteGraffiti(row.identifier);
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
      const resp = await fetchNui("av_gangs", "adminGraffitis", gang);
      if (resp) {
        setAllGraffitis(resp);
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
        <Grid className={classes.members} mt="sm">
          <Grid.Col span={"auto"}>
            <ScrollArea h={"27vh"}>
              <GraffitiTable rows={rows} lang={lang} />
            </ScrollArea>
          </Grid.Col>
        </Grid>
      )}
    </>
  );
};
