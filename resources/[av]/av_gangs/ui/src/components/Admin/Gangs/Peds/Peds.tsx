import { useEffect, useState } from "react";
import {
  Group,
  Grid,
  ScrollArea,
  Text,
  Image,
  ActionIcon,
  TextInput,
} from "@mantine/core";
import { IconBackspace } from "@tabler/icons-react";
import { fetchNui } from "../../../../hooks/useNuiEvents";
import classes from "./style.module.css";
import { useRecoilValue } from "recoil";
import { Lang } from "../../../../reducers/atoms";
interface Properties {
  gang: string;
}

export const Peds = ({ gang }: Properties) => {
  const [loading, setLoading] = useState(false);
  const [image, setImage] = useState<string | null>(null);
  const [allPeds, setAllPeds] = useState<string[]>([]);
  const { admin: lang }: any = useRecoilValue(Lang);
  const handleNew = async (value: string) => {
    const isModelValid = await fetchNui("av_gangs", "verifyModel", value);
    if (isModelValid) {
      const copy = [...allPeds, value];
      setAllPeds(copy);
      fetchNui("av_gangs", "savePeds", { copy, gang });
    }
  };
  const removePed = (model: string) => {
    const copy = [...allPeds];
    const index = copy.indexOf(model);
    if (index !== -1) {
      copy.splice(index, 1);
    }
    setAllPeds(copy);
    fetchNui("av_gangs", "savePeds", { copy, gang });
  };
  useEffect(() => {
    const fetchData = async () => {
      const resp = await fetchNui("av_gangs", "adminPeds", gang);
      if (resp) setAllPeds(resp);
    };
    fetchData();
  }, [gang]);

  return (
    <Grid className={classes.members} mt="sm" justify="center">
      <Grid.Col span={"auto"}>
        <TextInput
          classNames={classes}
          placeholder={lang.addPedModel}
          size="xs"
          onKeyDown={(e) => {
            const value = e.key;
            if (value == "Enter") {
              handleNew(e.currentTarget.value);
              e.currentTarget.value = "";
            }
          }}
        />
        <ScrollArea h={"27vh"} mt="sm">
          {allPeds.map((model: string, index: number) => (
            <Group
              bg={index % 2 == 1 ? `` : `rgba(60,60,60,0.8)`}
              p={4}
              style={{ borderRadius: "4px" }}
            >
              <Text
                fz="sm"
                fw={500}
                c={image == model ? `teal` : `gray.4`}
                style={{ cursor: "pointer" }}
                onClick={() => {
                  setLoading(true);
                  setImage(model);
                  setTimeout(() => {
                    setLoading(false);
                  }, 100);
                }}
              >
                {model}
              </Text>
              <ActionIcon
                ml="auto"
                mr="sm"
                variant="subtle"
                color="red"
                size="sm"
                onClick={() => {
                  removePed(model);
                }}
              >
                <IconBackspace />
              </ActionIcon>
            </Group>
          ))}
        </ScrollArea>
      </Grid.Col>
      <Grid.Col span={"auto"} style={{ display: "relative" }}>
        {!loading && image && (
          <Image
            mt="md"
            src={`https://docs.fivem.net/peds/${image}.webp`}
            h={300}
            fit="contain"
          />
        )}
      </Grid.Col>
    </Grid>
  );
};
