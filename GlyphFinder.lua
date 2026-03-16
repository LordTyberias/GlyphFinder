SLASH_GF1 = '/gf'

local addonName, addon = ...
local GF = addon
local L = addon.L

-- Saved Variables

-- Data
local GLYPH_DATA = {}

function GF:RegisterGlyphPlugin(pluginData)
    if (type(pluginData) ~= "table") then
        return
    end

    for i=1,#pluginData,1 do
        table.insert(GLYPH_DATA, pluginData[i])
    end
end


if (select(4, GetBuildInfo()) > 120001) then
    print('|cff31d6bb' .. L["OUT_OF_DATE"]) -- GlyphFinder addon out of date, please check for update.
end

if (STOPPED == nil) then
    STOPPED = true
end

function GF:AddWayPoint(m, x, y, label)
    if (TomTom == nil) then
        return
    end
    if m and x and y then
        TomTom:AddWaypoint(m, x/100, y/100, {
            title = label,
            from = "GlyphFinder"
        })
    end
end

function GF:GetAchievement(id)
    if (id == nil or id == 0) then
        return nil, false
    end

    local IDNumber, Name, Points, Completed, Month, Day, Year, Description, Flags, Image, RewardText, isGuildAch = GetAchievementInfo(id)

    if (Name == nil) then
        return nil, false
    end

    local nameParts = GF:Split(Name, ":")
    if (nameParts[2] == nil) then
        return Name, Completed
    end

    return strsub(nameParts[2], 2), Completed
end

function GF:GetZoneNameById(id)
    local mapname = C_Map.GetAreaInfo(id)
    return mapname
end

function GF:CheckList()
    for z=1,#GLYPH_DATA,1 do
        local zone = '|cff31d6bb' .. GF:GetZoneName(z) .. ':'
        print (zone)
        local remaining = ''
        for i=1,#(GLYPH_DATA[z]),1 do
            local glyph = GLYPH_DATA[z][i]
            local name, completed = GF:GetAchievement(glyph[3])
            local fallbackName = glyph[5]

            if (name == nil and fallbackName ~= nil) then
                name = fallbackName
            end

            if (name == nil) then
                name = "Unknown Glyph"
            end

            if (not completed) then
                if (remaining == '') then
                    remaining = remaining .. name
                else
                    remaining = remaining .. ', ' .. name
                end
            end
        end
        if (remaining == '') then
            remaining = L["COMPLETE"]
        end
        print (remaining)
    end
end

function GF:Split(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

function GF:GetZoneName(zone)
    if (GLYPH_DATA[zone] and GLYPH_DATA[zone][1]) then
        local mapId = GLYPH_DATA[zone][1][4]
        local zoneName = GF:GetZoneNameById(mapId)
        if (zoneName ~= nil) then
            return zoneName
        end
    end

    return tostring(zone)
end

local function GetGlyphSetFilter(setName)
    if (setName == "df") then
        return function(achievementId)
            return achievementId ~= nil and achievementId >= 15000 and achievementId < 40000
        end
    elseif (setName == "tww") then
        return function(achievementId)
            return achievementId ~= nil and achievementId >= 40000 and achievementId < 60000
        end
    elseif (setName == "midnight") then
        return function(achievementId)
            return achievementId ~= nil and achievementId >= 60000
        end
    end

    return nil
end

local function PrintHelp()
    print('|cff31d6bb/gf help: ' .. L["COMMAND_HELP"])
    print('|cff31d6bb/gf set: ' .. L["COMMAND_SET"])
    print('|cff31d6bb/gf set df: ' .. L["COMMAND_SET_DF"])
    print('|cff31d6bb/gf set tww: ' .. L["COMMAND_SET_TWW"])
    print('|cff31d6bb/gf set midnight: ' .. L["COMMAND_SET_MIDNIGHT"])
    print('|cff31d6bb/gf check: ' .. L["COMMAND_CHECK"])
    print('|cff31d6bb/gf auto: ' .. L["COMMAND_AUTO"])
end

local function AddMissingGlyphWaypoint(glyph)
    local achievementId = glyph[3]
    local name, completed = GF:GetAchievement(achievementId)

    if (name == nil and glyph[5] ~= nil) then
        name = glyph[5]
    end

    if (name == nil) then
        name = "Unknown Glyph"
    end

    if (completed == false) then
        GF:AddWayPoint(glyph[4], glyph[1], glyph[2], name)
    end
end

local function SetGlyphWaypoints(filterFunc)
    STOPPED = false

    for z=1,#GLYPH_DATA,1 do
        for i=1,#(GLYPH_DATA[z]),1 do
            local glyph = GLYPH_DATA[z][i]
            if (filterFunc(glyph)) then
                AddMissingGlyphWaypoint(glyph)
            end
        end
    end
end

local function MyAddonCommands(msg, editbox)
    local command, arg = strsplit(" ", strlower(strtrim(msg or "")), 2)

    if command == 'check' then
        GF:CheckList()
    elseif command == 'auto' then
        if (TomTom == nil) then
            print('|cff31d6bb' .. L["REQUIRES_TOMTOM"])
            return
        end
        STOPPED = not STOPPED
        if (STOPPED == true) then
            print('|cff31d6bb' .. L["AUTO_OFF"]) -- Auto-tracking to nearest waypoint off.
        else
            print('|cff31d6bb' .. L["AUTO_ON"]) -- Auto-tracking to nearest waypoint on.
        end
    elseif command == 'help' then
        PrintHelp()
    elseif command == 'set' then
        if (TomTom == nil) then
            print('|cff31d6bb' .. L["REQUIRES_TOMTOM"])
            return
        end
        if (arg == nil or arg == '') then
            local currentMapId = C_Map.GetBestMapForUnit("player")
            if (currentMapId == nil) then
                PrintHelp()
                return
            end

            SetGlyphWaypoints(function(glyph)
                return glyph[4] == currentMapId
            end)
            return
        end

        local filter = GetGlyphSetFilter(arg)
        if (filter == nil) then
            PrintHelp()
            return
        end

        SetGlyphWaypoints(function(glyph)
            return filter(glyph[3])
        end)
    else
        PrintHelp()
    end
end

SlashCmdList["GF"] = MyAddonCommands

local glyphFinderFrame = CreateFrame("Button", "glyphFinderFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate" or nil)

do
    local throttle = 0.1;
    function FindClosestWayPoint(self, elapsed)
        if (TomTom == nil or STOPPED == true) then
            return
        end
        throttle = throttle + elapsed
        if (throttle > 0.1) then
            TomTom:SetClosestWaypoint()
            throttle = 0
        end
    end
end

glyphFinderFrame:SetScript("OnUpdate", FindClosestWayPoint)
