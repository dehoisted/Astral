return {
	Basic = require("./Basic_Cmds"),
	Mod = require("./Mod_Cmds"),
	Log = require("./Log_Cmds"),
	Extra = require("./Extra_Cmds"),
	-- Basic
	{ name = "help", alias = "cmds", desc = "Send this embed, \"cmds\" works too"},
	{ name = "about", desc = "Gives additional information about bot"},
	{ name = "prefix", desc = "Gives you information about the prefix - passing an argument will change the bot prefix"},
	{ name = "uptime", desc = "Gives you the amount of time the bot has been running"},
	{ name = "member-count", alias = "membercount", desc = "Gives you the amount of members currently in the server"},
	{ name = "purge", desc = "Purges the amount of messages you pass in (number)"},
	-- Moderation
	{ name = "word-blacklist", desc = "Word blacklist automatically deletes words that would get your discord server terminated\nRunning the command will switch it on or off."},
	{ name = "anti-invite", desc = "Automatically deletes messages that have an invite in them\nRunning the command will switch it on or off."},
	{ name = "anti-raid", desc = "Auto bans users with raid-like names, also bans users who join if they have no profile picture\nRunning the command will switch it on or off."},
	-- Logs (seperate embed)
	{ name = "logs", desc = "Gives help & commands concerning logs"},
	{ name = "start-logs", desc = "Starts file logging of members who join & leave"},
	{ name = "stop-logs", desc = "Stops file logging of members who join & leave"},
	{ name = "members-joined", "Posts a file of all user ID's who joined the server"},
	{ name = "members-left", "Posts a file of all user ID's who left the server"},
	{ name = "clean-logs", "Clears both log files"},
	-- Extra (not documented to users)
	{ name = "nsfw", desc = "Enables or disables nsfw in the current channel, example: nsfw \"on\""},
}
