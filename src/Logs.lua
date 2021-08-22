local Logs = {
    OS = require("Get_OS"),
    --**Nonconstant** Var
    logging = false, -- -> At runtime, this value will be equal to the "Logging" value in Settings.lua
    guild_id = "",
    join_path = "",
    leave_path = "",
}

local function file_exists(file)
    local ok, err, code = os.rename(file, file)
    if not ok then
        if code == 13 then
          --Permission denied, but dir or file exists
            return true
        end
    end
    return ok --,err
end

local function dir_exists(path)
    return file_exists(path.."/")
end

-- Will **erase** all current data in log file (clean/restart)
---@param restart_join boolean
---@param restart_leave boolean
function Logs:Clean(restart_join, restart_leave)
    local date = os.date()
    if restart_join then
        local f1 = io.open(self.join_path, "w+")
        f1:write("Members joined log (User ID'S ONLY) - Started logging at: "..date.."\n")
        f1:close()
        print("[LOGS] File \""..self.join_path.."\" has been cleaned or created")
    end
    if restart_leave then
        local f2 = io.open(self.leave_path, "w+")
        f2:write("Members left log (User ID's ONLY) - Started logging at: "..date.."\n")
        f2:close()
        print("[LOGS] File \""..self.leave_path.."\" has been cleaned or created")
    end
end

--Check if the correct file(s) and directory(s) exist.
function Logs:Init()
    if dir_exists("Logs") == nil or false then
        os.execute("mkdir Logs")
        print("[LOGS] Directory for Logs did not exist, so it has been created.")
    end
    local uptime_f = io.open("uptime.txt", "w+")
	uptime_f:write(os.date())
	uptime_f:close()
    print("[LOGS] Updated uptime file.")
end

function Logs:Start()
    if self.OS == "Windows" then
        self.join_path = "Logs\\"..self.guild_id.."_member_joined.txt"
        self.leave_path = "Logs\\"..self.guild_id.."_members_left.txt"
    elseif self.OS == "Linux" then
        self.join_path = "Logs/"..self.guild_id.."_member_joined.txt"
        self.leave_path = "Logs/"..self.guild_id.."_member_left.txt"
    else assert(nil, "Your operating system is not supported.")
    end

    if file_exists(self.join_path) == nil or false then
        self:Clean(true, false) end
    if file_exists(self.leave_path) == nil or false then
        self:Clean(false, true) end
end

---@param id string
function Logs:MemberJoin(id)
    local f = io.open(self.join_path, "a")
    f:write("\n"..id)
    f:close()
end

---@param id string
function Logs:MemberLeave(id)
    local f = io.open(self.leave_path, "a")
    f:write("\n"..id)
    f:close()
end

return Logs