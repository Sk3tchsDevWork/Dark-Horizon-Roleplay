import { Box, Group, Tooltip, Text } from "@mantine/core"
import classes from './tabStyle.module.css'

interface TabOptions {
    name: string,
    label: string,
    icon: string,
    level: number
}

interface Properties {
    money: number,
    currentTab: string,
    setCurrentTab: (option:string) => void,
    options: TabOptions[]
}

export const Tabs = ({currentTab, setCurrentTab, options, money}:Properties) => {
  return <>
    <Group className={classes.container} gap="sm">
        {options.map((tab) => (
            <Tooltip label={tab.label} key={tab.name} color="dark.4">
                <Box
                    className={currentTab == tab.name ? classes.iconActive : classes.icon}
                    onClick={()=>{setCurrentTab(tab.name)}}
                >
                    <i className={tab.icon} />
                </Box>
            </Tooltip>
        ))}
        <Group ml="auto">
            <Box
                className={classes.icon}
            >
                <i className="fa-solid fa-wallet" />
            </Box>
            <Text>{`$${(money).toLocaleString("en-US")}`}</Text>
        </Group>
    </Group>
  </>
}
