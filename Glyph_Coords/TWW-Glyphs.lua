-- Glyph coordinate data
local TWW_GLYPH_DATA = {
    --X coord, Y coord, achievement ID, map ID ~~ /dump C_Map.GetBestMapForUnit("player")
    { -- K'aresh
        {60.9, 38.7, 0, 2371}, -- Castigaar
        {46.4, 58.4, 0, 2371}, -- Eco-Dome Primus
        {54.6, 23.3, 0, 2371}, -- Fracture of Laacuna
        {76.4, 46.3, 0, 2371}, -- North Sufaad
        {54.7, 53.1, 0, 2371}, -- Serrated Peaks
        {43.9, 17.0, 0, 2371}, -- Shadow Point
        {55.1, 67.5, 0, 2472}, -- Tazavesh
        {74.0, 32.5, 0, 2371} -- The Oasis
    },
    { -- Isle of Dorn
        {78.2, 42.7, 0, 2248}, -- Cinderbrew Meadery
        {44.4, 79.8, 0, 2248}, -- Dhar Durgaz
        {23.1, 58.5, 0, 2248}, -- Dhar Oztan
        {71.8, 47.2, 0, 2248}, -- Ironwold
        {62.1, 44.9, 0, 2248}, -- Mourning Rise
        {37.9, 40.9, 0, 2248}, -- Storm's Watch
        {68.2, 71.7, 0, 2248}, -- Sunken Shield
        {75.7, 22.2, 0, 2248}, -- The Three Shields
        {47.8, 26.9, 0, 2248}, -- Thul Medran
        {56.2, 17.7, 0, 2248} -- Thunderhead Peak
    },
    { -- The Ringing Deeps
        {63.8, 95.0, 0, 2214}, -- Abyssal Excavation
        {69.4, 34.4, 0, 2214}, -- Chittering Den
        {49.0, 31.5, 0, 2214}, -- Gundargaz
        {57.1, 31.3, 0, 2214}, -- Lost Mines
        {62.9, 66.0, 0, 2214}, -- Taelloch Mine
        {49.2, 66.2, 0, 2214}, -- The Living Grotto
        {56.1, 56.0, 0, 2214}, -- The Rumbling Wastes
        {46.9, 10.0, 0, 2214}, -- The Stonevault Exterior
        {46.4, 51.6, 0, 2214} -- The Waterworks
    },
    { -- Hallowfall
        {62.8, 7.1, 0, 2215}, -- Bleak Sand
        {69.9, 44.2, 0, 2215}, -- Dunelle's Kindness
        {30.7, 51.5, 0, 2215}, -- Fortune's Fall
        {43.3, 52.7, 0, 2215}, -- Mereldar
        {35.3, 33.9, 0, 2215}, -- Priory of the Sacred Flame
        {63.7, 65.4, 0, 2215}, -- Sanguine Grasps
        {57.2, 32.7, 0, 2215}, -- Sina's Yearning
        {57.6, 64.6, 0, 2215}, -- Tenir's Ascent
        {62.8, 51.8, 0, 2215}, -- The Fangs
        {45.7, 12.3, 0, 2215} -- Velhan's Claim
    },
    { -- Azj-Kahet
        {63.4, 13.9, 0, 2255}, -- Arathi's End
        {58.5, 89.7, 0, 2255}, -- Deepwalker Pass
        {42.9, 57.1, 0, 2255}, -- Eye of Ansurek
        {13.2, 34.0, 0, 2213}, -- Old Sacrificial Pit
        {73.0, 84.7, 0, 2255}, -- Rak-Ush
        {25.1, 40.8, 0, 2255}, -- Ruptured Lake
        {46.6, 21.2, 0, 2255}, -- Siegehold
        {57.5, 57.3, 0, 2255}, -- Silken Ward
        {66.3, 84.8, 0, 2255}, -- The Maddening Deep
        {70.5, 25.0, 0, 2255}, -- Trickling Abyss
        {65.4, 51.7, 0, 2255} -- Untamed Valley
    }
}

GF:RegisterGlyphPlugin(TWW_GLYPH_DATA)
