local BinaryFormat = package.cpath:match("%p[\\|/]?%p(%a+)")
if BinaryFormat == "dll" then
    function os.get_name()
        return "Windows"
    end
elseif BinaryFormat == "so" then
    function os.get_name()
        return "Linux"
    end
end

return os.get_name()