if CNndDota == nil then
    _G.CNndDota = class({})-- put CNndDota in the global scope
--refer to: http://stackoverflow.com/questions/6586145/lua-require-with-global-local
end

function CNndDota:OnHeroPicked(event)
	print("Hero was picked")
    local hPlayerHero = EntIndexToHScript(event.heroindex)
    hPlayerHero:SetContextThink("self:Think_InitializePlayerHero", function() return self:Think_InitializePlayerHero(hPlayerHero) end, 0)
end

function CNndDota:Think_InitializePlayerHero( hPlayerHero )
	if not hPlayerHero then
		return 0.1
	end

	hPlayerHero:GetPlayerOwner():CheckForCourierSpawning( hPlayerHero )

	return
end

function Precache(context)

end

function Activate()
    -- When you don't have access to 'self', use 'GameRules.herodemo' instead
    -- example Function call: GameRules.herodemo:Function()
    -- example Var access: GameRules.herodemo.m_Variable = 1
    GameRules.nnddota = CNndDota()
    GameRules.nnddota:InitGameMode()
end

function CNndDota:InitGameMode()
    print("Initializing NND mode")
	local GameMode = GameRules:GetGameModeEntity()
	GameRules:GetGameModeEntity():SetFreeCourierModeEnabled(true)
	GameRules:GetGameModeEntity():SetUseDefaultDOTARuneSpawnLogic(true)
	
    ListenToGameEvent("dota_player_pick_hero", Dynamic_Wrap(CNndDota, "OnHeroPicked"), self)
end
