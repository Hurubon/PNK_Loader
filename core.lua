local Loader = PNK_LibStub:NewLibrary("PNK_Loader", 1);

if Loader == nil then
    return;
end

-- A collection of registered initialization functions for each addon.
Loader.registered = {};

--[[---------------------------------------------------------------------------
	Member functions
--]]---------------------------------------------------------------------------
function Loader:Register(name, InitFunction)
    self.registered[name] = InitFunction or function() end;
end

function Loader:Unregister(name)
    self.registered[name] = nil;
end

-- TODO: UnregisterAll?

--[[---------------------------------------------------------------------------
	Event handling
--]]---------------------------------------------------------------------------
local function OnEvent(self, event, addon_name)
	if not Loader.registered[addon_name] then
		return;
	end

	Loader.registered[addon_name]();
	_G[addon_name].Print("Loaded.");
end

local listener = CreateFrame("Frame");
listener:RegisterEvent("ADDON_LOADED");
listener:SetScript("OnEvent", OnEvent);