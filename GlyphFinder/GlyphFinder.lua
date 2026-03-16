SLASH_GF1 = '/gf'

local addonName, addon = ...
local GF = addon
_G.GF = GF
local L = addon.L

if STOPPED == nil then
    STOPPED = true
end

local GLYPH_SETS = {}
local SET_ORDER = { 'df', 'tww', 'midnight' }
local WAYPOINT_CACHE = {}
local lastAutoZoneKey = nil

local function NormalizeSetName(name)
    if type(name) ~= 'string' then
        return nil
    end
    name = string.lower(name)
    if name == 'dragonflight' then
        return 'df'
    end
    return name
end

local function BuildWaypointKey(mapId, x, y, label)
    return tostring(mapId) .. ':' .. tostring(x) .. ':' .. tostring(y) .. ':' .. tostring(label or '')
end

local function HasGlyphData()
    return next(GLYPH_SETS) ~= nil
end

local function GetGroupCount(setName)
    local groups = GLYPH_SETS[setName]
    return groups and #groups or 0
end

function GF:RegisterGlyphPlugin(setName, pluginData)
    if pluginData == nil and type(setName) == 'table' then
        pluginData = setName
        setName = 'misc'
    end

    setName = NormalizeSetName(setName) or 'misc'
    if type(pluginData) ~= 'table' then
        return
    end

    if GLYPH_SETS[setName] == nil then
        GLYPH_SETS[setName] = {}
    end

    for i = 1, #pluginData do
        table.insert(GLYPH_SETS[setName], pluginData[i])
    end
end

function GF:GetLoadedSetNames()
    local names = {}
    for _, setName in ipairs(SET_ORDER) do
        if GLYPH_SETS[setName] ~= nil then
            table.insert(names, setName)
        end
    end
    for setName in pairs(GLYPH_SETS) do
        local known = false
        for _, ordered in ipairs(SET_ORDER) do
            if ordered == setName then
                known = true
                break
            end
        end
        if not known then
            table.insert(names, setName)
        end
    end
    return names
end

function GF:Split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

function GF:GetAchievement(id)
    if id == nil or id == 0 then
        return nil, false
    end

    local _, name, _, completed = GetAchievementInfo(id)
    if name == nil then
        return nil, false
    end

    local nameParts = GF:Split(name, ":")
    if nameParts[2] == nil then
        return name, completed
    end

    return strsub(nameParts[2], 2), completed
end

function GF:GetZoneNameById(id)
    if id == nil then
        return nil
    end
    local mapInfo = C_Map.GetMapInfo(id)
    return mapInfo and mapInfo.name or nil
end

local function GetGroupZoneName(group, fallbackIndex)
    if type(group) ~= 'table' or group[1] == nil then
        return tostring(fallbackIndex or '?')
    end
    local mapId = group[1][4]
    return GF:GetZoneNameById(mapId) or tostring(fallbackIndex or '?')
end

local function IterateGroups(filterSet)
    local groups = {}
    if filterSet ~= nil then
        local setGroups = GLYPH_SETS[NormalizeSetName(filterSet)]
        if setGroups ~= nil then
            for i = 1, #setGroups do
                table.insert(groups, setGroups[i])
            end
        end
        return groups
    end

    for _, setName in ipairs(SET_ORDER) do
        local setGroups = GLYPH_SETS[setName]
        if setGroups ~= nil then
            for i = 1, #setGroups do
                table.insert(groups, setGroups[i])
            end
        end
    end
    for setName, setGroups in pairs(GLYPH_SETS) do
        local known = false
        for _, ordered in ipairs(SET_ORDER) do
            if ordered == setName then
                known = true
                break
            end
        end
        if not known then
            for i = 1, #setGroups do
                table.insert(groups, setGroups[i])
            end
        end
    end
    return groups
end

local function EnsureDataAvailable()
    if HasGlyphData() then
        return true
    end
    print('|cff31d6bb' .. L["NO_GLYPH_DATA"])
    return false
end

function GF:AddWayPoint(mapId, x, y, zone, label)
    if mapId and x and y then
        local key = BuildWaypointKey(mapId, x, y, label)
        if WAYPOINT_CACHE[key] then
            return false
        end
        WAYPOINT_CACHE[key] = true
        TomTom:AddWaypoint(mapId, x / 100, y / 100, {
            title = label,
            from = "GlyphFinder"
        })
        return true
    end
    return false
end

function GF:CheckList(filterSet)
    if not EnsureDataAvailable() then
        return
    end

    local groups = IterateGroups(filterSet)
    for z = 1, #groups do
        local group = groups[z]
        print('|cff31d6bb' .. GetGroupZoneName(group, z) .. ':')
        local remaining = ''
        for i = 1, #group do
            local glyph = group[i]
            local name, completed = GF:GetAchievement(glyph[3])
            if name == nil then
                name = 'Unknown Glyph'
            end
            if not completed then
                if remaining == '' then
                    remaining = name
                else
                    remaining = remaining .. ', ' .. name
                end
            end
        end
        if remaining == '' then
            remaining = L["COMPLETE"]
        end
        print(remaining)
    end
end

local function GetPlayerMapChain()
    local ids = {}
    local currentMap = C_Map.GetBestMapForUnit('player')
    while currentMap ~= nil do
        ids[currentMap] = true
        local info = C_Map.GetMapInfo(currentMap)
        currentMap = info and info.parentMapID or nil
        if currentMap == 0 then
            currentMap = nil
        end
    end
    return ids
end

local function FindCurrentZoneGroup()
    local mapChain = GetPlayerMapChain()
    for _, setName in ipairs(SET_ORDER) do
        local groups = GLYPH_SETS[setName]
        if groups ~= nil then
            for i = 1, #groups do
                local group = groups[i]
                for j = 1, #group do
                    local glyph = group[j]
                    if mapChain[glyph[4]] then
                        return group, setName, i
                    end
                end
            end
        end
    end
    for setName, groups in pairs(GLYPH_SETS) do
        local known = false
        for _, ordered in ipairs(SET_ORDER) do
            if ordered == setName then known = true break end
        end
        if not known then
            for i = 1, #groups do
                local group = groups[i]
                for j = 1, #group do
                    if mapChain[group[j][4]] then
                        return group, setName, i
                    end
                end
            end
        end
    end
    return nil, nil, nil
end

local function AddGroupWaypoints(group)
    if group == nil then
        return 0
    end
    local added = 0
    for i = 1, #group do
        local glyph = group[i]
        local name, completed = GF:GetAchievement(glyph[3])
        if name == nil then
            name = 'Unknown Glyph'
        end
        if not completed and GF:AddWayPoint(glyph[4], glyph[1], glyph[2], nil, name) then
            added = added + 1
        end
    end
    return added
end

local function AddSetWaypoints(setName)
    local groups = GLYPH_SETS[NormalizeSetName(setName)]
    if groups == nil then
        return 0
    end
    local added = 0
    for i = 1, #groups do
        added = added + AddGroupWaypoints(groups[i])
    end
    return added
end

local function PrintHelp()
    print('|cff31d6bb/gf set: ' .. L["COMMAND_SET"])
    print('|cff31d6bb/gf set df: ' .. L["COMMAND_SET_DF"])
    print('|cff31d6bb/gf set tww: ' .. L["COMMAND_SET_TWW"])
    print('|cff31d6bb/gf set midnight: ' .. L["COMMAND_SET_MIDNIGHT"])
    print('|cff31d6bb/gf check: ' .. L["COMMAND_CHECK"])
    print('|cff31d6bb/gf auto: ' .. L["COMMAND_AUTO"])
end

local function MyAddonCommands(msg)
    local args = GF:Split(msg or '', ' ')
    local command = string.lower(args[1] or '')
    local option = NormalizeSetName(args[2])

    if command == '' or command == 'help' then
        PrintHelp()
        return
    end

    if not EnsureDataAvailable() then
        return
    end

    if command == 'check' then
        GF:CheckList(option)
        return
    elseif command == 'auto' then
        STOPPED = not STOPPED
        lastAutoZoneKey = nil
        if STOPPED == true then
            print('|cff31d6bb' .. L["AUTO_OFF"])
        else
            print('|cff31d6bb' .. L["AUTO_ON"])
        end
        return
    elseif command == 'set' then
        local added = 0
        if option == 'df' or option == 'tww' or option == 'midnight' then
            if GetGroupCount(option) == 0 then
                print('|cff31d6bb' .. L["NO_GLYPH_DATA_FOR_SET"] .. ': ' .. option)
                return
            end
            added = AddSetWaypoints(option)
        else
            local group = FindCurrentZoneGroup()
            if group == nil then
                print('|cff31d6bb' .. L["NO_GLYPHS_FOR_CURRENT_ZONE"])
                return
            end
            added = AddGroupWaypoints(group)
        end
        print('|cff31d6bb' .. format(L["WAYPOINTS_ADDED"], added))
        return
    end

    PrintHelp()
end

SlashCmdList["GF"] = MyAddonCommands

local glyphFinderFrame = CreateFrame("Button", "glyphFinderFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate" or nil)

do
    local throttle = 0.1
    function FindClosestWayPoint(self, elapsed)
        if STOPPED == true then
            return
        end

        throttle = throttle + elapsed
        if throttle <= 0.1 then
            return
        end
        throttle = 0

        if not HasGlyphData() then
            return
        end

        local group, setName, index = FindCurrentZoneGroup()
        local zoneKey = setName and (setName .. ':' .. tostring(index)) or nil
        if zoneKey ~= nil and zoneKey ~= lastAutoZoneKey then
            AddGroupWaypoints(group)
            lastAutoZoneKey = zoneKey
        end

        TomTom:SetClosestWaypoint()
    end
end

glyphFinderFrame:SetScript("OnUpdate", FindClosestWayPoint)
