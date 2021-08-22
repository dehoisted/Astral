local Mod_Cmds = {
    color_code = 0x000000, --0x000000 is the default hex color code, it will be given a value later - its value is in "Settings.lua"
    success_emoji = "✅",
    error_emoji = "❌",
    permission_needed = "administrator", --Best to keep it that way; If you would like to edit it: https://github.com/SinisterRectus/Discordia/wiki/Enumerations
    Word_Blacklist = require("./Word_Blacklist"),
    Anti_Invite = require("./Anti_Invite"),
    Anti_Raid = require("./Anti_Raid"),
}

local function CheckPerms(message, color_code, permission, error_emoji)
    local member = message.guild:getMember(message.author.id)
    if not member:hasPermission(permission) then
        message:reply {
            embed = {
                title = "Perms Error",
                description = "You need "..permission.." perms to use mod commands.\n\n"..error_emoji,
                color = color_code
            }
        }
        return false
    end
    return true
end

--Local Embed Template - so code isn't reused
local function EmbedT_OnOff(message, name, status, color_code, success_emoji)
    message:reply {
        embed = {
            title = name,
            description = "Status is now: "..status.."\n\n"..success_emoji,
            color = color_code
        }
    }
end

function Mod_Cmds:word_blacklist(message)
    if CheckPerms(message, self.color_code, self.permission_needed, self.error_emoji) == false then return end
    if self.Word_Blacklist:IsRunning() then
        self.Word_Blacklist:TurnOff()
        EmbedT_OnOff(message, "Word Blacklist", "Off", self.color_code, self.success_emoji)
    else self.Word_Blacklist:TurnOn()
        EmbedT_OnOff(message, "Word Blacklist", "On", self.color_code, self.success_emoji)
    end
end

function Mod_Cmds:anti_invite(message)
    if CheckPerms(message, self.color_code, self.permission_needed, self.error_emoji) == false then return end
    if self.Anti_Invite:IsRunning() then
        self.Anti_Invite:TurnOff()
        EmbedT_OnOff(message, "Anti Invite", "Off", self.color_code, self.success_emoji)
    else self.Anti_Invite:TurnOn()
        EmbedT_OnOff(message, "Anti Invite", "On", self.color_code, self.success_emoji)
    end
end

function Mod_Cmds:anti_raid(message)
    if CheckPerms(message, self.color_code, self.permission_needed, self.error_emoji) == false then return end
    if self.Anti_Raid:IsRunning() then
        self.Anti_Raid:TurnOff()
        EmbedT_OnOff(message, "Anti Raid", "Off", self.color_code, self.success_emoji)
    else self.Anti_Raid:TurnOn()
        EmbedT_OnOff(message, "Anti Raid", "On", self.color_code, self.success_emoji)
    end
end

return Mod_Cmds