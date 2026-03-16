-- Glyph coordinate data
local MIDNIGHT_GLYPH_DATA = {
    --X coord, Y coord, achievement ID, map ID ~~ /dump C_Map.GetBestMapForUnit("player")
    { -- Eversong Woods
        {65.23, 32.63, 61522, 2395}, -- Brightwing Estate
        {33.45, 65.27, 61525, 2395}, -- Daggerspine Point
        {62.61, 62.80, 61529, 2395}, -- Dawnstar Spire
        {43.19, 46.42, 61524, 2395}, -- Fairbreeze Village
        {39.96, 59.63, 61527, 2395}, -- Goldenmist Village
        {49.46, 48.05, 61531, 2395}, -- Path of Dawn
        {58.92, 19.50, 61523, 2395}, -- Silvermoon City
        {58.43, 58.31, 61526, 2395}, -- Suncrown Tree
        {39.45, 45.63, 61530, 2395}, -- Sunsail Anchorage
        {48.35, 6.64, 61521, 2393}, -- The Shining Span
        {52.49, 67.62, 61528, 2395} -- Tranquillien
    },
    { -- Zul'Aman
        {63.78, 81.85, 61540, 2395}, -- Amani Pass
        {30.45, 84.72, 61537, 2437}, -- Nalorakk's Prowl
        {19.22, 70.74, 61534, 2437}, -- Revantusk Sedge
        {42.94, 34.36, 61532, 2437}, -- Shadebasin Watch
        {42.75, 80.19, 61541, 2437}, -- Spiritpaw Burrow
        {46.69, 82.23, 61539, 2437}, -- Solemn Valley
        {53.21, 54.50, 61535, 2437}, -- Strait of Hexx'alor
        {53.61, 80.39, 61533, 2437}, -- Temple of Akil'zon
        {51.49, 23.56, 61542, 2437}, -- Temple of Jan'alai
        {39.54, 19.72, 61536, 2437}, -- Witherbark Bluffs
        {27.91, 28.63, 61538, 2437} -- Zeb'Alar Lumberyard
    },
    { -- Harandar
        {54.74, 35.35, 61547, 2413}, -- Blooming Lattice
        {60.24, 44.41, 61543, 2413}, -- Blossoming Terrace
        {44.56, 62.86, 61549, 2413}, -- Fungara Village
        {61.86, 67.50, 61551, 2413}, -- Rift of Aln
        {69.36, 45.84, 61546, 2413}, -- Roots of Amirdrassil
        {73.08, 25.89, 61548, 2413}, -- Roots of Nordrassil
        {26.53, 61.39, 61550, 2413}, -- Roots of Shaldrassil
        {34.58, 23.13, 61545, 2413} -- Roots of Teldrassil
    },
    { -- Voidstorm
        {38.91, 76.11, 61563, 2405}, -- Ethereum Refinery
        {54.95, 45.54, 61561, 2405}, -- Gnawing Reach
        {36.28, 45.01, 61562, 2444}, -- Hanaar Outpost
        {45.29, 52.27, 61564, 2405}, -- Master's Perch
        {65.08, 71.93, 61565, 2405}, -- Obscurion Citadel
        {36.08, 37.30, 61566, 2405}, -- Shadowguard Point
        {39.90, 70.98, 61560, 2405}, -- The Bladeburrows
        {49.25, 87.48, 61567, 2405}, -- The Gorging Pit
        {35.67, 61.09, 61559, 2405}, -- The Ingress
        {37.16, 49.96, 61558, 2405}, -- The Molt
        {51.32, 62.77, 61557, 2405} -- The Voidspire
    }
}

GF:RegisterGlyphPlugin(MIDNIGHT_GLYPH_DATA)
