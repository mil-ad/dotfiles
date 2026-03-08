-- Autoload: scans the directory of the current file and adds matching
-- media files to the playlist, sorted naturally.

local utils = require 'mp.utils'

local EXTENSIONS = {}
for _, ext in ipairs({
    -- video
    '3g2', '3gp', 'avi', 'flv', 'm2ts', 'm4v', 'mj2', 'mkv', 'mov',
    'mp4', 'mpeg', 'mpg', 'ogv', 'rmvb', 'webm', 'wmv', 'y4m',
    -- audio
    'aiff', 'ape', 'au', 'flac', 'm4a', 'mka', 'mp3', 'oga', 'ogg',
    'ogm', 'opus', 'wav', 'wma',
}) do
    EXTENSIONS[ext] = true
end

local function get_extension(path)
    return path:match("%.([^%.]+)$")
end

-- http://notebook.kulchenko.com/algorithms/alphanumeric-natural-sorting-for-humans-in-lua
local function alphanumsort(filenames)
    local function padnum(n, d)
        return #d > 0 and ("%03d%s%.12f"):format(#n, n, tonumber(d) / (10 ^ #d))
            or ("%03d%s"):format(#n, n)
    end
    local tuples = {}
    for i, f in ipairs(filenames) do
        tuples[i] = {f:lower():gsub("0*(%d+)%.?(%d*)", padnum), f}
    end
    table.sort(tuples, function(a, b)
        return a[1] == b[1] and #b[2] < #a[2] or a[1] < b[1]
    end)
    for i, tuple in ipairs(tuples) do filenames[i] = tuple[2] end
    return filenames
end

local autoloaded = nil

local function find_and_add_entries()
    local path = mp.get_property("path", "")
    local dir, filename = utils.split_path(path)
    if #dir == 0 then return end

    -- don't touch manually created playlists
    local pl_count = mp.get_property_number("playlist-count", 1)
    if pl_count > 1 and not autoloaded then return end

    local all_files = utils.readdir(dir, "files") or {}

    -- filter to matching extensions, skip hidden files, always keep current
    local files = {}
    for _, f in ipairs(all_files) do
        if f == filename then
            files[#files + 1] = f
        elseif not f:match("^%.") then
            local ext = get_extension(f)
            if ext and EXTENSIONS[ext:lower()] then
                files[#files + 1] = f
            end
        end
    end

    alphanumsort(files)

    -- find current file position
    local current
    for i, f in ipairs(files) do
        if f == filename then
            current = i
            break
        end
    end
    if not current then return end

    -- build set of existing playlist entries
    local existing = {}
    for _, entry in ipairs(mp.get_property_native("playlist", {})) do
        existing[entry.filename] = true
    end

    -- append files after current, then prepend files before current
    for i = current + 1, #files do
        local filepath = dir .. files[i]
        if not existing[filepath] then
            mp.commandv("loadfile", filepath, "append")
        end
    end

    if pl_count == 1 then
        for i = 1, current - 1 do
            local filepath = dir .. files[i]
            if not existing[filepath] then
                mp.commandv("loadfile", filepath, "append")
            end
        end
        -- move original file to its correct sorted position
        if current > 1 then
            mp.commandv("playlist-move", 0, current)
        end
    end

    autoloaded = true
end

mp.register_event("start-file", find_and_add_entries)

