local Anti_Invite = {
    --Private var. Determines whether the Anti Invite is running or not.
    running = true,
    -- Deleted Automatically when this text is in a message
    Invites = {
        { inv1 = "gg/", inv2 = "join /", inv3 = " gg " },
        { inv1 = "discord.me", inv2 = "join gg", inv3 = "gg /", inv4 = "join my server"},
    },
}

---Turns on the anti invite. Its on by default.
function Anti_Invite:TurnOn()
    self.running = true
end

---Turns off the anti invite.
function Anti_Invite:TurnOff()
    self.running = false;
end

---Gets whether the anti invite is running or not. Returns **running** (bool) if on, and false if not.
---@return boolean
function Anti_Invite:IsRunning()
    return self.running
end

---Main function for anti invite, returns true if message is blacklisted, false if not.
---@param user string
---@param message string
---@return boolean
function Anti_Invite:Check(user, message)
    assert(self.running, "Anti Invite is not running. Cannot call Check function.")
    for index, data in ipairs(self.Invites) do
        for key, invite in pairs(data) do
            if string.find(message, invite) then
                print("[Anti Invite] User \""..user.."\" sent invite ("..invite.."), full message: \""..message.."\"")
                return true
            end
        end
    end
    return false
end

return Anti_Invite