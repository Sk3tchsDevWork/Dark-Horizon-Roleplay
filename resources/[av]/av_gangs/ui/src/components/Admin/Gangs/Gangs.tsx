import { useState, useEffect } from "react";
import {
  Box,
  Select,
  Group,
  Button,
  ActionIcon,
  rem,
  Tooltip,
  NumberInput,
} from "@mantine/core";
import { Loading } from "../../Loading";
import { Members } from "./Members/Members";
import { fetchNui } from "../../../hooks/useNuiEvents";
import {
  IconUsersGroup,
  IconUsers,
  IconHome,
  IconSpray,
  IconSettings,
  IconCopy,
} from "@tabler/icons-react";
import { Properties } from "./Properties/Properties";
import { Graffitis } from "./Graffitis/Graffitis";
import { Peds } from "./Peds/Peds";
import classes from "./gangStyle.module.css";
import { Settings } from "./Settings/Settings";
import { useRecoilValue } from "recoil";
import { Lang } from "../../../reducers/atoms";

interface GangOptions {
  value: string;
  label: string;
}

export const Gangs = () => {
  const [loaded, setLoaded] = useState(false);
  const [tab, setTab] = useState("");
  const [allGangs, setAllGangs] = useState<GangOptions[]>([]);
  const [currentGang, setCurrentGang] = useState<string | null>(null);
  const [answer, setAnswer] = useState<string | number>("");
  const lang: any = useRecoilValue(Lang);
  const iconStyle = { width: rem(14), height: rem(14) };
  const deleteGang = () => {
    setCurrentGang(null);
    setAnswer("");
    const copy = allGangs.filter((gang) => gang.value !== currentGang);
    setAllGangs(copy);
    fetchNui("av_gangs", "deleteAdminGang", currentGang);
  };
  const handleChange = async (gang: string | null) => {
    if (!gang) {
      setCurrentGang(null);
      return;
    }
    setCurrentGang(null);
    setTimeout(() => {
      setCurrentGang(gang);
      setTab("members");
    }, 25);
  };
  useEffect(() => {
    const fetchData = async () => {
      const resp = await fetchNui("av_gangs", "getGangs");
      if (resp) setAllGangs(resp);
      setTimeout(() => {
        setLoaded(true);
      }, 100);
    };
    fetchData();
  }, []);
  return (
    <Box className={classes.container} w={"100%"}>
      {loaded ? (
        <>
          <Box w="100%" display="flex">
            <Select
              classNames={classes}
              placeholder={lang.admin.selectGang}
              size="xs"
              w={170}
              data={allGangs}
              value={currentGang}
              onChange={(e) => {
                handleChange(e);
              }}
            />
            {currentGang && (
              <Group w="100%" ml="sm" gap={5}>
                <Tooltip
                  label={lang.admin.members}
                  position="bottom-start"
                  color="gray.7"
                  fz="xs"
                  openDelay={300}
                >
                  <ActionIcon
                    variant="transparent"
                    color={tab == "members" ? "red" : "gray"}
                    onClick={() => {
                      setTab("members");
                    }}
                    size="sm"
                  >
                    <IconUsers style={iconStyle} />
                  </ActionIcon>
                </Tooltip>
                <Tooltip
                  label={lang.admin.properties}
                  position="bottom-start"
                  color="gray.7"
                  fz="xs"
                  openDelay={300}
                >
                  <ActionIcon
                    variant="transparent"
                    color={tab == "properties" ? "red" : "gray"}
                    onClick={() => {
                      setTab("properties");
                    }}
                    size="sm"
                  >
                    <IconHome style={iconStyle} />
                  </ActionIcon>
                </Tooltip>
                <Tooltip
                  label={lang.admin.graffitis}
                  position="bottom-start"
                  color="gray.7"
                  fz="xs"
                  openDelay={300}
                >
                  <ActionIcon
                    variant="transparent"
                    color={tab == "graffitis" ? "red" : "gray"}
                    onClick={() => {
                      setTab("graffitis");
                    }}
                    size="sm"
                  >
                    <IconSpray style={iconStyle} />
                  </ActionIcon>
                </Tooltip>
                <Tooltip
                  label={lang.admin.peds}
                  position="bottom-start"
                  color="gray.7"
                  fz="xs"
                  openDelay={300}
                >
                  <ActionIcon
                    variant="transparent"
                    color={tab == "peds" ? "red" : "gray"}
                    onClick={() => {
                      setTab("peds");
                    }}
                    size="sm"
                  >
                    <IconUsersGroup style={iconStyle} />
                  </ActionIcon>
                </Tooltip>
                <Tooltip
                  label={lang.admin.settings}
                  position="bottom-start"
                  color="gray.7"
                  fz="xs"
                  openDelay={300}
                >
                  <ActionIcon
                    variant="transparent"
                    color={tab == "settings" ? "red" : "gray"}
                    onClick={() => {
                      setTab("settings");
                    }}
                    size="sm"
                  >
                    <IconSettings style={iconStyle} />
                  </ActionIcon>
                </Tooltip>
                <Group ml="auto">
                  <NumberInput
                    placeholder="2+2 = ?"
                    classNames={classes}
                    w={80}
                    size="xs"
                    onChange={(e) => {
                      setAnswer(e);
                    }}
                  />
                  <Button
                    size="xs"
                    color="red"
                    variant="light"
                    disabled={answer !== 4}
                    onClick={deleteGang}
                  >
                    {lang.admin.deleteGang}
                  </Button>
                  <Tooltip
                    label="Copy Gang Name"
                    color="gray.7"
                    fz="xs"
                    openDelay={300}
                  >
                    <ActionIcon
                      size="xs"
                      variant="transparent"
                      onClick={() => {
                        fetchNui("av_laptop", "copy", currentGang);
                      }}
                    >
                      <IconCopy style={iconStyle} />
                    </ActionIcon>
                  </Tooltip>
                </Group>
              </Group>
            )}
          </Box>
          {currentGang && (
            <>
              {tab == "members" && <Members gang={currentGang} />}
              {tab == "properties" && <Properties gang={currentGang} />}
              {tab == "graffitis" && <Graffitis gang={currentGang} />}
              {tab == "peds" && <Peds gang={currentGang} />}
              {tab == "settings" && <Settings gang={currentGang} />}
            </>
          )}
        </>
      ) : (
        <Loading />
      )}
    </Box>
  );
};
