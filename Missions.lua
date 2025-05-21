--- STEAMODDED HEADER
--- MOD_NAME: Missions
--- MOD_ID: MISS
--- PREFIX: miss
--- MOD_AUTHOR: [mathguy]
--- MOD_DESCRIPTION: Balatro: Missions Gamemode
--- VERSION: 1.2.1
----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas({ key = "blinds", atlas_table = "ANIMATION_ATLAS", path = "blinds.png", px = 34, py = 34, frames = 21 })

SMODS.Atlas({ key = "blinds2", atlas_table = "ANIMATION_ATLAS", path = "blinds2.png", px = 34, py = 34, frames = 21 })

SMODS.Atlas({ key = "blinds3", atlas_table = "ANIMATION_ATLAS", path = "blinds3.png", px = 34, py = 34, frames = 21 })

SMODS.Atlas({ key = "blinds4", atlas_table = "ANIMATION_ATLAS", path = "blinds4.png", px = 34, py = 34, frames = 21 })

SMODS.Atlas({ key = "blinds5", atlas_table = "ANIMATION_ATLAS", path = "blinds5.png", px = 34, py = 34, frames = 21 })

SMODS.Atlas({ key = "decks", atlas_table = "ASSET_ATLAS", path = "decks.png", px = 71, py = 95})

SMODS.Atlas({ key = "stickers", atlas_table = "ASSET_ATLAS", path = "stickers.png", px = 71, py = 95})

local adding_jokers = {
    'j_joker', 'j_wrathful_joker', 'j_lusty_joker', 'j_gluttenous_joker', 'j_greedy_joker', 'j_credit_card', 'j_diet_cola', 'j_delayed_grat', 'j_space', 'j_business',
    'j_8_ball', 'j_pareidolia', 'j_egg', 'j_mr_bones', 'j_chaos', 'j_superposition', 'j_reserved_parking', 'j_faceless', 'j_todo_list', 'j_seance',
    'j_sly', 'j_wily', 'j_clever', 'j_devious', 'j_crafty', 'j_jolly', 'j_zany', 'j_mad', 'j_crazy', 'j_droll', 
    'j_matador', 'j_gros_michel', 'j_splash', 'j_drunkard', 'j_hallucination', 'j_abstract', 'j_hanging_chad', 'j_riff_raff', 'j_ramen', 'j_popcorn'
}

miss_joker_tiers = {
    j_superposition = 2,
    j_todo_list = 2,
    j_matador = 2,
    j_riff_raff = 2,
}

jokers_with_face = {
    j_joker = true,
    j_greedy_joker = true,
    j_wrathful_joker = true,
    j_lusty_joker = true,
    j_gluttenous_joker = true,
    j_sly = true,
    j_wily = true,
    j_clever = true,
    j_devious = true,
    j_crafty = true,
    j_jolly = true,
    j_zany = true,
    j_mad = true,
    j_crazy = true,
    j_droll = true,
    j_half = true,
    j_mime = true,
    j_marble = true,
    j_misprint = true,
    j_chaos = true,
    j_steel_joker = true,
    j_scary_face = true,
    j_hack = true,
    j_pareidolia = true,
    j_even_steven = true,
    j_odd_todd = true,
    j_scholar = true,
    j_space = true,
    j_egg = true,
    j_burglar = true,
    j_blackboard = true,
    j_runner = true,
    j_blue_joker = true,
    j_sixth_sense = true,
    j_constellation = true,
    j_hiker = true,
    j_green_joker = true,
    j_card_sharp = true,
    j_madness = true,
    j_square = true,
    j_riff_raff = true,
    j_vampire = true,
    j_hologram = true,
    j_vagabond = true,
    j_baron = true,
    j_midas_mask = true,
    j_luchador = true,
    j_photograph = true,
    j_mail = true,
    j_hallucination = true,
    j_fortune_teller = true,
    j_stone = true,
    j_golden = true,
    j_lucky_cat = true,
    j_baseball = true,
    j_bull = true,
    j_trading = true,
    j_flash = true,
    j_ancient = true,
    j_selzer = true,
    j_smiley = true,
    j_mr_bones = true,
    j_sock_and_buskin = true,
    j_swashbuckler = true,
    j_smeared = true,
    j_throwback = true,
    j_glass = true,
    j_ring_master = true,
    j_blueprint = true,
    j_wee = true,
    j_merry_andy = true,
    j_idol = true,
    j_matador = true,
    j_stuntman = true,
    j_brainstorm = true,
    j_shoot_the_moon = true,
    j_drivers_license = true,
    j_cartomancer = true,
    j_astronomer = true,
    j_burnt = true,
    j_caino = true,
    j_triboulet = true,
    j_yorick = true,
    j_chicot = true,
    j_perkeo = true,
}

local mission_area = nil
local mission_desc_nodes = {}

function G.UIDEF.missions(from_game_over)

    G.PROFILES[G.SETTINGS.profile].selected_mission = G.PROFILES[G.SETTINGS.profile].selected_mission or 1
    local a = {localize('m_covert_chasm'), localize('m_fading_fog'), localize('m_viral_valley')}
    local b = {'m_covert_chasm', 'm_fading_fog', 'm_viral_valley'}
    miss_selected_text = {a[G.PROFILES[G.SETTINGS.profile].selected_mission]}

    local area = CardArea(
        G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
        (5.25)*G.CARD_W,
        1*G.CARD_H, 
    {card_limit = 5, type = 'title_2', highlight_limit = 1})

    if not G.PROFILES[G.SETTINGS.profile].mission_jokers then
        G.PROFILES[G.SETTINGS.profile].mission_jokers = {}
    end

    for i = 1, #G.PROFILES[G.SETTINGS.profile].mission_jokers do
        local card = Card(0,0, 0.7*G.CARD_W, 0.7*G.CARD_H, nil, G.P_CENTERS[G.PROFILES[G.SETTINGS.profile].mission_jokers[i]])
        area:emplace(card)
    end

    mission_area = area

    for i, j in pairs(mission_desc_nodes) do
        mission_desc_nodes[i] = nil
    end
    for i, j in ipairs(localize{type = 'raw_descriptions', key = b[G.PROFILES[G.SETTINGS.profile].selected_mission], set = "Missions"}) do
        table.insert(mission_desc_nodes, j)
    end

    local t = {n=G.UIT.ROOT, config={align = "cm", padding = 0.1, colour = G.C.CLEAR, minh = 8, minw = 7}, nodes={
            {n=G.UIT.R, config={align = "cm", colour = G.C.CLEAR}, nodes = {
                {n=G.UIT.R, config={align = "cm", padding = 0.3, colour = G.C.BLACK, r = 0.1}, nodes={
                    {n=G.UIT.T, config={ref_table = miss_selected_text, ref_value = 1, scale = 0.75, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                }},
                {n=G.UIT.R, config={align = "cm", padding = 0.3}, nodes={
                    {n=G.UIT.O, config={object = DynaText({string = 'Joker Party', colours = {G.C.UI.TEXT_LIGHT}, bump = true, scale = 0.6})}}
                }},
                {n=G.UIT.R, config={align = "cm",  colour = G.C.CLEAR, padding = 0.1}, nodes={
                    {n=G.UIT.C, config={align = "cm", padding = 0, minh = 0.8, minw = 0.4 + (5.25)*G.CARD_W}, nodes = {{n=G.UIT.O, config={object = area}}}},
                }},
                {n=G.UIT.R, config={align = "cm", colour = G.C.CLEAR, padding = 0.1}, nodes={
                    UIBox_button({col = true,label = {localize('b_add_joker')}, button = 'add_joker_ui', func = 'can_add_joker_ui',minw = 3, scale = 0.4, minh = 0.6, ref_table = {from_game_over}}),
                    UIBox_button({col = true,label = {localize('b_remove_joker')}, button = 'remove_joker', func = 'can_remove_joker', minw = 3, scale = 0.4, minh = 0.6}),
                }},
                {n=G.UIT.R, config={align = "cm", colour = G.C.CLEAR, padding = 0.1}, nodes={
                    UIBox_button({label = {localize('b_play_cap')}, button = 'start_setup_mission', minw = 3, scale = 0.6, minh = 0.8, colour = G.C.BLUE}),
                }},
                create_option_cycle({options = a, scale = 0.6, w = 4, opt_callback = 'mission_stake_page', focus_args = {snap_to = true, nav = 'wide'}, current_option = G.PROFILES[G.SETTINGS.profile].selected_mission, colour = G.C.RED, on_demand_tooltip = {text = mission_desc_nodes}})
        }}}
    }
    return t
end

function add_to_joker_party_cell(key, id, do_add_jokers, from_game_over)
    local area = CardArea(
        G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
        G.CARD_W,
        G.CARD_H, 
    {card_limit = 1, type = 'title_2'})
    local card = nil
    if key then
        card = Card(0,0, 0.7*G.CARD_W, 0.7*G.CARD_H, nil, G.P_CENTERS[key])
        if not G.PROFILES[G.SETTINGS.profile].ready_mission_jokers or not G.PROFILES[G.SETTINGS.profile].ready_mission_jokers[key] then
            card.ability.grayscaled = true
        end
        area:emplace(card)
    end
    local t = {n=G.UIT.C, config={id = id, align = "cm", colour = G.C.CLEAR, padding = 0.1, r = 0.08}, nodes = {
        {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.05, align = "bm", minw = 0.5 + G.CARD_W, minh = 0.8, colour = G.C.BLACK, func = 'can_add_joker_back'}, nodes={
            {n=G.UIT.C, config={align = "cm", padding = 0.05, minh = 0.8, minw = 0.4 + G.CARD_W}, nodes = {{n=G.UIT.O, config={object = area}}}},
        }},
        not do_add_jokers and {n=G.UIT.R, config={ref_table = {card, from_game_over}, r = 0.08, padding = 0.05, align = "bm", minw = 0.85, minh = 0.45, hover = true, shadow = true, colour = G.C.RED, one_press = true, button = 'add_joker', func = 'can_add_joker'}, nodes={
            {n=G.UIT.T, config={text = localize('b_add_joker'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
        }} or nil,
    }}
    return t
end

function create_UI_adding_jokers(from_game_over, do_add_jokers)
    local cards = {}
    for i = 1, 10 do
        table.insert(cards, adding_jokers[i])
    end
    local pages = math.ceil(#adding_jokers / 10)
    local options = {}
    for i = 1, pages do
        table.insert(options, localize('k_page') .. " " .. tostring(i) .. "/" .. tostring(pages))
    end
    local t = {n=G.UIT.R, config={align = "cm", colour = G.C.CLEAR, padding = 0.1}, nodes = {
        {n=G.UIT.R, config={align = "cm", colour = G.C.CLEAR, padding = 0.1}, nodes={
            add_to_joker_party_cell(cards[1], 'miss_cell_1', do_add_jokers, from_game_over),
            add_to_joker_party_cell(cards[2], 'miss_cell_2', do_add_jokers, from_game_over),
            add_to_joker_party_cell(cards[3], 'miss_cell_3', do_add_jokers, from_game_over),
            add_to_joker_party_cell(cards[4], 'miss_cell_4', do_add_jokers, from_game_over),
            add_to_joker_party_cell(cards[5], 'miss_cell_5', do_add_jokers, from_game_over),
        }},
        {n=G.UIT.R, config={align = "cm", colour = G.C.CLEAR, padding = 0.1}, nodes={
            add_to_joker_party_cell(cards[6], 'miss_cell_6', do_add_jokers, from_game_over),
            add_to_joker_party_cell(cards[7], 'miss_cell_7', do_add_jokers, from_game_over),
            add_to_joker_party_cell(cards[8], 'miss_cell_8', do_add_jokers, from_game_over),
            add_to_joker_party_cell(cards[9], 'miss_cell_9', do_add_jokers, from_game_over),
            add_to_joker_party_cell(cards[10], 'miss_cell_0', do_add_jokers, from_game_over),
        }},
        create_option_cycle({options = options, w = 5, opt_callback = 'adding_jokers_page', focus_args = {snap_to = true, nav = 'wide'}, current_option = 1, colour = G.C.RED, no_pips = true})
    }}
    return create_UIBox_generic_options({back_func = not do_add_jokers and (from_game_over and 'setup_run_game_over' or 'setup_run') or nil, contents = {t}})
end

function create_UIBox_notify_alert_party_joker(key)
    local _c, _atlas = G.P_CENTERS[key], G.ASSET_ATLAS[G.P_CENTERS[key].atlas] or G.ASSET_ATLAS["Joker"]

    local t_s = Sprite(0,0,1.5*(_atlas.px/_atlas.py),1.5,_atlas, _c and _c.pos or {x=3, y=0})
    t_s.states.drag.can = false
    t_s.states.hover.can = false
    t_s.states.collide.can = false
   
    local subtext = localize('k_joker')
  
    local t = {n=G.UIT.ROOT, config = {align = 'cl', r = 0.1, padding = 0.06, colour = G.C.UI.TRANSPARENT_DARK}, nodes={
        {n=G.UIT.R, config={align = "cl", padding = 0.2, minw = 20, r = 0.1, colour = G.C.BLACK, outline = 1.5, outline_colour = G.C.GREY}, nodes={
            {n=G.UIT.R, config={align = "cm", r = 0.1}, nodes={
                {n=G.UIT.R, config={align = "cm", r = 0.1}, nodes={
                    {n=G.UIT.O, config={object = t_s}},
                }},
                {n=G.UIT.R, config={align = "cm", padding = 0.04}, nodes={
                    {n=G.UIT.R, config={align = "cm", maxw = 3.4}, nodes={
                        {n=G.UIT.T, config={text = subtext, scale = 0.5, colour = G.C.PURPLE, shadow = true}},
                    }},
                    {n=G.UIT.R, config={align = "cm", maxw = 3.4}, nodes={
                        {n=G.UIT.T, config={text = localize('k_available_ex'), scale = 0.35, colour = G.C.PURPLE, shadow = true}},
                    }}
                }}
            }}
        }}
    }}
    return t
end

function notify_alert_party_joker(key)
    G.E_MANAGER:add_event(Event({
      no_delete = true,
      pause_force = true,
      timer = 'UPTIME',
      func = function()
        if G.achievement_notification then
            G.achievement_notification:remove()
            G.achievement_notification = nil
        end
        G.achievement_notification = G.achievement_notification or UIBox{
            definition = create_UIBox_notify_alert_party_joker(key),
            config = {align='cr', offset = {x=20,y=0},major = G.ROOM_ATTACH, bond = 'Weak'}
        }
        return true
      end
    }), 'achievement')
    G.E_MANAGER:add_event(Event({
        no_delete = true,
        trigger = 'after',
        pause_force = true,
        timer = 'UPTIME',
        delay = 0.1,
        func = function()
            G.achievement_notification.alignment.offset.x = G.ROOM.T.x - G.achievement_notification.UIRoot.children[1].children[1].T.w - 0.8
          return true
        end
    }), 'achievement')
    G.E_MANAGER:add_event(Event({
        no_delete = true,
        pause_force = true,
        trigger = 'after',
        timer = 'UPTIME',
        delay = 0.1,
        func = function()
            play_sound('highlight1', nil, 0.5)
            play_sound('foil2', 0.5, 0.4)
          return true
        end
    }), 'achievement')
    G.E_MANAGER:add_event(Event({
      no_delete = true,
      pause_force = true,
      trigger = 'after',
      delay = 3,
      timer = 'UPTIME',
      func = function()
        G.achievement_notification.alignment.offset.x = 20
        return true
      end
    }), 'achievement')
    G.E_MANAGER:add_event(Event({
        no_delete = true,
        pause_force = true,
        trigger = 'after',
        delay = 0.5,
        timer = 'UPTIME',
        func = function()
            if G.achievement_notification then
                G.achievement_notification:remove()
                G.achievement_notification = nil
            end
          return true
        end
    }), 'achievement')
end

function unlock_party_joker(key)
    if not G.GAME or not G.GAME.modifiers or not G.GAME.modifiers.mission or (G.GAME.modifiers.mission < (miss_joker_tiers[key] or 1)) then
        return
    end
    if not G.PROFILES[G.SETTINGS.profile].ready_mission_jokers then
        G.PROFILES[G.SETTINGS.profile].ready_mission_jokers = {}
    end
    if not G.PROFILES[G.SETTINGS.profile].ready_mission_jokers[key] then
        G.PROFILES[G.SETTINGS.profile].ready_mission_jokers[key] = true
        notify_alert_party_joker(key)
    end
end

G.FUNCS.can_add_joker_ui = function(e)
    if (#G.PROFILES[G.SETTINGS.profile].mission_jokers >= 5) then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        e.config.colour = G.C.GREEN
        e.config.button = 'add_joker_ui'
    end
end

G.FUNCS.add_joker_ui = function(e)
    G.FUNCS.overlay_menu{
        definition = create_UI_adding_jokers(e.config.ref_table and e.config.ref_table[1], (e.config.id == 'no_adding_jokers')),
    }
end

G.FUNCS.can_add_joker = function(e)
    if not G.PROFILES[G.SETTINGS.profile].mission_jokers then
        G.PROFILES[G.SETTINGS.profile].mission_jokers = {}
    end
    local valid = true
    for i = 1, #G.PROFILES[G.SETTINGS.profile].mission_jokers do
        if e.config.ref_table[1] and (G.PROFILES[G.SETTINGS.profile].mission_jokers[i] == e.config.ref_table[1].config.center.key) then
            valid = false
        end
    end
    if not e.config.ref_table[1] or not valid or not G.PROFILES[G.SETTINGS.profile].ready_mission_jokers or not G.PROFILES[G.SETTINGS.profile].ready_mission_jokers[e.config.ref_table[1].config.center.key] or (#G.PROFILES[G.SETTINGS.profile].mission_jokers >= 5) then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        e.config.colour = G.C.RED
        e.config.button = 'add_joker'
    end
end

G.FUNCS.can_add_joker_back = function(e)
    if not G.PROFILES[G.SETTINGS.profile].mission_jokers then
        G.PROFILES[G.SETTINGS.profile].mission_jokers = {}
    end
    if not e.config.ref_table or not G.PROFILES[G.SETTINGS.profile].ready_mission_jokers or not G.PROFILES[G.SETTINGS.profile].ready_mission_jokers[e.config.ref_table.config.center.key] then
        if e.config.ref_table and G.localization.descriptions.LockedJoker[e.config.ref_table.config.center.key] then
            e.config.colour = G.C.BLACK
        else
            e.config.colour = G.C.RED
        end
    else
        e.config.colour = G.C.GREEN
    end
end

G.FUNCS.add_joker = function(e)
    if not G.PROFILES[G.SETTINGS.profile].mission_jokers then
        G.PROFILES[G.SETTINGS.profile].mission_jokers = {}
    end
    table.insert(G.PROFILES[G.SETTINGS.profile].mission_jokers, e.config.ref_table[1].config.center.key)
    G.FUNCS.overlay_menu{
        definition = G.UIDEF.run_setup(e.config.ref_table[2]),
    }
    local tab_but = G.OVERLAY_MENU:get_UIE_by_ID("tab_but_" .. localize('b_missions'))
    G.FUNCS.change_tab(tab_but)
    G:save_progress()
end

G.FUNCS.can_remove_joker = function(e)
    if (#G.PROFILES[G.SETTINGS.profile].mission_jokers == 0) then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        e.config.colour = G.C.RED
        e.config.button = 'remove_joker'
    end
end

G.FUNCS.remove_joker = function(e)
    local key = mission_area.cards[1].config.center.key
    for i = 1, #G.PROFILES[G.SETTINGS.profile].mission_jokers do
        if G.PROFILES[G.SETTINGS.profile].mission_jokers[i] == key then
            table.remove(G.PROFILES[G.SETTINGS.profile].mission_jokers, i)
            break
        end
    end
    local tab_but = G.OVERLAY_MENU:get_UIE_by_ID("tab_but_" .. localize('b_missions'))
    G.FUNCS.change_tab(tab_but)
    G:save_progress()
end

G.FUNCS.mission_stake_page = function(args)
    if not args or not args.cycle_config then return end
    G.PROFILES[G.SETTINGS.profile].selected_mission = args.cycle_config.current_option
    local a = {localize('m_covert_chasm'), localize('m_fading_fog'), localize('m_viral_valley')}
    local b = {'m_covert_chasm', 'm_fading_fog', 'm_viral_valley'}
    for i, j in pairs(mission_desc_nodes) do
        mission_desc_nodes[i] = nil
    end
    for i, j in ipairs(localize{type = 'raw_descriptions', key = b[G.PROFILES[G.SETTINGS.profile].selected_mission], set = "Missions"}) do
        table.insert(mission_desc_nodes, j)
    end
    miss_selected_text[1] = a[G.PROFILES[G.SETTINGS.profile].selected_mission]
    G.OVERLAY_MENU:recalculate()
    G:save_progress()
end

G.FUNCS.adding_jokers_page = function(args)
    if not args or not args.cycle_config then return end
    for i = 0, 9 do
        local joker_ui = G.OVERLAY_MENU:get_UIE_by_ID("miss_cell_" .. tostring(i))
        local area = joker_ui.children[1].children[1].children[1].config.object
        if joker_ui.children[2] then
            joker_ui.children[2].config.ref_table = {nil , joker_ui.children[2].config.ref_table[2]}
        end
        joker_ui.children[1].config.ref_table = nil
        local j = (i == 0) and 10 or i
        local key = adding_jokers[(args.cycle_config.current_option - 1) * 10 + j]
        if area.cards[1] then
            area.cards[1]:remove()
        end
        if key then
            local card = Card(area.T.x, area.T.y, 0.7*G.CARD_W, 0.7*G.CARD_H, nil, G.P_CENTERS[key])
            if not G.PROFILES[G.SETTINGS.profile].ready_mission_jokers or not G.PROFILES[G.SETTINGS.profile].ready_mission_jokers[key] then
                card.ability.grayscaled = true
            end
            area:emplace(card)
            if joker_ui.children[2] then
                joker_ui.children[2].config.ref_table = {card , joker_ui.children[2].config.ref_table[2]}
            end
            joker_ui.children[1].config.ref_table = card
        end
    end
end

G.FUNCS.start_setup_mission = function(e)  
    G.FUNCS.start_run(e, {stake = G.P_STAKES['stake_white'].order, challenge = {
        deck = {
            type = 'Mission Deck',
        },
        rules = {
            custom = {
                {id = 'mission', mission_id = G.PROFILES[G.SETTINGS.profile].selected_mission},
            }
        },
    }})
end

G.FUNCS.setup_run_game_over = function(e)
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu{
      definition = G.UIDEF.run_setup(true),
    }
    G.OVERLAY_MENU.config.no_esc = true
end

SMODS.Blind {
    loc_txt = {
        name = 'Scorched Acorn',
        text = { 'Sorting is disabled,', 'Face Down Champion' }
    },
    key = 'scorched_acorn',
    name = "Scorched Acorn",
    config = {},
    boss = {min = 1, max = 10, showdown = true}, 
    showdown = true,
    boss_colour = HEX("fd6a00"),
    vars = {},
    dollars = 8,
    mult = 3,
    atlas = "blinds",
    pos = {x = 0, y = 0},
    set_blind = function(self, reset, silent)
        if not reset then
            G.GAME.blind.disable_sort = true
            local pool = {}
            for i = 1, #G.playing_cards do
                table.insert(pool, G.playing_cards[i])
            end
            pseudoshuffle(pool, pseudoseed('scorch'))
            for i = 1, #pool do
                pool[i].ability.miss_index = i
            end
        end
    end,
    defeat = function(self, reset, silent)
        G.GAME.blind.disable_sort = nil
    end,
    disable = function(self, reset, silent)
        G.GAME.blind.disable_sort = nil
    end,
    in_pool = function(self)
        return (G.GAME.modifiers.mission == 1)
    end,
}

SMODS.Blind {
    loc_txt = {
        name = 'Ebony Eraser',
        text = { 'All Joker and Consumable', 'Timers go to 1 round' }
    },
    key = 'final_eraser',
    name = "Ebony Eraser",
    config = {},
    boss = {min = 1, max = 10, showdown = true}, 
    showdown = true,
    boss_colour = HEX("555d50"),
    vars = {},
    dollars = 8,
    mult = 2,
    atlas = "blinds2",
    pos = {x = 0, y = 0},
    set_blind = function(self, reset, silent)
        if not reset then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.death_timer then
                    G.jokers.cards[i].ability.old_death_timer = G.jokers.cards[i].ability.death_timer
                    G.jokers.cards[i].ability.death_timer = 1
                end
            end
            for i = 1, #G.consumeables.cards do
                if G.consumeables.cards[i].ability.death_timer then
                    G.consumeables.cards[i].ability.old_death_timer = G.consumeables.cards[i].ability.death_timer
                    G.consumeables.cards[i].ability.death_timer = 1
                end
            end
        end
    end,
    disable = function(self, reset, silent)
        for i = 1, #G.jokers.cards do
            G.jokers.cards[i].ability.death_timer = G.jokers.cards[i].ability.old_death_timer
        end
        for i = 1, #G.consumeables.cards do
            G.jokers.cards[i].ability.death_timer = G.jokers.cards[i].ability.old_death_timer
        end
    end,
    in_pool = function(self)
        return (G.GAME.modifiers.mission == 2)
    end,
}

SMODS.Blind {
    loc_txt = {
        name = 'Existential Eraser',
        text = { 'Joker and Consumable', 'Timers are per hand' }
    },
    key = 'existential_eraser',
    name = "Existential Eraser",
    config = {},
    boss = {min = 1, max = 10, showdown = true}, 
    showdown = true,
    boss_colour = HEX("2e5f10"),
    vars = {},
    dollars = 8,
    mult = 3,
    atlas = "blinds3",
    pos = {x = 0, y = 0},
    in_pool = function(self)
        return (G.GAME.modifiers.mission == 2)
    end,
}

SMODS.Blind {
    loc_txt = {
        name = 'Periwinkle Pathogen',
        text = { 'Create a Negative Eternal', 'Infected Joker' }
    },
    key = 'final_pathogen',
    name = "Periwinkle Pathogen",
    config = {},
    boss = {min = 1, max = 10, showdown = true}, 
    showdown = true,
    boss_colour = HEX("ccccff"),
    vars = {},
    dollars = 8,
    mult = 2,
    atlas = "blinds4",
    pos = {x = 0, y = 0},
    in_pool = function(self)
        return (G.GAME.modifiers.mission == 3)
    end,
    set_blind = function(self, reset, silent)
        if not reset then
            local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_joker', 'peri')
            card:add_to_deck()
            G.jokers:emplace(card)
            card:set_eternal(true)
            card:set_edition({negative = true})
            card.ability.miss_infected = true
            card.ability.periwinkle_pathogen = true
        end
    end,
    disable = function(self, reset, silent)
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.periwinkle_pathogen then
                G.jokers.cards[i]:start_dissolve()
            end
        end
    end,
    defeat = function(self, reset, silent)
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.periwinkle_pathogen then
                G.jokers.cards[i].ability.periwinkle_pathogen = nil
            end
        end
    end,
}

SMODS.Blind {
    loc_txt = {
        name = 'Corrupt Pathogen',
        text = { 'All Jokers are', 'Infected this round' }
    },
    key = 'corrupt_pathogen',
    name = "Corrupt Pathogen",
    config = {},
    boss = {min = 1, max = 10, showdown = true}, 
    showdown = true,
    boss_colour = HEX("5e5eff"),
    vars = {},
    dollars = 8,
    mult = 3,
    atlas = "blinds5",
    pos = {x = 0, y = 0},
    in_pool = function(self)
        return (G.GAME.modifiers.mission == 3)
    end,
    set_blind = function(self, reset, silent)
        if not reset then
            for i = 1, #G.jokers.cards do
                if not G.jokers.cards[i].ability.miss_infected then
                    G.jokers.cards[i].ability.corrupt_pathogen = true
                    G.jokers.cards[i]:juice_up()
                    G.jokers.cards[i].ability.miss_infected = true
                end
            end
        end
    end,
    disable = function(self, reset, silent)
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.corrupt_pathogen then
                G.jokers.cards[i].ability.corrupt_pathogen = nil
                G.jokers.cards[i].ability.miss_infected = nil
            end
        end
    end,
    defeat = function(self, reset, silent)
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.corrupt_pathogen then
                G.jokers.cards[i].ability.corrupt_pathogen = nil
                G.jokers.cards[i]:juice_up()
                G.jokers.cards[i].ability.miss_infected = nil
            end
        end
    end,
}

SMODS.Sticker {
    key = 'obscured',
    rate = 0,
    pos = { x = 10, y = 0 },
    colour = HEX '97F1EF',
    badge_colour = HEX '97F1EF',
    should_apply = function(self, card, center, area)
        if G.GAME.modifiers.mission ~= 1 then
            return
        end
        local odds = 0
        if (G.GAME.round_resets.ante >= 4) then
            odds = 0.1 + 0.085 * (G.GAME.round_resets.ante - 3)
        end
        if (pseudorandom('badges') > odds) then
            return
        end
        return ((area == G.shop_jokers) or (area == G.pack_cards))
    end,
    loc_txt = {
        name = "",
        text = {
            "",
        },
        label = ""
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {}}
    end,
}

SMODS.Sticker {
    key = 'defended',
    rate = 0,
    pos = { x = 0, y = 0 },
    atlas = "stickers",
    colour = HEX '5999c7',
    badge_colour = HEX '5999c7',
    should_apply = function(self, card, center, area)
        return false
    end,
    loc_txt = {
        name = "Defended",
        text = {
            "{C:attention}Immune{} to {C:green}The{}",
            "{C:green}Fading Fog{}"
        },
        label = "Defended"
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {}}
    end,
}

SMODS.Sticker {
    key = 'infected',
    rate = 0,
    pos = { x = 1, y = 0 },
    atlas = "stickers",
    colour = HEX '67c759',
    badge_colour = HEX '67c759',
    should_apply = function(self, card, center, area)
        return false
    end,
    loc_txt = {
        name = "Infected",
        text = {
            "May change {C:attention}rank{} or {C:attention}suit{},",
            "{C:attention}unplay{}, or {C:red}fail{} to trigger",
            "if {C:attention}Joker{}. {C:green}Infected{} may",
            "{C:green}spread{} to nearby cards"
        },
        label = "Infected"
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {}}
    end,
}

SMODS.Shader {
    key = 'grayscale',
    path = 'grayscale.fs'
}

SMODS.Back {
    key = 'mission',
    name = "Mission Deck",
    pos = { x = 0, y = 0 },
    atlas = 'decks',
    omit = true,
    apply = function(self)
	    G.E_MANAGER:add_event(Event({func = function()
            if G.GAME.modifiers.mission == 3 then
                local pool = {}
                for i = 1, #G.playing_cards do
                    table.insert(pool, G.playing_cards[i])
                end
                pseudoshuffle(pool, pseudoseed('mission'))
                for i = 1, 3 do
                    pool[i].ability.miss_infected = true
                end
            end
    	return true end }))
    end
}

local old_boss = get_new_boss
function get_new_boss()
    if (G.GAME.modifiers.mission == 1) and (G.GAME.round_resets.ante % 8 == 4) then
        G.GAME.bosses_used['bl_final_acorn'] = G.GAME.bosses_used['bl_final_acorn'] + 1
        return 'bl_final_acorn'
    elseif (G.GAME.modifiers.mission == 1) and (G.GAME.round_resets.ante > 0) and (G.GAME.round_resets.ante % 8 == 0) then
        G.GAME.bosses_used['bl_miss_scorched_acorn'] = G.GAME.bosses_used['bl_miss_scorched_acorn'] + 1
        return 'bl_miss_scorched_acorn'
    elseif (G.GAME.modifiers.mission == 2) and (G.GAME.round_resets.ante % 8 == 4) then
        G.GAME.bosses_used['bl_miss_final_eraser'] = G.GAME.bosses_used['bl_miss_final_eraser'] + 1
        return 'bl_miss_final_eraser'
    elseif (G.GAME.modifiers.mission == 2) and (G.GAME.round_resets.ante > 0) and (G.GAME.round_resets.ante % 8 == 0) then
        G.GAME.bosses_used['bl_miss_existential_eraser'] = G.GAME.bosses_used['bl_miss_existential_eraser'] + 1
        return 'bl_miss_existential_eraser'
    elseif (G.GAME.modifiers.mission == 3) and (G.GAME.round_resets.ante % 8 == 4) then
        G.GAME.bosses_used['bl_miss_final_pathogen'] = G.GAME.bosses_used['bl_miss_final_pathogen'] + 1
        return 'bl_miss_final_pathogen'
    elseif (G.GAME.modifiers.mission == 3) and (G.GAME.round_resets.ante % 8 == 0) then
        G.GAME.bosses_used['bl_miss_corrupt_pathogen'] = G.GAME.bosses_used['bl_miss_corrupt_pathogen'] + 1
        return 'bl_miss_corrupt_pathogen'
    end
    return old_boss()
end

local old_seal = SMODS.DrawSteps['seal'].func
SMODS.DrawSteps['seal'].func = function(self, layer)
    old_seal(self, layer)
    if self.ability and self.ability.grayscaled then
        self.children.center:draw_shader('miss_grayscale', nil, self.ARGS.send_to_shader)
    end
end

local old_score = SMODS.score_card
function SMODS.score_card(card, context)
    old_score(card, context)
    if (card:get_id() == 8) and (card.seal == 'Purple') and card.edition and (card.edition.polychrome) and (card.ability.name == "Wild Card") and (card.base.suit == "Spades") then
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                unlock_party_joker('j_8_ball')
                return true
            end
        }))
    end
end

----------------------------------------------
------------MOD CODE END----------------------
