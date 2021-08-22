--Global Requires
local discordia = require("discordia")
local Settings = require("./Settings")
local Cmds = require("./Commands")
local Cmds_Embed = require("./Cmds_Embed")
--Global Vars
local Client = discordia.Client()
local Prefix = Settings.Prefix
local Logs = Cmds.Log.Logs
discordia.extensions()

Client:on("ready", function()
	Client:setGame{type = 1, name=Prefix.."help | "..Settings.Bot_Version} -- Type 1 = Playing, 2 = Listening, 3 = Watching
	Cmds.Basic.color_code = Settings.Basic_Color_Code
	Cmds.Mod.color_code = Settings.Mod_Color_Code
	Cmds.Log.color_code = Settings.Log_Color_Code
	Cmds.Extra.color_code = Settings.Log_Color_Code
	Logs.logging = Settings.Logging
	Logs:Init()
	print("Logged in as "..Client.user.username..", prefix: "..Settings.Prefix..", bot version: "..Settings.Bot_Version)
end)

Client:on("messageCreate", function(message)
    local content = message.content
    local args = content:split(" ")
	local author = message.author
	-- Secruity
	if author == Client.user then return end
	if Cmds.Mod.Anti_Invite:IsRunning() then
		if Cmds.Mod.Anti_Invite:Check(author.username, content) then message:delete() return end
	end
	if Cmds.Mod.Word_Blacklist:IsRunning() then
		if Cmds.Mod.Word_Blacklist:Check(author.username, content) then message:delete() return end
	end
	if string.find(content, "@everyone") then return
	elseif string.find(content, "@here") then return end

	--[[
		Basic Commands
	]]
	-- Help cmd
	if args[1] == Prefix..Cmds[1].name then
    	Cmds.Basic:help(message, Cmds_Embed)
		-- Alias help cmd
	elseif args[1] == Prefix..Cmds[1].alias then
		Cmds.Basic:help(message, Cmds_Embed)
	end
	-- About cmd
	if args[1] == Prefix..Cmds[2].name then
		Cmds.Basic:about(message, Settings, Logs.OS)
	end
	-- Prefix cmd
	if args[1] == Prefix..Cmds[3].name then
		local member = message.guild:getMember(message.author.id)
		Prefix = Cmds.Basic:prefix(message, Prefix, member)
	end
	-- Uptime cmd
	if args[1] == Prefix..Cmds[4].name then
		Cmds.Basic:uptime(message)
	end
	-- Member Count cmd
	if args[1] == Prefix..Cmds[5].name then
		Cmds.Basic:member_count(message)
		-- Alias member count cmd
	elseif args[1] == Prefix..Cmds[5].alias then
		Cmds.Basic:member_count(message)
	end
	-- Purge cmd
	if args[1] == Prefix..Cmds[6].name then
		Cmds.Basic:purge(message, args, Prefix)
	end

	--[[
		Moderation Commands
	]]
	-- Word Blacklist
	if args[1] == Prefix..Cmds[7].name then
		Cmds.Mod:word_blacklist(message)
	end
	-- Anti Invite
	if args[1] == Prefix..Cmds[8].name then
		Cmds.Mod:anti_invite(message)
	end
	-- Anti Raid
	if args[1] == Prefix..Cmds[9].name then
		Cmds.Mod:anti_raid(message)
	end

	--[[
		Log Commands
	]]
	-- Logs
	if args[1] == Prefix..Cmds[10].name then
		Cmds.Log:logs(message)
	end
	-- Start logs
	if args[1] == Prefix..Cmds[11].name then
		Cmds.Log:start_logs(message, message.guild.id)
	end
	-- Stop Logs
	if args[1] == Prefix..Cmds[12].name then
		Cmds.Log:stop_logs(message)
	end
	-- Members joined
	if args[1] == Prefix..Cmds[13].name then
		Cmds.Log:members_joined(message)
	end
	-- Members left
	if args[1] == Prefix..Cmds[14].name then
		Cmds.Log:members_left(message)
	end
	-- Clean logs
	if args[1] == Prefix..Cmds[15].name then
		Cmds.Log:clean_logs(message)
	end

	--[[
		Extra Cmds
	]]
	-- Nsfw (nsfw on/off)
	if args[1] == Prefix..Cmds[16].name then
		Cmds.Extra:nsfw(message, args)
	end
end)

Client:on("memberJoin", function(member)
	print(os.date("%c").. ": Member joined. Username: "..member.user.username..", ID = "..member.id)
	if Cmds.Mod.Anti_Raid:IsRunning() then
		if Cmds.Mod.Anti_Raid:Check(member.user) then
			member:ban()
			print("[Anti Raid] Banned target user")
		end
	end
	if Logs.logging then
		Logs:MemberJoin(member.id)
	end
end)

Client:on("memberLeave", function(member)
	print(os.date("%c").. ": Member left. Username: "..member.user.username..", ID = "..member.id)
	if Logs.logging then
		Logs:MemberLeave(member.id)
	end
end)

Client:run("Bot "..Settings.Token)