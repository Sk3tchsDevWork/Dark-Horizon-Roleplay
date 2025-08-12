import { ReactElement, useState, useEffect } from "react";
import {
  Box,
  Grid,
  Card,
  Image,
  Text,
  Group,
  Badge,
  Button,
  Rating,
  Tooltip,
} from "@mantine/core";
import {
  IconPackage,
  IconScanEye,
  IconCoin,
  IconUsersGroup,
  IconHelpHexagonFilled,
} from "@tabler/icons-react";
import { useRecoilValue } from "recoil";
import { Gang, Lang } from "../../../reducers/atoms";
import { PropertyType } from "../../../types/types";
import { InfoPanel } from "./InfoPanel";
import { calculateLevel } from "../../../hooks/calculateLevel";
import classes from "./propertieStyle.module.css";
import { fetchNui } from "../../../hooks/useNuiEvents";

interface IconMap {
  [key: string]: ReactElement;
}

type UpgradeKeys = "stash" | "production" | "security";

const Icons: IconMap = {
  stash: <IconPackage stroke={1.5} style={{ width: "18px", height: "18px" }} />,
  production: (
    <IconUsersGroup stroke={1.5} style={{ width: "18px", height: "18px" }} />
  ),
  security: (
    <IconScanEye stroke={1.5} style={{ width: "18px", height: "18px" }} />
  ),
};

const fallback =
  "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1027823/5a3ed30f917b3e1e4f0f00ad29f21cbc138bcd11.jpg";

const Properties = () => {
  const gang = useRecoilValue(Gang);
  const resp = calculateLevel(gang.level, gang.max);
  const lang: any = useRecoilValue(Lang);
  const [properties, setProperties] = useState<PropertyType[]>([]);
  const [confirm, setConfirm] = useState("");

  const handleUpgrade = async (
    identifier: string,
    type: string,
    shell: string,
    upgrade: string,
    level: number
  ) => {
    const resp = await fetchNui("av_gangs", "buyUpgrade", {
      identifier,
      type,
      shell,
      upgrade,
      level,
    });
    if (resp) {
      setProperties((prevProperties) =>
        prevProperties.map((property) =>
          property.identifier === identifier
            ? {
                ...property,
                upgrades: {
                  ...property.upgrades,
                  [upgrade]: level,
                },
              }
            : property
        )
      );
    }
  };

  const handleSell = (type: string, identifier: string) => {
    fetchNui("av_gangs", "sellProperty", { type, identifier });
    setProperties((prevProperties) =>
      prevProperties.filter((property) => property.identifier !== identifier)
    );
  };
  const setGPS = (coords: any) => {
    fetchNui("av_laptop", "setGPS", coords);
  };
  useEffect(() => {
    const fetchData = async () => {
      const resp = await fetchNui("av_gangs", "getProperties");
      if (resp) {
        setProperties(resp);
      }
    };
    fetchData();
  }, []);
  return (
    <>
      <Grid className={classes.grid} gutter="xs">
        {properties.map((property: PropertyType) => (
          <Grid.Col
            span={{ base: 4, xs: 6, sm: 6, md: 6, lg: 4 }}
            key={property.identifier}
          >
            <Card withBorder radius="md" p="md" className={classes.card}>
              <Card.Section>
                <Box className={classes.help}>
                  <Tooltip
                    label={<InfoPanel lang={lang} />}
                    h={"auto"}
                    color="transparent"
                    withinPortal
                  >
                    <IconHelpHexagonFilled className={classes.helpIcon} />
                  </Tooltip>
                </Box>
                <Image
                  src={property.photo}
                  alt={property.label}
                  fallbackSrc={fallback}
                  h={215}
                />
              </Card.Section>
              <Card.Section className={classes.section} mt="md">
                <Group justify="apart">
                  <Text fz="lg" fw={500}>
                    {property.label}
                  </Text>
                  {property.working && (
                    <Badge size="sm" variant="light" color={"cyan"}>
                      {property.working}
                    </Badge>
                  )}
                </Group>
                <Text mt="md" className={classes.label} c="dimmed">
                  Upgrades
                </Text>
                <Group mt={"xs"} justify="center">
                  {(Object.keys(property.upgrades) as UpgradeKeys[]).map(
                    (upgrade: UpgradeKeys) => (
                      <Group
                        key={upgrade}
                        gap={"sm"}
                        style={{
                          display: "flex",
                          justifyContent: "center",
                          alignContent: "center",
                          alignItems: "center",
                        }}
                      >
                        <Tooltip
                          label={lang.properties[upgrade]}
                          color="dark.4"
                          fz="xs"
                        >
                          {Icons[upgrade]}
                        </Tooltip>
                        <Rating
                          value={property.upgrades[upgrade]}
                          count={3}
                          mt={4}
                          emptySymbol={<IconCoin color="gray" size={16} />}
                          fullSymbol={(value: number) => {
                            const priceInfo =
                              property.availableUpgrades[upgrade].prices[
                                value - 1
                              ];
                            return (
                              <Tooltip
                                fw={500}
                                color="dark.4"
                                c="gray.3"
                                label={
                                  priceInfo && resp.level >= priceInfo.level
                                    ? `$${priceInfo.price}`
                                    : `Needs Level ${priceInfo?.level}`
                                }
                                withinPortal
                                disabled={value <= property.upgrades[upgrade]}
                              >
                                <IconCoin color="#38D9A9" size={16} />
                              </Tooltip>
                            );
                          }}
                          readOnly={property.upgrades[upgrade] === 3}
                          onChange={(value) => {
                            const priceInfo =
                              property.availableUpgrades[upgrade].prices[
                                value - 1
                              ];
                            if (
                              priceInfo &&
                              (value <= property.upgrades[upgrade] ||
                                resp.level < priceInfo.level)
                            )
                              return;
                            handleUpgrade(
                              property.identifier,
                              property.type,
                              property.shell,
                              upgrade,
                              value
                            );
                          }}
                        />
                      </Group>
                    )
                  )}
                </Group>
              </Card.Section>
              <Group mt="xs" grow={property.identifier === confirm}>
                {confirm !== property.identifier ? (
                  <>
                    <Button
                      variant="light"
                      radius="md"
                      color="teal"
                      style={{ flex: 1 }}
                      size={"sm"}
                      onClick={() => {
                        setGPS(property.entry);
                      }}
                    >
                      Set GPS Route
                    </Button>
                    <Button
                      variant="subtle"
                      color="red.5"
                      radius="md"
                      onClick={() => {
                        setConfirm(property.identifier);
                      }}
                    >
                      <Text>Sell</Text>
                    </Button>
                  </>
                ) : (
                  <>
                    <Button
                      variant="subtle"
                      radius="md"
                      color="teal"
                      size={"sm"}
                      onClick={() => {
                        handleSell(property.type, property.identifier);
                      }}
                    >
                      Confirm
                    </Button>
                    <Button
                      variant="light"
                      radius="md"
                      color="red"
                      size={"sm"}
                      onClick={() => {
                        setConfirm("");
                      }}
                    >
                      Cancel
                    </Button>
                  </>
                )}
              </Group>
            </Card>
          </Grid.Col>
        ))}
      </Grid>
    </>
  );
};

export default Properties;
