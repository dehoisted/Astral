local Extra_Cmds = {
	color_code = 0x000000, --0x000000 is the default hex color code, it will be given a value later - its value is in "Settings.lua"
    success_emoji = "✅",
    error_emoji = "❌",
}

local function CheckPerms(message, permission, color_code, error_emoji)
	local member = message.guild:getMember(message.author.id)
	if not member:hasPermission(permission) then
        message:reply {
            embed = {
                title = "Perms Error",
                description = "You need "..permission.." perms to use mod commands\n\n"..error_emoji,
                color = color_code
            }
        }
    	return false
	end
	return true
end

-- Change channel's NSFW settings
function Extra_Cmds:nsfw(message, args)
	if args[2] == nil then return end
	if CheckPerms(message, "manageChannels") == false then return end
	local channel = message.channel
	if args[2] == "on" then
		local status, response = pcall(channel:enableNSFW())
		if not status and response == "attempt to call a boolean value" then
			print("[Nsfw CMD] Enabled channel as NSFW: "..channel.id)
			message:reply("👍")
		else message:reply("Failed at turning channel nsfw on")
		end
	elseif args[2] == "off" then
		local status, response = pcall(channel:disableNSFW())
		if not status and response == "attempt to call a boolean value" then
			print("[Nsfw CMD] Disabled channel as NSFW: "..channel.id)
			message:reply("👍")
		else message:reply("Failed at turning channel nsfw off")
		end
	else message:reply("Error: Argument has to be \"on\", or \"off\"")
	end
end

return Extra_Cmds