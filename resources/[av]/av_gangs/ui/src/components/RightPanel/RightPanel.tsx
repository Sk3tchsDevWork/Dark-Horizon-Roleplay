import { lazy, Suspense } from "react";
import { Box } from "@mantine/core"
import { Loading } from "../Loading";
import classes from './rightStyle.module.css'

const Home = lazy(() => import("./Home/Home"));
const Members = lazy(() => import("./Members/Members"));
const Missions = lazy(() => import("./Missions/Missions"));
const BlackMarket = lazy(() => import("./BlackMarket/BlackMarket"));
const Properties = lazy(() => import("./Properties/Properties"));
const Settings = lazy(() => import("./Settings/Settings"));


interface Props {
  tab: string;
  setTab: (state:string) => void
}

export const RightPanel = ({tab, setTab}:Props) => {
  return (
    <Box className={classes.container}>
      <Suspense
            fallback={
              <Box style={{display: "flex", alignContent: "center", alignItems: "center", height: "100%"}}>
                <Loading/>
              </Box>
            }
        >
          {tab == "home" && <Home setTab={setTab}/>}
          {tab == "members" && <Members/>}
          {tab == "missions" && <Missions/>}
          {tab == "blackmarket" && <BlackMarket/>}
          {tab == "settings" && <Settings/>}
          {tab == "properties" && <Properties/>}
        </Suspense>
    </Box>
  )
}