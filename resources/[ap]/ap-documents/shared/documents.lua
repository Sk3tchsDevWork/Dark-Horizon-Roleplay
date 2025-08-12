Shared = Shared or {}
Shared.Documents = {
	["Repossesion Order"] = {
    type = "create",
    restriction = {job = {enable = false, jobs = {
      [""] = "all",
      [""] = {0},
    }}, gang = {enable = false, gangs = {
      [""] = {0},
    }}, citizenid = {enable = false, id = {
      "",
    }}},
    title = "Repossesion Order",
    logo = "https://cdn.discordapp.com/attachments/633974153388490753/1030999165485989888/1519800440060-removebg-preview.png",
    from = "UNITED STATES DISTRICT COURT",
    description = "An order of repossesion issued by the United States District Court",
    disclaimer = "The recipient of this repossesion order is hereby ordered to return any goods stated in the below information areas",
    information = {
      { id = "i1", label = "Recipients Name", type = "text_input", placement = "(Recipients Name)", required = "true", value = "" },
      { id = "i2", label = "Case No:", type = "text_input", placement = "(Case No:)", required = "true", value = "" },
      { id = "i3", label = "Witness Name:", type = "text_input", placement = "(The name of the witness)", required = "true", value = "" },
      { id = "i4", label = "Witness Title:", type = "text_input", placement = "(The title of the witness)", required = "true", value = "" },
    },
    extended_information = {
      { id = "e1", label = "Location:", type = "text_input", placement = "(Location when signing)", required = "true", value = "" },
      { id = "e2", label = "Date and Time:", type = "text_input", placement = "(Time/Date of signing)", required = "true", value = "" },
      { id = "e3", label = "Repossesion Information:", type = "text_area", placement = "(Information of the repossesion here)", required = "false", value = "" },
    },
    terms_and_conditions = {
      {label = "You have 7 days following reciept of this letter to arrange/appeal this order. Failure to do so within the staed time frame will void any appeals related to this case"},
      {label = "Destroying this document after reciept is seen as destruction of government property"},
      {label = "Any attempt to transfer/sell/trade or otherwise, anything related to this Order of Repossesion is seen as a criminal act"},
      {label = "Refusal to accept this Order will NOT halt proceeedings taking place"},
    },
    sign = ""
  },
}
