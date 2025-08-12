local CreateCourtWebhook = ""
local AdjournCourtWebhook = ""
local FinishProceedingsWebhook = ""

webhookMsg = {
    ['CreateCourt'] = {
        ['title'] = "Court Case: %s",
        ['message'] = "**Case Name:** %s \n\n **Presiding Judge:** Judge %s \n\n **Defendant:** %s \n\n **Defense:** %s \n\n **Settlement Fee:** %s \n\n **Date & Time:** %s"
    },
    ['AdjournCourt'] = {
        ['title'] = "Court Case: %s",
        ['message'] = "**Case Name:** %s \n\n **Presiding Judge:** Judge %s \n\n **Defendant:** %s \n\n **Defense:** %s \n\n **Settlement Fee:** %s \n\n This Case has been adjourned until %s, Any issues please make an appointment at the court."
    },
    ['FinishProceedings'] = {
        ['title'] = "Court Case: %s",
        ['message'] = "**Case Name:** %s \n\n **Presiding Judge:** Judge %s \n\n **Defendant:** %s \n\n **Defense:** %s \n\n **Settlement Fee:** %s \n\n **Date & Time:** %s \n\n **Verdict:** %s"
    }
}

sendLogsDiscord = function(title, message, webhook)
    local Discord_url = nil
	local embed = {
		{
			["color"] = 3085967,
			["title"] = "**".. title .."**",
			["description"] = message
		}
	}
    if webhook == "CreateCourtWebhook" then
      Discord_url = CreateCourtWebhook
    elseif webhook == "AdjournCourtWebhook" then
      Discord_url = AdjournCourtWebhook
    elseif webhook == "FinishProceedingsWebhook" then
      Discord_url = FinishProceedingsWebhook  
    end
    PerformHttpRequest(Discord_url, function(err, text, headers) end, 'POST', json.encode({username = title, embeds = embed}), { ['Content-Type'] = 'application/json' })
end

customphonefunction = function(data)
  local identifier = data.identifier
  local sender = data.sender
  local subject = data.subject
  local message = data.message
  local image = data.image
  local button = data.button

  -- Put custom event here.

end