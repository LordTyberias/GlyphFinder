local _, addon = ...

addon.localizations = addon.localizations or {}
local localizations = addon.localizations

local locale = GetLocale()
if locale == 'enGB' then
    locale = 'enUS'
end

local proxy = addon.L
if type(proxy) ~= 'table' then
    proxy = {}
    addon.L = proxy
end

setmetatable(proxy, {
    __call = function(_, newLocale)
        if type(newLocale) ~= 'string' then
            return localizations.enUS or {}
        end
        localizations[newLocale] = localizations[newLocale] or {}
        return localizations[newLocale]
    end,
    __index = function(_, key)
        local active = localizations[locale] or localizations.enUS
        if active and active[key] ~= nil then
            return active[key]
        end
        local fallback = localizations.enUS
        if fallback and fallback[key] ~= nil then
            return fallback[key]
        end
        return tostring(key)
    end,
})

local enUS = proxy('enUS')
enUS["NO_GLYPH_DATA"] = "No glyph data is loaded."
enUS["NO_GLYPH_DATA_FOR_SET"] = "No glyph data is loaded for this set"
enUS["NO_GLYPHS_FOR_CURRENT_ZONE"] = "No glyph data was found for the current zone."
enUS["WAYPOINTS_ADDED"] = "Waypoints added: %d"
enUS["COMMAND_SET_DF"] = "Sets waypoints to all loaded Dragonflight glyphs."
enUS["COMMAND_SET_TWW"] = "Sets waypoints to all loaded The War Within glyphs."
enUS["COMMAND_SET_MIDNIGHT"] = "Sets waypoints to all loaded Midnight glyphs."
enUS["COMMAND_SET"] = "Sets waypoints to all glyphs in the current zone."
