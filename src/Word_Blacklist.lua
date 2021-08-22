local Blacklisted_Words = require("./Blacklisted")

local Word_Blacklist = {
    running = true
}

---Turns on the word blacklist. Its on by default.
function Word_Blacklist:TurnOn()
    self.running = true
end

---Turns off the word blacklist.
function Word_Blacklist:TurnOff()
    self.running = false;
end

---Gets whether the word blacklist is running or not. Returns **running** (bool) if on, and false if not.
---@return boolean
function Word_Blacklist:IsRunning()
    return self.running
end

---Main function for word blacklist, returns true if word in string is blacklisted, false if not.
---@param user string
---@param message string
---@return boolean
function Word_Blacklist:Check(user, message)
    assert(self.running, "Word Blacklist is not running. Cannot call Check function.")
    for index, data in ipairs(Blacklisted_Words) do
        for key, blacklisted_word in pairs(data) do
            if string.find(message, blacklisted_word) then
                print("[Word Blacklist] User \""..user.."\" sent message with blacklisted word in it: \""..blacklisted_word.."\", full message: "..message)
                return true
            end
        end
    end
    return false
end

return Word_Blacklist