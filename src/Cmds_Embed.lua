local Commands = require("./Commands")
local function embed(message, color_code)
    message:reply {
        embed = {
                title = "Commands List",
                description = "Showing Basic Cmds & Mod Cmds",
                fields = {
                    {
                    name = Commands[1].name,
                    value = Commands[1].desc,
                    inline = true
                },
                {
                    name = Commands[2].name,
                    value = Commands[2].desc,
                    inline = true
                },
                {
                    name = Commands[3].name,
                    value = Commands[3].desc,
                    inline = true
                },
                {
                    name = Commands[4].name,
                    value = Commands[4].desc,
                    inline = true
                },
                {
                    name = Commands[5].name,
                    value = Commands[5].desc,
                    inline = true
                },
                {
                    name = Commands[6].name,
                    value = Commands[6].desc,
                    inline = true
                },
                {
                    name = Commands[7].name,
                    value = Commands[7].desc,
                    inline = true
                },
                {
                    name = Commands[8].name,
                    value = Commands[8].desc,
                    inline = true
                },
                {
                    name = Commands[9].name,
                    value = Commands[9].desc,
                    inline = true
                },
                {
                    name = Commands[10].name,
                    value = Commands[10].desc,
                    inline = true
                },
            },
            footer = {
                text = "Commands shown: 10"
            },
            color = color_code
        }
    }
end

return embed