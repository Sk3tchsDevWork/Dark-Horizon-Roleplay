Config = {}

-- The notification sound for admins
Config.newReportSound = true
Config.disableAdminNotifications = false -- Disables "Admin teleported to you" etc.

Config.commands = {
    sendReport = 'report',
    viewReports = 'reports'
}

Config.adminGroups = {
    ['admin'] = true,
    ['god'] = true
}

---@class Category
---@field label string
---@field plural string
---@field icon string

Config.categories = {
    {
        label = 'Player report',
        plural = 'Player reports',
        icon = 'user'
    },
    {
        label = 'Bug report',
        plural = 'Bug reports',
        icon = 'bug'
    },
    {
        label = 'Question',
        plural = 'Questions',
        icon = 'question-circle'
    },
}

Config.messageCooldown = 1000