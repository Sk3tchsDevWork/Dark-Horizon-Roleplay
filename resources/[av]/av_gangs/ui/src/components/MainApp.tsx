import { useState, useEffect } from "react"
import { Box, Group } from '@mantine/core'
import { fetchNui, isEnvBrowser } from "../hooks/useNuiEvents"
import { Loading } from "./Loading"
import {Header} from "./Header/Header"
import { RightPanel } from "./RightPanel/RightPanel"
import { LeftPanel } from "./LeftPanel/LeftPanel"
import classes from './appStyle.module.css'
import { useSetRecoilState } from "recoil"
import { Gang, Identifier, Permissions } from "../reducers/atoms"

export const MainApp = () => {
  const setGang = useSetRecoilState(Gang)
  const setPermissions = useSetRecoilState(Permissions)
  const setIdentifier = useSetRecoilState(Identifier)
  const [loaded, setLoaded] = useState(isEnvBrowser())
  const [tab, setTab] = useState("home")

  useEffect(() => {
    const fetchData = async () => {
      const resp = await fetchNui("av_gangs", "getData")
      if(resp) {
        setGang(resp.gang)
        setPermissions(resp.permissions)
        setIdentifier(resp.identifier)
        setTimeout(() => {
          setLoaded(true)
        }, 200)
      }
    }
    fetchData()
  }, [])
  
  return (
    <Box className={classes.app} p={"sm"} >
      {loaded ?
        <Box className={classes.appContainer}>
          <Header/>
          <Group w="100%" h="100%" mt="sm">
            <LeftPanel tab={tab} setTab={setTab}/>
            <RightPanel tab={tab} setTab={setTab}/>
          </Group>
        </Box>
      :
        <Loading/>
      }
    </Box>
  )
}