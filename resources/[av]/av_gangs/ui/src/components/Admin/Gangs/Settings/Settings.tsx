import {
  Grid,
  Group,
  Button,
  Text,
  NumberInput,
  ColorSwatch,
  CheckIcon,
  rem,
} from "@mantine/core";
import { useEffect, useState } from "react";
import { fetchNui } from "../../../../hooks/useNuiEvents";
import { useRecoilValue } from "recoil";
import { Lang } from "../../../../reducers/atoms";

interface Properties {
  gang: string;
}

const colors = [
  { index: 1, color: "FF0000" },
  { index: 2, color: "00FF00" },
  { index: 3, color: "0000FF" },
  { index: 4, color: "FFFFFF" },
  { index: 5, color: "FFFF00" },
  { index: 6, color: "FF6666" },
  { index: 7, color: "8A2BE2" },
  { index: 8, color: "FFC0CB" },
  { index: 9, color: "FFA07A" },
  { index: 10, color: "D2B48C" },
  { index: 11, color: "90EE90" },
  { index: 12, color: "ADD8E6" },
  { index: 13, color: "D8BFD8" },
  { index: 14, color: "800080" },
  { index: 15, color: "00FFFF" },
  { index: 16, color: "FFFFE0" },
  { index: 17, color: "FFA500" },
  { index: 18, color: "ADD8E6" },
  { index: 19, color: "FF1493" },
  { index: 20, color: "FFD700" },
  { index: 21, color: "FF8C00" },
  { index: 22, color: "D3D3D3" },
  { index: 23, color: "FFB6C1" },
  { index: 24, color: "32CD32" },
  { index: 25, color: "228B22" },
  { index: 26, color: "7DF9FF" },
  { index: 27, color: "BF00FF" },
  { index: 28, color: "B8860B" },
  { index: 29, color: "00008B" },
  { index: 30, color: "008B8B" },
  { index: 33, color: "FFFFE0" },
  { index: 36, color: "F5F5DC" },
  { index: 40, color: "A9A9A9" },
  { index: 50, color: "9370DB" },
  { index: 51, color: "FA8072" },
  { index: 52, color: "C54B8C" },
];

export const Settings = ({ gang }: Properties) => {
  const [gangXP, setGangXP] = useState<string | number>(0);
  const [bossId, setBossId] = useState<string | number>(0);
  const [playerId, setPlayerId] = useState<string | number>(0);
  const [territory, setTerritory] = useState<number>(0);
  const lang: any = useRecoilValue(Lang);
  useEffect(() => {
    const fetchData = async () => {
      const resp = await fetchNui("av_gangs", "getGangSettings", gang);
      if (resp) {
        setGangXP(resp.xp);
        setTerritory(resp.blip);
      }
    };
    fetchData();
  }, [gang]);
  const handleBoss = () => {
    fetchNui("av_gangs", "setAdminBoss", { id: bossId, gang });
  };
  const handleXP = () => {
    fetchNui("av_gangs", "setAdminXP", { gang, xp: gangXP });
  };
  const sendSpray = () => {
    fetchNui("av_gangs", "giveSpray", { playerId, gang });
  };
  const handleColor = (index: number) => {
    setTerritory(index);
    fetchNui("av_gangs", "setBlipColor", { index, gang });
  };
  return (
    <Grid grow>
      <Grid.Col span={6}>
        <Group mt="xl" gap="sm" w={"70%"} maw={340}>
          <Text fz="sm" fw={500}>
            {lang.admin.newBoss}
          </Text>
          <Group ml="auto">
            <NumberInput
              styles={{
                input: {
                  backgroundColor: "transparent",
                },
              }}
              placeholder={lang.playerId}
              min={1}
              size="xs"
              w={100}
              allowDecimal={false}
              allowNegative={false}
              onChange={(e) => {
                setBossId(e);
              }}
            />
            <Button color="teal" variant="light" size="xs" onClick={handleBoss}>
              {lang.save}
            </Button>
          </Group>
        </Group>
        <Group mt="md" gap="sm" w={"70%"} maw={340}>
          <Text fz="sm" fw={500}>
            {lang.admin.setXP}
          </Text>
          <Group ml="auto">
            <NumberInput
              styles={{
                input: {
                  backgroundColor: "transparent",
                },
              }}
              placeholder={lang.playerId}
              min={1}
              size="xs"
              w={100}
              allowDecimal={false}
              allowNegative={false}
              value={gangXP}
              onChange={(e) => {
                setGangXP(e);
              }}
            />
            <Button color="teal" variant="light" size="xs" onClick={handleXP}>
              {lang.save}
            </Button>
          </Group>
        </Group>
        <Group mt="md" gap="sm" w={"70%"} maw={340}>
          <Text fz="sm" fw={500}>
            {lang.admin.sendSpray}
          </Text>
          <Group ml="auto">
            <NumberInput
              styles={{
                input: {
                  backgroundColor: "transparent",
                },
              }}
              placeholder={lang.playerId}
              min={1}
              size="xs"
              w={100}
              allowDecimal={false}
              allowNegative={false}
              onChange={(e) => {
                setPlayerId(e);
              }}
            />
            <Button color="teal" variant="light" size="xs" onClick={sendSpray}>
              {lang.send}
            </Button>
          </Group>
        </Group>
      </Grid.Col>
      <Grid.Col span={4}>
        <Group gap="sm">
          <Text fz="sm" fw={500}>
            {lang.admin.territory}
          </Text>
          <Group ml="auto">
            {colors.map((field) => (
              <ColorSwatch
                color={`#${field.color}`}
                onClick={() => {
                  handleColor(field.index);
                }}
              >
                {territory == field.index && (
                  <CheckIcon
                    color="black"
                    style={{ width: rem(12), height: rem(12) }}
                  />
                )}
              </ColorSwatch>
            ))}
          </Group>
        </Group>
      </Grid.Col>
    </Grid>
  );
};
