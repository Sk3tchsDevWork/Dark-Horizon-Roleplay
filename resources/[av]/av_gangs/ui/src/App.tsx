import { useEffect, useState } from "react";
import { MantineProvider, Box } from "@mantine/core";
import { fetchNui, isEnvBrowser } from "./hooks/useNuiEvents";
import { Lang } from "./reducers/atoms";
import { useSetRecoilState } from "recoil";
import { MainApp } from "./components/MainApp";
import { getLang } from "./hooks/getLang";
import "./App.css";
import "@mantine/core/styles.css";
import { Admin } from "./components/Admin/Admin";

interface Properties {
  type: string;
}

const App = ({ type }: Properties) => {
  const setLang = useSetRecoilState(Lang);
  const [loaded, setLoaded] = useState(false);
  const onPressKey = (e: any) => {
    switch (e.code) {
      case "Escape":
        type == "admin" && fetchNui("av_gangs", "close");
        break;
      default:
        break;
    }
  };
  useEffect(() => {
    const fetchLang = async () => {
      const resp = await getLang();
      setLang(resp);
      setLoaded(true);
    };
    fetchLang();
    window.addEventListener("keydown", onPressKey);
  }, []);
  return (
    <>
      {loaded && (
        <MantineProvider defaultColorScheme="dark">
          {isEnvBrowser() ? (
            <>
              {type == "admin" ? (
                <Admin />
              ) : (
                <Box
                  className="main-container"
                  style={{
                    backgroundColor: isEnvBrowser() ? "black" : "transparent",
                  }}
                >
                  <Box
                    className="laptop-frame"
                    style={{
                      backgroundImage: `url(https://raw.githubusercontent.com/Renovamen/playground-macos/main/public/img/ui/wallpaper-night.jpg)`,
                      backgroundSize: "cover",
                    }}
                  >
                    <Box className="app-window">
                      <MainApp />
                    </Box>
                  </Box>
                </Box>
              )}
            </>
          ) : (
            <>{type == "admin" ? <Admin /> : <MainApp />}</>
          )}
        </MantineProvider>
      )}
    </>
  );
};
export default App;
