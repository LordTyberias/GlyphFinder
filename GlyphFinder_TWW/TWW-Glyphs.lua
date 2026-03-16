-- Glyph coordinate data
local TWW_GLYPH_DATA = {
    --X coord, Y coord, achievement ID, map ID ~~ /dump C_Map.GetBestMapForUnit("player")
    { -- K'aresh
        {60.9, 38.7, 42717, 2371}, -- Castigaar
        {46.4, 58.4, 42718, 2371}, -- Eco-Dome Primus
        {54.6, 23.3, 42715, 2371}, -- Fracture of Laacuna
        {76.4, 46.3, 42719, 2371}, -- North Sufaad
        {54.7, 53.1, 42713, 2371}, -- Serrated Peaks
        {43.9, 17.0, 42716, 2371}, -- Shadow Point
        {55.1, 67.5, 42712, 2472}, -- Tazavesh
        {74.0, 32.5, 42714, 2371} -- The Oasis
    },
    { -- Isle of Dorn
        {78.2, 42.7, 40669, 2248}, -- Cinderbrew Meadery
        {44.4, 79.8, 40665, 2248}, -- Dhar Durgaz
        {23.1, 58.5, 40663, 2248}, -- Dhar Oztan
        {71.8, 47.2, 40671, 2248}, -- Ironwold
        {62.1, 44.9, 40670, 2248}, -- Mourning Rise
        {37.9, 40.9, 40664, 2248}, -- Storm's Watch
        {68.2, 71.7, 40666, 2248}, -- Sunken Shield
        {75.7, 22.2, 40152, 2248}, -- The Three Shields
        {47.8, 26.9, 40667, 2248}, -- Thul Medran
        {56.2, 17.7, 40668, 2248} -- Thunderhead Peak
    },
    { -- The Ringing Deeps
        {63.8, 95.0, 40678, 2214}, -- Abyssal Excavation
        {69.4, 34.4, 40675, 2214}, -- Chittering Den
        {49.0, 31.5, 40672, 2214}, -- Gundargaz
        {57.1, 31.3, 40674, 2214}, -- Lost Mines
        {62.9, 66.0, 40679, 2214}, -- Taelloch Mine
        {49.2, 66.2, 40677, 2214}, -- The Living Grotto
        {56.1, 56.0, 40676, 2214}, -- The Rumbling Wastes
        {46.9, 10.0, 40673, 2214}, -- The Stonevault Exterior
        {46.4, 51.6, 40680, 2214} -- The Waterworks
    },
    { -- Hallowfall
        {62.8, 7.1, 40685, 2215}, -- Bleak Sand
        {69.9, 44.2, 40684, 2215}, -- Dunelle's Kindness
        {30.7, 51.5, 40688, 2215}, -- Fortune's Fall
        {43.3, 52.7, 40686, 2215}, -- Mereldar
        {35.3, 33.9, 40687, 2215}, -- Priory of the Sacred Flame
        {63.7, 65.4, 40683, 2215}, -- Sanguine Grasps
        {57.2, 32.7, 40682, 2215}, -- Sina's Yearning
        {57.6, 64.6, 40690, 2215}, -- Tenir's Ascent
        {62.8, 51.8, 40681, 2215}, -- The Fangs
        {45.7, 12.3, 40689, 2215} -- Velhan's Claim
    },
    { -- Azj-Kahet
        {63.4, 13.9, 40691, 2255}, -- Arathi's End
        {58.5, 89.7, 40696, 2255}, -- Deepwalker Pass
        {42.9, 57.1, 40694, 2255}, -- Eye of Ansurek
        {13.2, 34.0, 40695, 2213}, -- Old Sacrificial Pit
        {73.0, 84.7, 40698, 2255}, -- Rak-Ush
        {25.1, 40.8, 40693, 2255}, -- Ruptured Lake
        {46.6, 21.2, 40692, 2255}, -- Siegehold
        {57.5, 57.3, 40699, 2255}, -- Silken Ward
        {66.3, 84.8, 40697, 2255}, -- The Maddening Deep
        {70.5, 25.0, 40700, 2255}, -- Trickling Abyss
        {65.4, 51.7, 40701, 2255} -- Untamed Valley
    }
}

GF:RegisterGlyphPlugin("tww", TWW_GLYPH_DATA)
