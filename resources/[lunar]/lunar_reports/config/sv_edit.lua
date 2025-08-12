---@alias ReportAction
---| 'create_ticket'
---| 'close_ticket'
---| 'send_message'
---| 'go_to'
---| 'bring'
---| 'freeze'

---@param data { action: ReportAction, ticket: { index: integer, author: integer, type: string, title: string, content: string }, source: integer, message: string?  }
function CustomLog(data)
    -- Add your custom logging here
end