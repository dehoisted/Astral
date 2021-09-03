local Log_Cmds = {
    color_code = 0x000000, --0x000000 is the default hex color code, it will be given a value later - its value is in "Settings.lua"
    success_emoji = "✅",
    error_emoji = "❌",
    permission_needed = "administrator", --https://github.com/SinisterRectus/Discordia/wiki/Enumerations
    Logs = require("./Logs"),
}

local function CheckPerms(message, color_code, permission, error_emoji)
    local member = message.guild:getMember(message.author.id)
    if not member:hasPermission(permission) then
        message:reply {
            embed = {
                title = "Perms Error",
                description = "You need "..permission.." perms to use log commands\n\n"..error_emoji,
                color = color_code
            }
        }
        return false
    end
    return true
end

function Log_Cmds:logs(message)
    if CheckPerms(message, self.color_code, self.permission_needed, self.error_emoji) == false then return end
    message:reply {
        embed = {
            title = "Logs",
            description = "Permission needed to use log cmds: "..self.permission_needed,
            fields = {
                {
                    name = "logs",
                    value = "Shows this message",
                    inline = true
                },
                {
                    name = "start-logs",
                    value = "Starts file logging of members who join & leave",
                    inline = true
                },
                {
                    name = "stop-logs",
                    value = "Stops file logging of members who join & leave",
                    inline = true
                },
                {
                    name = "members-joined",
                    value = "Posts a file of all user ID's who joined the server",
                    inline = true
                },
                {
                    name = "members-left",
                    value = "Posts a file of all user ID's who left the server",
                    inline = true
                },
                {
                    name = "clean-logs",
                    value = "Clears/Restarts both log files",
                    inline = true
                },
            },
            footer = {
                text = "Commands shown: 6"
            },
            color = self.color_code
        }
    }
end

function Log_Cmds:start_logs(message, guild_id)
    if CheckPerms(message, self.color_code, self.permission_needed, self.error_emoji) == false then return end
    self.Logs.logging = true
    self.Logs.guild_id = guild_id
    self.Logs:Start()
    print("[LOGS] Started logging data")
    message:reply {
        embed = {
            title = "Logs",
            description = "Started logging data\n\n"..self.success_emoji,
            color = self.color_code
        }
    }
end

function Log_Cmds:stop_logs(message)
    if CheckPerms(message, self.color_code, self.permission_needed, self.error_emoji) == false then return end
    self.Logs.logging = false
    print("[LOGS] Stopped logging data")
    message:reply {
        embed = {
            title = "Logs",
            description = "Stopped logging data\n\n"..self.success_emoji,
            color = self.color_code
        }
    }
end

function Log_Cmds:members_joined(message)
    if CheckPerms(message, self.color_code, self.permission_needed, self.error_emoji) == false then return end
    local status, res = pcall(function()
        message:reply {
        files = {
            self.Logs.join_path,
            }
        }
        message.channel:send("👍")
    end)
    print(status)
    print(res)
end

function Log_Cmds:members_left(message)
    if CheckPerms(message, self.color_code, self.permission_needed, self.error_emoji) == false then return end
    local status, res = pcall(function()
        message:reply {
        files = {
            self.Logs.leave_path,
            }
        }
        message.channel:send("👍")
    end)
end

function Log_Cmds:clean_logs(message)
    if CheckPerms(message, self.color_code, self.permission_needed, self.error_emoji) == false then return end
    self.Logs:Clean(true, true)
    message:reply {
        embed = {
            title = "Logs",
            description = "Cleaned all data from logs\n\n"..self.success_emoji,
            color = self.color_code
        }
    }
end

return Log_Cmds
