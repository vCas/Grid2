local L = Grid2Options.L

local indexValues = { 1, 2, 3, 4 }

Grid2Options:RegisterIndicatorOptions("privateauras", true, function(self, indicator)
	local options = {}
	self:MakeIndicatorTypeLevelOptions(indicator,options)
	self:MakeIndicatorLocationOptions(indicator, options)
	self:MakeIndicatorPrivateAurasCustomOptions(indicator, options)
	self:AddIndicatorOptions(indicator, nil, options)
end)

function Grid2Options:MakeIndicatorPrivateAurasCustomOptions( indicator, options )
	self:MakeHeaderOptions( options, "Appearance"  )
	options.auraIndex = {
		type = "select",
		order = 10.1,
		name = L["First Aura Index"],
		desc = L["Select the index of the first aura to display."],
		get = function ()
			return indicator.dbx.auraIndex or 1
		end,
		set = function (_, v)
			indicator.dbx.auraIndex = v
			self:RefreshIndicator(indicator, "Layout")
		end,
		values = indexValues,
	}
	options.maxIcons = {
		type = "range",
		order = 10.2,
		name = L["Max Auras"],
		desc = L["Select the maximum number of private auras to display."],
		min = 1,
		max = 6,
		step = 1,
		get = function () return indicator.dbx.maxIcons or 3 end,
		set = function (_, v)
			indicator.dbx.maxIcons= v
			self:RefreshIndicator(indicator, "Layout")
		end,
	}
	options.orientation = {
		type = "select",
		order = 11,
		name = L["Orientation"],
		desc = L["Set the icons orientation."],
		get = function () return indicator.dbx.orientation or "HORIZONTAL" end,
		set = function (_, v)
			indicator.dbx.orientation = v
			self:RefreshIndicator(indicator, "Layout")
		end,
		values={ VERTICAL = L["VERTICAL"], HORIZONTAL = L["HORIZONTAL"] }
	}
	options.iconSpacing = {
		type = "range",
		order = 12,
		name = L["Icon Spacing"],
		desc = L["Adjust the space between icons."],
		softMin = 0,
		max = 50,
		step = 1,
		get = function () return indicator.dbx.iconSpacing or 1 end,
		set = function (_, v)
			indicator.dbx.iconSpacing = v
			self:RefreshIndicator(indicator, "Layout")
		end,
	}
	options.iconSizeSource = {
		type = "select",
		order = 13,
		name = L["Icon Size"],
		desc = L["Default:\nUse the size specified by the active theme.\nPixels:\nUser defined size in pixels.\nPercent:\nUser defined size as percent of the frame height."],
		get = function (info) return (indicator.dbx.iconSize==nil and 1) or (indicator.dbx.iconSize>1 and 2) or 3 end,
		set = function (info, v)
			indicator.dbx.iconSize = (v==3 and .4) or (v==2 and 14) or nil
			self:RefreshIndicator(indicator, "Layout")
		end,
		values = { L["Default"], L["Pixels"], L["Percent"] },
	}
	options.iconSizeAbsolute = {
		type = "range",
		order = 14,
		name = L["Icon Size"],
		desc = L["Adjust the size of the icon."],
		min = 5,
		softMax = 50,
		step = 1,
		get = function ()
			return indicator.dbx.iconSize or Grid2Frame.db.profile.iconSize
		end,
		set = function (_, v)
			indicator.dbx.iconSize = v
			self:RefreshIndicator(indicator, "Layout")
		end,
		disabled = function() return indicator.dbx.iconSize==nil end,
		hidden = function()	return (indicator.dbx.iconSize or Grid2Frame.db.profile.iconSize or 0)<=1 end,
	}
	options.iconSizeRelative = {
		type = "range",
		order = 15,
		name = L["Icon Size"],
		desc = L["Adjust the size of the icon."],
		min = 0.01,
		max = 1,
		step = 0.01,
		isPercent = true,
		get = function ()
			return indicator.dbx.iconSize or Grid2Frame.db.profile.iconSize
		end,
		set = function (_, v)
			indicator.dbx.iconSize = v
			self:RefreshIndicator(indicator, "Layout")
		end,
		disabled = function() return indicator.dbx.iconSize==nil end,
		hidden = function() return (indicator.dbx.iconSize or Grid2Frame.db.profile.iconSize or 1)>1 end,
	}
	self:MakeHeaderOptions( options, "Cooldown" )
	options.disableCooldown = {
		type = "toggle",
		order = 130,
		name = L["Disable Cooldown"],
		desc = L["Disable the Cooldown Frame"],
		tristate = false,
		get = function () return indicator.dbx.disableCooldown end,
		set = function (_, v)
			indicator.dbx.disableCooldown = v or nil
			self:RefreshIndicator(indicator, "Layout")
		end,
	}
end
