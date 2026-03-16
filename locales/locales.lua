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
