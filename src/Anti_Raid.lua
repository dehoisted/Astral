local Anti_Raid = {
    running = true,
    Blacklisted_Users = {
        --If text in here is in a members username, then they will be banned
        { u1 = "tokens", u2 = "gg/", u3 = "gg /" },
        { u1 = "raid", u2 = "bot ", u3 = "join gg"},
    },
}

---Turns on the anti raid. Its on by default.
function Anti_Raid:TurnOn()
    self.running = true
end

---Turns off the anti raid.
function Anti_Raid:TurnOff()
    self.running = false;
end

---Gets whether the anti raid is running or not. Returns **running** (bool) if on, and false if not.
---@return boolean
function Anti_Raid:IsRunning()
    return self.running
end

---Main function for anti raid, returns true if word in string is blacklisted, false if not.
---@param user table
---@return boolean
function Anti_Raid:Check(user)
    assert(self.running, "Anti Raid is not running. Cannot call Check function.")
	if string.len(user.avatarURL) == 46 then
		print("[Anti Raid] Found user joined with no avatar: \""..user.username.."\", trying to ban user... ("..user.id..")")
        return true
	end
    for index, data in ipairs(self.Blacklisted_Users) do
        for key, blacklisted_user in pairs(data) do
            if string.find(user.username, blacklisted_user) then
                print("[Anti Raid] User \""..user.username.."\" has blacklisted text in name. ID: "..user.username..", bad text("..blacklisted_user..")")
                return true
            end
        end
    end
    return false
end

return Anti_Raid