function gadget:GetInfo()
    return {
        name      = 'Arm Submarine and Core Submarine stockpile Controler',
        desc      = 'Limits Arm Submarine and Core Submarine stockpile to 2 and 3 torpedoes respectively at any time',
        author    = 'Doo, based on Bluestones mercury and screamer stockpile limiter',
        version   = 'v1.0',
        date      = '01/03/2017',
        license   = 'WTFPL',
        layer     = 0,
        enabled   = true
    }
end

-- SYNCED --
if (gadgetHandler:IsSyncedCode()) then
 
local armsubDefID = UnitDefNames.armsub.id
local corsubDefID = UnitDefNames.corsub.id

local pilelimitarmsub = 2
local pilelimitcorsub = 3

local CMD_STOCKPILE = CMD.STOCKPILE
local CMD_INSERT = CMD.INSERT
local SpGiveOrderToUnit = Spring.GiveOrderToUnit

function gadget:AllowCommand(UnitID, UnitDefID, teamID, cmdID, cmdParams, cmdOptions, cmdTag, synced) -- Can't use StockPileChanged because that doesn't get called when the stockpile queue changes
	if UnitID and UnitDefID == armsubDefID then
		if cmdID == CMD_STOCKPILE or (cmdID == CMD_INSERT and cmdParams[2]==CMD_STOCKPILE) then
			local pile,pileQ = Spring.GetUnitStockpile(UnitID)
			local addQ = 1
			if cmdOptions.shift then
				if cmdOptions.ctrl then
					addQ = 100
				else
					addQ = 5
				end
			elseif cmdOptions.ctrl then 
				addQ = 20
			end
			if cmdOptions.right then addQ = -addQ end

			if pile+pileQ == pilelimitarmsub and (not cmdOptions.right) then SendToUnsynced("PileLimit",teamID,pilelimitcorsub) end
			
			if pile+pileQ+addQ <= pilelimitarmsub then 
				return true
			else
				if pile+pileQ <= pilelimitarmsub then 
					local added = 0
					local needed = pilelimitarmsub - pile - pileQ
					while added < needed do
					SpGiveOrderToUnit(UnitID, CMD_STOCKPILE, {}, { "" }) -- because SetUnitStockpile can't set the queue!
					added = added + 1
					end
					return false
				else
					return false
				end		
			end
		end
	end
	if UnitID and UnitDefID == corsubDefID then
		if cmdID == CMD_STOCKPILE or (cmdID == CMD_INSERT and cmdParams[2]==CMD_STOCKPILE) then
			local pile,pileQ = Spring.GetUnitStockpile(UnitID)
			local addQ = 1
			if cmdOptions.shift then
				if cmdOptions.ctrl then
					addQ = 100
				else
					addQ = 5
				end
			elseif cmdOptions.ctrl then 
				addQ = 20
			end
			if cmdOptions.right then addQ = -addQ end

			if pile+pileQ == pilelimitcorsub and (not cmdOptions.right) then SendToUnsynced("PileLimit",teamID,pilelimitcorsub) end
			
			if pile+pileQ+addQ <= pilelimitcorsub then 
				return true
			else
				if pile+pileQ <= pilelimitcorsub then 
					local added = 0
					local needed = pilelimitcorsub - pile - pileQ
					while added < needed do
					SpGiveOrderToUnit(UnitID, CMD_STOCKPILE, {}, { "" }) -- because SetUnitStockpile can't set the queue!
					added = added + 1
					end
					return false
				else
					return false
				end		
			end
		end
	end
	return true 
end
 
-- UNSYNCED --
else

-- local SpGetSpectatingState = Spring.GetSpectatingState
-- local SpGetMyTeamID = Spring.GetMyTeamID
-- local SpEcho = Spring.Echo

-- function gadget:Initialize()
	-- gadgetHandler:AddSyncAction("PileLimit",PileLimit)
-- end

-- function PileLimit(_,teamID,pilelimit)
	-- local myTeamID = SpGetMyTeamID()
	-- if myTeamID == teamID and not SpGetSpectatingState() then
		-- SpEcho("Stockpile queue is already full (max " .. tostring(pilelimit) .. ").")
	-- end
-- end


end


