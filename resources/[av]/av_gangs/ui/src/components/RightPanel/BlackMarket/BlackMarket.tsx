import { useEffect, useState} from "react"
import { fetchNui, useNuiEvent } from "../../../hooks/useNuiEvents";
import { Tabs } from "./Tabs/Tabs";
import { Cards } from "./Cards/Cards";

const BlackMarket = () => {
  const [tabs, setTabs] = useState([])
  const [currentTab, setCurrentTab] = useState("")
  const [money, setMoney] = useState(0)
  useNuiEvent("updateMoney", (data:number) => {
    setMoney(data)
  })
  useEffect(() => {
    const fetchData = async () => {
        const resp = await fetchNui("av_gangs", "getTabs")
        if(resp) {
            setTabs(resp.tabs)
            setCurrentTab(resp.tabs[0].name)
            setMoney(resp.money)
        }
    }
    fetchData()
  }, [])
  
  return <>
    <Tabs options={tabs} currentTab={currentTab} setCurrentTab={setCurrentTab} money={money}/>
    <Cards type={currentTab}/>
  </>
}

export default BlackMarket