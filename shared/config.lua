-------------------------------------------------------------------
--- CDT Dev Fivem -------------------------------------------------
--- If you have any questions, you can join my discord :
--- https://dicord.gg/ae2jAmtQsm
-------------------------------------------------------------------

Options = {}

Options.debug = false

Options.key = "PAGEUP"      -- key to show/hide Ui Sports

--------------------------
-- db maj tick value
--------------------------
Options.majtick = 1 * 60 * 1000

--------------------------
-- maj effects tick value
--------------------------
Options.majeffectstick = 1 * 60 * 1000

--------------------------
-- maj Ui tick value
--------------------------
Options.majuitick = 1 * 60 * 1000

--------------------------
-- Strength
--------------------------
Options["strength"] = {
    --------------------------
    -- local maj tick value
    --------------------------
    tick = 1000,
    --------------------------
    -- hud label strength
    --------------------------
    label = "Force",
    --------------------------
    -- actions improve strength
    --------------------------
    fight = {value = true, add = 8},
    run = {value = false, add = 8},
    swim = {value = false, add = 8},
    climb = {value = false, add = 8},
    bike = {value = true, add = 4},
    --------------------------
    -- animations improve strength
    --------------------------
    anims = {
        {dict = "amb@world_human_push_ups@male@base", anim = "base", add = 20}, -- pushup
        {dict = "amb@world_human_sit_ups@male@base", anim = "base", add = 12}, -- abdos
        {dict = "amb@world_human_muscle_free_weights@male@barbell@base", anim = "base", add = 20}, -- barre muscu
    },
    --------------------------
    -- loose strength by tick 
    --------------------------
    minus = 0.02,
    --------------------------
    -- leveling - 5 levels
    --------------------------
    levels = {
        lvl1 = 50000,
        lvl2 = 200000,
        lvl3 = 400000,
        lvl4 = 700000,
        lvl5 = 100000,
    }
}


--------------------------
-- run
--------------------------
Options["run"] = {
    --------------------------
    -- local maj tick value
    --------------------------
    tick = 1000,
    --------------------------
    -- hud label run
    --------------------------
    label = "Course",
    --------------------------
    -- actions improve run
    --------------------------
    fight = {value = false, add = 8},
    run = {value = true, add = 20},
    swim = {value = true, add = 6},
    climb = {value = true, add = 2},
    bike = {value = true, add = 8},
    --------------------------
    -- animations improve run
    --------------------------
    anims = {
        -- {dict = "amb@world_human_push_ups@male@base", anim = "base", add = 20}, -- pushup
    },
    --------------------------
    -- loose run by tick 
    --------------------------
    minus = 0.006,
    --------------------------
    -- leveling - 5 levels
    --------------------------
    levels = {
        lvl1 = 50000,
        lvl2 = 200000,
        lvl3 = 400000,
        lvl4 = 700000,
        lvl5 = 100000,
    }
}

--------------------------
-- swim
--------------------------
Options["swim"] = {
    --------------------------
    -- local maj tick value
    --------------------------
    tick = 1000,
    --------------------------
    -- hud label run
    --------------------------
    label = "Nage",
    --------------------------
    -- actions improve run
    --------------------------
    fight = {value = false, add = 8},
    run = {value = true, add = 6},
    swim = {value = true, add = 20},
    climb = {value = true, add = 2},
    bike = {value = true, add = 4},
    --------------------------
    -- animations improve run
    --------------------------
    anims = {
        -- {dict = "amb@world_human_push_ups@male@base", anim = "base", add = 20}, -- pushup
    },
    --------------------------
    -- loose run by tick 
    --------------------------
    minus = 0.006,
    --------------------------
    -- leveling - 5 levels
    --------------------------
    levels = {
        lvl1 = 50000,
        lvl2 = 200000,
        lvl3 = 400000,
        lvl4 = 700000,
        lvl5 = 100000,
    }
}

--------------------------
-- cardio
--------------------------
Options["cardio"] = {
    --------------------------
    -- local maj tick value
    --------------------------
    tick = 1000,
    --------------------------
    -- hud label run
    --------------------------
    label = "Cardio",
    --------------------------
    -- actions improve run
    --------------------------
    fight = {value = true, add = 8},
    run = {value = true, add = 20},
    swim = {value = true, add = 20},
    climb = {value = true, add = 4},
    bike = {value = true, add = 15},
    --------------------------
    -- animations improve run
    --------------------------
    anims = {
        -- {dict = "amb@world_human_push_ups@male@base", anim = "base", add = 20}, -- pushup
    },
    --------------------------
    -- loose run by tick 
    --------------------------
    minus = 0.006,
    --------------------------
    -- leveling - 5 levels
    --------------------------
    levels = {
        lvl1 = 50000,
        lvl2 = 200000,
        lvl3 = 400000,
        lvl4 = 700000,
        lvl5 = 100000,
    }
}