local Basic_Cmds = {
    color_code = 0x000000, --0x000000 is the default hex color code, it will be given a value later - its value is in "Settings.lua"
    success_emoji = "✅",
    error_emoji = "❌",
}

-- May error if you try to add more valid prefixes.
local Valid_Prefixes = {">", "<", "+", "-", ";", ":", ".", ",", "=", "_", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")",}

local function contains(table, val)
    for i=1,#table do
        if table[i] == val then
            return true
        end
    end
    return false
end

-- Help cmd
function Basic_Cmds:help(message, embed_function)
    embed_function(message, self.color_code)
end

-- About cmd
function Basic_Cmds:about(message,  Settings, Operating_System)
    message:reply {
        embed = {
            title = "About",
            description = "Multi-Purpose Auto Moderation Bot\nSource code & docs: "..Settings.Bot_Link,
            fields = {
                {
                    name = "Basic Info",
                    value = "Astrals main purpose is for auto moderation and logging data.\nBot made using the discordia library for Lua. Click [here](https://github.com/SinisterRectus/Discordia) for more information.\nBot version: "..Settings.Bot_Version,
                    inline = true
                },
                {
                    name = "Extra Info",
                    value = "Current operating system: "..Operating_System,
                    inline = false
                }
            },
            footer = {
				text = "Made by Orlando/Dehoisted",
			},
            color = self.color_code
        }
    }
end

-- Prefix command, gives prefix and can set prefix
---@return string prefix
function Basic_Cmds:prefix(message, prefix, member)
    local content = message.content
    local args = content:split(" ")
    if args[2] == nil then
        message:reply {
			embed = {
				title = "Prefix",
				description = "Current prefix: "..prefix,
                fields = {
                    {
                        name = "Info",
                        value = "Default bot prefix: >\nTo set the prefix, pass an argument for this command",
                        inline = true
                    }
                },
				color = self.color_code
			}
		}
        return prefix
    elseif not member:hasPermission("administrator") then message:reply("You need admin perms to set the bot prefix.") return prefix
    elseif string.len(args[2]) >= 2 then message:reply("Given prefix must be 1 character.") return prefix
    elseif contains(Valid_Prefixes, args[2]) then
        prefix = args[2]
        message:reply {
			embed = {
				title = "Prefix",
				description = "Set \""..prefix.."\" as the current bot prefix\n\n"..self.success_emoji,
				color = self.color_code
			}
		}
        return prefix
    else message:reply("Invalid bot prefix.")
        return prefix
    end
end

-- Uptime cmd
function Basic_Cmds:uptime(message)
    local uptime = "Error getting bot uptime"
    local file = io.open("uptime.txt")
    local uptime_file = file:lines()
    for data in uptime_file do
        uptime = data
    end

    message:reply {
        embed = {
            title = "Uptime",
            description = uptime,
            footer = {
                text = "Note: Date is when bot instance started"
            },
            color = self.color_code
        }
    }
end

-- Member count cmd
function Basic_Cmds:member_count(message)
    local total_members = message.guild.totalMemberCount
	message:reply {
		embed = {
        	title = "Member Count",
			description = "Total: "..total_members,
			footer = {
				text = os.date("%c"),
			},
			color = self.color_code
        }
	}
end

-- Purge cmd
function Basic_Cmds:purge(message, args, prefix)
	if args[2] == nil then message:reply("Pass in the amount of messages you want to purge. (number)") end
    local member = message.guild:getMember(message.author.id)
    if not member:hasPermission("manageMessages") then message:reply("You need manage messages perms.") return end
    local number = tonumber(args[2]) ~= nil
    if not number then message:reply("You have to pass in a number.") return end
	local messages = message.channel:getMessages(args[2])
    local msgs = messages:toArray(function(msg)
        if msg.content:find(prefix) or msg.author.bot then
           return true end
    end)
    local status, response = pcall(message.channel:bulkDelete(msgs))
    if not status and response == "attempt to call a boolean value" then
        message:reply {
		    embed = {
        	    title = "Purge",
			    description = "Purged "..args[2].." messages\n\n"..self.success_emoji,
			    color = self.color_code
            }
	    }
    else
        message:reply {
            embed = {
                title = "Purge",
                description = "Failed to purge messages\n\n"..self.error_emoji,
                color = self.color_code
            }
        }
    end
end

return Basic_Cmds