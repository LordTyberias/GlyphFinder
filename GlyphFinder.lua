SLASH_GF1 = '/gf'

local addonName, addon = ...
local GF = addon
local L = addon.L

-- Saved Variables
STOPPED = true

-- Data
-- GLYPH_DATA is loaded from DF/DF_Glyphs.lua


if (select(4, GetBuildInfo()) > 120001) then
    print('|cff31d6bb' .. L["OUT_OF_DATE"]) -- GlyphFinder addon out of date, please check for update.
end

function GF:AddWayPoint(m, x, y, zone, label)
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
    local IDNumber, Name, Points, Completed, Month, Day, Year, Description, Flags, Image, RewardText, isGuildAch = GetAchievementInfo(id)
    return strsub(GF:Split(Name, ":")[2], 2), Completed
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
            local name, completed = GF:GetAchievement(GLYPH_DATA[z][i][3])
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
    if (zone == 1) then
        return GF:GetZoneNameById(13644)
    elseif (zone == 2) then
        return GF:GetZoneNameById(13645)
    elseif (zone == 3) then
        return GF:GetZoneNameById(13646)
    elseif (zone == 4) then
        return GF:GetZoneNameById(13647)
    elseif (zone == 5) then
        return GF:GetZoneNameById(13862)
    elseif (zone == 6) then
        return GF:GetZoneNameById(13769)
    elseif (zone == 7) then
        return GF:GetZoneNameById(14022)
    elseif (zone == 8) then
        return GF:GetZoneNameById(14529)
    end
end

local function MyAddonCommands(msg, editbox)
    if (TomTom == nil) then
        print('|cff31d6bb' .. L["REQUIRES_TOMTOM"]) -- GlyphFinder requires the TomTom addon.
        return
    end

    if msg == 'check' then
        GF:CheckList()
    elseif msg == 'auto' then
        STOPPED = not STOPPED
        if (STOPPED == true) then
            print('|cff31d6bb' .. L["AUTO_OFF"]) -- Auto-tracking to nearest waypoint off.
        else
            print('|cff31d6bb' .. L["AUTO_ON"]) -- Auto-tracking to nearest waypoint on.
        end
    elseif msg == 'set' then
        local zone = GetZoneText()
        local m,x,y = TomTom:GetCurrentPlayerPosition()
        local count = 0
        for z=1,#GLYPH_DATA,1 do
            for i=1,#(GLYPH_DATA[z]),1 do
                local name, completed = GF:GetAchievement(GLYPH_DATA[z][i][3])
                if (completed == false) then -- Haven't hit this one yet.
                    GF:AddWayPoint(GLYPH_DATA[z][i][4], GLYPH_DATA[z][i][1], GLYPH_DATA[z][i][2], zone, name)
                end
		    end
        end
    else
        print('|cff31d6bb/gf set: ' .. L["COMMAND_SET"]) -- Sets waypoints to all glyphs in current zone, activates tracking.
        print('|cff31d6bb/gf check: ' .. L["COMMAND_CHECK"]) -- List zones and indices of uncollected glyphs.
        print('|cff31d6bb/gf auto: ' .. L["COMMAND_AUTO"]) -- Toggle auto-tracking to nearest waypoint.
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
        local zone = GetZoneText()
        throttle = throttle + elapsed
        if (throttle > 0.1) then
            TomTom:SetClosestWaypoint()
            throttle = 0
        end
    end
end

glyphFinderFrame:SetScript("OnUpdate", FindClosestWayPoint)
