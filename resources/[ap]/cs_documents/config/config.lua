CodeStudio = {}

CodeStudio.AutoSQL = true

-- 'QB' = For QBCore Framework
-- 'ESX' = For ESX Framework

CodeStudio.ServerType = 'QB'    --QB|ESX

CodeStudio.JobDocuments = {
    ['police'] = {
        ShowDocument_Grade = 1,
        TemplateEditor_Grade = 4,
        PublicTemplate = true  --*Optional Enable this to allow creation of public documents templates
    },
    ['ambulance'] = {
        ShowDocument_Grade = 1,
        TemplateEditor_Grade = 4
    },
    ['lawyer'] = {
        ShowDocument_Grade = 0,
        TemplateEditor_Grade = 0
    },
    --ADD MORE JOBS AS PER YOUR NEEDS
}

CodeStudio.PublicTemplateByIdentifer = {  --Allow these identifier's / Discord Roles or ID / ACE Perms / Admins to create public documents templates. here you can add server admins if you want
    -- 'fivem:1333933',
    -- 'discord:968848387132772434',
}

CodeStudio.Documents = {
    Background_Blur = false,         --Add Background Blur whenever Document pops up
    EnableMouseControl = true,     --Use Mouse Constols
    Dotted_Background = true,      --Add Dots in the Document Background
    Download_Document_Option = true,     --*Requires Metadata Based Inventory
    Enable_Animation = true
}
