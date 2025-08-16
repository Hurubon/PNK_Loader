-- Copyright (C) 2025 Hrvoje 'Hurubon' Žohar
-- See the end of the file for extended copyright information.
local LibStub = PNK_LibStub or LibStub;
local Loader  = LibStub:NewLibrary("PNK_Loader", 6);

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
			:format(type(name)));
	assert(
		type(InitFunction) == "function" or InitFunction == nil,
		("Bad argument #3 to `Register' (expected function or nil, got %q).")
			:format(type(InitFunction)));

    self.registered[name] = InitFunction or function() end;
end

function Loader:Unregister(name)
	assert(
		type(name) == "string",
		("Bad argument #2 to `Unregister' (expected string, got %q)")
			:format(type(name)));
	assert(
		self.registered[name] ~= nil,
		("Attempting to unregister unknown addon `%s'.")
			:format(name));

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
end

local listener = CreateFrame("Frame");
listener:RegisterEvent("ADDON_LOADED");
listener:SetScript("OnEvent", OnEvent);
--[[
The MIT License (MIT)
Copyright (C) 2025 Hrvoje 'Hurubon' Žohar

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
OR OTHER DEALINGS IN THE SOFTWARE.
--]]
