ESX	= nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(10)
		if IsControlJustReleased(0, 29) then -- B
			local playerPed = GetPlayerPed(-1)
			if IsPedInAnyVehicle(playerPed, false) then
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				--ToggleVehicleMod(vehicle, 22, true)
				if GetPedInVehicleSeat(vehicle, -1) == playerPed then
					if ESX.Game.GetVehicleProperties(vehicle).modXenon then
						OpenVehicleHeadlightsMenu()
					else
						ESX.ShowAdvancedNotification('Véhicule', 'Phares xénon', _U('no_xenon'), 'CHAR_CARSITE', 1, false, true, 140)	
					end				
				end
			end
		end
	end
end)

function OpenVehicleHeadlightsMenu()
	local elements = {
		{label = _U('default'), value = 'default'},
		{label = _U('white'), value = 'white'},
		{label = _U('blue'), value = 'blue'},
		{label = _U('electric_blue'), value = 'electric_blue'},
		{label = _U('mint_green'), value = 'mint_green'},
		{label = _U('lime_green'), value = 'lime_green'},
		{label = _U('yellow'), value = 'yellow'},
		{label = _U('golden_shower'), value = 'golden_shower'},
		{label = _U('orange'), value = 'orange'},
		{label = _U('red'), value = 'red'},
		{label = _U('pony_pink'), value = 'pony_pink'},
		{label = _U('hot_pink'), value = 'hot_pink'},
		{label = _U('purple'), value = 'purple'},
		{label = _U('blacklight'), value = 'blacklight'},
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicleheadlights', {
		title    = _U('menu_title'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()
		
		if data.current.value == 'default' then
			headlightsColor = -1
		elseif data.current.value == 'white' then
			headlightsColor = 0
		elseif data.current.value == 'blue' then
			headlightsColor = 1
		elseif data.current.value == 'electric_blue' then
			headlightsColor = 2
		elseif data.current.value == 'mint_green' then
			headlightsColor = 3
		elseif data.current.value == 'lime_green' then
			headlightsColor = 4
		elseif data.current.value == 'yellow' then
			headlightsColor = 5
		elseif data.current.value == 'golden_shower' then
			headlightsColor = 6
		elseif data.current.value == 'orange' then
			headlightsColor = 7
		elseif data.current.value == 'red' then
			headlightsColor = 8
		elseif data.current.value == 'pony_pink' then
			headlightsColor = 9
		elseif data.current.value == 'hot_pink' then
			headlightsColor = 10
		elseif data.current.value == 'purple' then
			headlightsColor = 11
		elseif data.current.value == 'blacklight' then
			headlightsColor = 12
		end
		
		local playerPed = GetPlayerPed(-1)
		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed, false)
			SetVehicleHeadlightsColour(vehicle, headlightsColor)
			ESX.ShowAdvancedNotification('Véhicule', 'Phares xénon', _U('color_changed', data.current.label), 'CHAR_CARSITE', 1, false, true, 140)
		end		
	end, function(data, menu)
		menu.close()
	end)
end