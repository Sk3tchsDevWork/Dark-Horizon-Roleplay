import {
  Card,
  Grid,
  Image,
  Text,
  Button,
  Group,
  Rating,
  Box,
} from "@mantine/core";
import { IconSkull } from "@tabler/icons-react";
import { useRecoilValue } from "recoil";
import { Gang, Lang } from "../../../reducers/atoms";
import { calculateLevel } from "../../../hooks/calculateLevel";
import { useEffect, useState } from "react";
import { fetchNui, useNuiEvent } from "../../../hooks/useNuiEvents";
import { Loading } from "../../Loading";
import classes from "./missionStyle.module.css";

interface Mission {
  name: string;
  label: string;
  price: number;
  difficulty: number;
  level: number;
  image: string;
  description: string;
  event: string;
  started: boolean;
}

const Missions = () => {
  const lang: any = useRecoilValue(Lang);
  const gang = useRecoilValue(Gang);
  const res = calculateLevel(gang.level, gang.max);
  const [missions, setMissions] = useState<Mission[]>([]);
  const [imagesLoaded, setImagesLoaded] = useState(false);
  const [imageLoadCount, setImageLoadCount] = useState(0);
  useNuiEvent("updateMission", (data: any) => {
    if (data.name) {
      const name = data.name;
      const started = data.started;
      setMissions((prevMissions) =>
        prevMissions.map((mission) =>
          mission.name === name ? { ...mission, started: started } : mission
        )
      );
    }
  });
  const handleStart = (mission: Mission) => {
    fetchNui("av_gangs", "startMission", mission);
  };
  useEffect(() => {
    const fetchData = async () => {
      const resp = await fetchNui("av_gangs", "getMissions");
      if (resp) {
        const filtered: Mission[] = resp.sort(
          (a: Mission, b: Mission) => a.difficulty - b.difficulty
        );
        setMissions(filtered);
      }
    };
    fetchData();
  }, []);

  useEffect(() => {
    if (missions.length > 0 && imageLoadCount === missions.length) {
      setImagesLoaded(true);
    }
  }, [imageLoadCount, missions.length]);

  const handleImageLoad = () => {
    setImageLoadCount((prevCount) => prevCount + 1);
  };

  return (
    <>
      {!imagesLoaded && (
        <Box style={{ position: "relative", height: "90%", width: "100%" }}>
          <Loading />
        </Box>
      )}
      {missions.map((mission: Mission) => (
        <Image
          key={mission.name}
          src={mission.image}
          style={{ display: "none" }}
          onLoad={handleImageLoad}
          fallbackSrc="missions/missing.png"
        />
      ))}
      {imagesLoaded && (
        <Grid className={classes.grid} gutter="xs">
          {missions.map((mission: Mission) => (
            <Grid.Col span={4} key={mission.name}>
              <Card withBorder radius="md" className={classes.card}>
                <Card.Section className={classes.image}>
                  {res.level < mission.level && (
                    <Box className={classes.blur} />
                  )}
                  <Image
                    src={mission.image}
                    h={240}
                    fallbackSrc="missions/missing.png"
                    fit="cover"
                  />
                </Card.Section>
                <Rating
                  value={mission.difficulty}
                  fractions={2}
                  readOnly
                  emptySymbol={<IconSkull size="1rem" color="gray" />}
                  fullSymbol={
                    <IconSkull size="1rem" color="rgb(255,105,105)" />
                  }
                  mt="xs"
                />
                <Text className={classes.title} fw={500} truncate>
                  {res.level >= mission.level ? mission.label : `Classified`}
                </Text>
                <Text
                  className={classes.description}
                  fz="sm"
                  c="dimmed"
                  lineClamp={4}
                  mt={2}
                >
                  {res.level >= mission.level
                    ? mission.description
                    : `${lang.requiredLevel} ${mission.level}`}
                </Text>
                <Group className={classes.buttonBox} mt="xs">
                  {res.level >= mission.level && mission.price && (
                    <>
                      <Text fw={500} c="gray.5">{`${
                        lang.price
                      }: $${mission.price.toLocaleString("en-US")}`}</Text>
                    </>
                  )}
                  <Button
                    className={classes.button}
                    color="teal"
                    size="xs"
                    variant="subtle"
                    disabled={res.level < mission.level || mission.started}
                    onClick={() => {
                      handleStart(mission);
                    }}
                  >
                    {mission.started
                      ? lang.missions.started
                      : lang.missions.start}
                  </Button>
                </Group>
              </Card>
            </Grid.Col>
          ))}
        </Grid>
      )}
    </>
  );
};

export default Missions;
