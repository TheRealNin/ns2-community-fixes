
local takenInfantryPortalPoints = debug.getupvaluex(MarineTeam.ResetTeam, "takenInfantryPortalPoints")

local oldOnInitialized = MarineTeam.OnInitialized
function MarineTeam:OnInitialized()
	self.spawnedPortals = 0
	oldOnInitialized(self)
end

local oldResetTeam = MarineTeam.ResetTeam
function MarineTeam:ResetTeam()
	self.spawnedPortals = 0
	return oldResetTeam(self)
end

-- mostly copied from vanilla
-- TODO: Get func from vanilla instead
local function SpawnInfantryPortal(self, techPoint)

    local techPointOrigin = techPoint:GetOrigin() + Vector(0, 2, 0)
    
    local spawnPoint
    
    -- First check the predefined spawn points. Look for a close one.
    for p = 1, #Server.infantryPortalSpawnPoints do
		
		if not takenInfantryPortalPoints[p] then 
			local predefinedSpawnPoint = Server.infantryPortalSpawnPoints[p]
			if (predefinedSpawnPoint - techPointOrigin):GetLength() <= kInfantryPortalAttachRange then
				spawnPoint = predefinedSpawnPoint
				takenInfantryPortalPoints[p] = true
				break
			end
		end
        
    end
    
    if not spawnPoint then
		
        spawnPoint = GetRandomBuildPosition( kTechId.InfantryPortal, techPointOrigin, kInfantryPortalAttachRange )
        spawnPoint = spawnPoint and spawnPoint - Vector( 0, 0.6, 0 )
		
    end
    
    if spawnPoint then
    
        local ip = CreateEntity(InfantryPortal.kMapName, spawnPoint, self:GetTeamNumber())
        
        SetRandomOrientation(ip)
        ip:SetConstructionComplete()
        self.spawnedPortals = self.spawnedPortals + 1
		--Log("Spawning portal %s", self.spawnedPortals)
		
    end
    
end

local oldUpdate = MarineTeam.Update
function MarineTeam:Update(timePassed)

    oldUpdate(self, timePassed)
	
	local gameLength = Shared.GetTime() - GetGamerules():GetGameStartTime()
	if self.startTechPoint and self.spawnedPortals == 1 and
		gameLength < kMaxTimeBeforeReset and self:GetNumPlayers() > 8 then
		
		-- this will increment self.spawnedPortals
		SpawnInfantryPortal(self, self.startTechPoint)
		
		if GetGamerules():GetGameStarted() then
			Shared.Message("Spawning an extra infantry portal for marines due to a 9th player joining.")
		end
		
	end
    
end


debug.setupvaluex(MarineTeam.SpawnInitialStructures, "SpawnInfantryPortal", SpawnInfantryPortal, true)
