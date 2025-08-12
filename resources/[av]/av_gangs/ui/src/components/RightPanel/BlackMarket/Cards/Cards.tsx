import { useState, useEffect } from "react";
import {
  Grid,
  Card,
  Box,
  Image,
  Group,
  Button,
  Text,
  Tooltip,
} from "@mantine/core";
import { IconHelpHexagonFilled } from "@tabler/icons-react";
import { useRecoilValue } from "recoil";
import { Gang, Lang } from "../../../../reducers/atoms";
import { calculateLevel } from "../../../../hooks/calculateLevel";
import { fetchNui } from "../../../../hooks/useNuiEvents";
import classes from "./cardStyle.module.css";
import { Loading } from "../../../Loading";
import { InfoPanel } from "./InfoPanel";

interface Properties {
  type: string;
}

interface Product {
  label: string;
  shell: string;
  description: string;
  price: number;
  level: number;
  photo: string;
}

export const Cards = ({ type }: Properties) => {
  const lang: any = useRecoilValue(Lang);
  const gang = useRecoilValue(Gang);
  const res = calculateLevel(gang.level, gang.max);
  const [products, setProducts] = useState<Product[]>([]);
  const [imagesLoaded, setImagesLoaded] = useState(false);
  const [imageLoadCount, setImageLoadCount] = useState(0);

  useEffect(() => {
    const fetchData = async () => {
      const resp: Product[] = await fetchNui("av_gangs", "getProducts", type);
      if (resp) {
        const filtered = resp.sort((a, b) => a.level - b.level);
        setProducts(filtered);
      }
    };
    fetchData();
  }, [type]);

  useEffect(() => {
    if (products.length > 0 && imageLoadCount === products.length) {
      setImagesLoaded(true);
    }
  }, [imageLoadCount, products.length]);

  const handleImageLoad = () => {
    setImageLoadCount((prevCount) => prevCount + 1);
  };
  const handleBuy = (product: Product) => {
    fetchNui("av_gangs", "buyProduct", product);
  };
  return (
    <>
      {!imagesLoaded && (
        <Box style={{ position: "relative", height: "90%", width: "100%" }}>
          <Loading />
        </Box>
      )}
      {products.map((product: Product) => (
        <Image
          key={product.shell}
          src={product.photo}
          style={{ display: "none" }}
          onLoad={handleImageLoad}
        />
      ))}
      {imagesLoaded && (
        <Grid className={classes.grid} gutter="xs" mt="xs">
          {products.map((product: Product) => (
            <Grid.Col span={4} key={product.shell}>
              <Card withBorder radius="md" className={classes.card}>
                <Card.Section className={classes.image}>
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
                  {res.level < product.level && (
                    <Box className={classes.blur} />
                  )}
                  <Image
                    h={215}
                    src={product.photo}
                    fallbackSrc="https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1027823/5a3ed30f917b3e1e4f0f00ad29f21cbc138bcd11.jpg"
                  />
                </Card.Section>
                <Text className={classes.title} fw={500} truncate mt="sm">
                  {res.level >= product.level ? product.label : lang.classified}
                </Text>
                <Text
                  className={classes.description}
                  fz="sm"
                  c="dimmed"
                  lineClamp={4}
                  mt={2}
                >
                  {res.level >= product.level
                    ? product.description
                    : `${lang.requiredLevel} ${product.level}`}
                </Text>
                <Group className={classes.buttonBox} mt="xs">
                  {res.level >= product.level && (
                    <Text fw={500} c="gray.5">{`${
                      lang.price
                    }: $${product.price.toLocaleString("en-US")}`}</Text>
                  )}
                  <Button
                    className={classes.button}
                    color="teal"
                    size="xs"
                    variant="subtle"
                    disabled={res.level < product.level}
                    onClick={() => {
                      handleBuy(product);
                    }}
                  >
                    {lang.buy}
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
