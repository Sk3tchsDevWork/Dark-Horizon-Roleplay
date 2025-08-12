webhookMsg = {
    ApplicationSubmission = {
      Main = {
        ['title'] = "%s Job Application",
        ['message'] = "*%s has recived an job application from %s*",
      },
      Question = {
        ['title'] = "Question: %s",
        ['message'] = "**Answer:** \n ```%s```"
      },
    }, 
    JobInterview = {
      ['title'] = "%s Job Interview",
      ['message'] = "**Applicant:** ```%s``` \n **Date & Time Of Interview:** ```%s```"
    },
    JobOfferGiven = {
        ['title'] = "%s Job Offer",
        ['message'] = "*%s has been given a job offer* \n\n Job: ```%s``` \n Position: ```%s``` \n Date Of Offer: ```%s``` \n Hired By: ```%s```"
    },
    AppointmentRequest = {
      ['title'] = "%s Appointment Request",
      ['message'] = "**Name:** ```%s``` \n **Reason:** ```%s```"
    },
    AppointmentApprove = {
      ['title'] = "%s Appointment Approve",
      ['message'] = "**Name:** ```%s``` \n **Appointment Staff:** ```%s``` \n **Reason:** ```%s``` \n **Appointment Date & Time:** ```%s```"
    },
    ReceptionStaff = {
      ['title'] = "%s Reception Staff Added",
      ['message'] = "*%s has been added to the reception team* \n\n **Manage Appointments:** ```%s``` \n **Manage Job Applications:** ```%s``` \n **Reception Management:** ```%s```"
    }
}

sendLogsDiscord = function(title, message, webhook, logo)
	local embed = {
		{
			["color"] = 3085967,
			["title"] = "**".. title .."**",
      ['footer'] = {
        ['text'] = os.date('%c'),
      },
			["description"] = message,
      ['author'] = {
        ['name'] = 'AP AddonJob Logs',
        ['icon_url'] = logo,
      },
		}
	}
  PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AP Logs", embeds = embed, avatar_url = logo}), { ['Content-Type'] = 'application/json' })
end

sendLogsQuestionDiscord = function(title, message, webhook, logo)
	local embed = {
		{
			["color"] = 3085967,
			["title"] = "**".. title .."**",
			["description"] = message,
		}
	}
  PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AP Logs", embeds = embed}), { ['Content-Type'] = 'application/json' })
end

customphonefunction = function(data)
  local identifier = data.id
  local sender = data.sender
  local subject = data.subject
  local message = data.mail
  local image = data.image
  local button = data.button
  local notify = data.notifymsg

  -- Put custom event here.

end