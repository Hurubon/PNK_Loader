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
	assert(
		type(name) == "string",
		("Bad argument #2 to `Register' (expected string, got %q).")
			.format(type(name)));
	assert(
		type(InitFunction) == "function" or InitFunction == nil,
		("Bad argument #3 to `Register' (expected function or nil, got %q).")
			.format(type(InitFunction)));

    self.registered[name] = InitFunction or function() end;
end

function Loader:Unregister(name)
	assert(
		type(name) == "string",
		("Bad argument #2 to `Unregister' (expected string, got %q)")
			.format(type(name)));
	assert(
		self.registered[name] ~= nil,
		("Attempting to unregister unknown addon `%s'.")
			.format(name));

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