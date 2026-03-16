local _, addon = ...
addon.L = {}

local localizations = addon.L

local locale = GetLocale()
if locale == 'enGB' then
	locale = 'enUS'
end

local function hasLocale(loc)
	return localizations[loc] ~= nil
end

setmetatable(addon.L, {
	__call = function(_, newLocale)
		localizations[newLocale] = {}
		return localizations[newLocale]
	end,
	__index = function(_, key)
		if not hasLocale(locale) then
			locale = 'enUS' -- Default to US English if localization is not available
		end
		local localeTable = localizations[locale]
		return localeTable and localeTable[key] or tostring(key)
	end
})

L["NO_GLYPH_DATA"] = "No glyph data is loaded."

L["NO_GLYPH_DATA_FOR_SET"] = "No glyph data is loaded for this set"

L["NO_GLYPHS_FOR_CURRENT_ZONE"] = "No glyph data was found for the current zone."

L["WAYPOINTS_ADDED"] = "Waypoints added: %d"

L["COMMAND_SET_DF"] = "Sets waypoints to all loaded Dragonflight glyphs."

L["COMMAND_SET_TWW"] = "Sets waypoints to all loaded The War Within glyphs."

L["COMMAND_SET_MIDNIGHT"] = "Sets waypoints to all loaded Midnight glyphs."

L["COMMAND_SET"] = "Sets waypoints to all glyphs in the current zone."
