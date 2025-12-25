wait(6)
local plr = game.Players.LocalPlayer
local chr = plr.Character
local hmr = chr.HumanoidRootPart

local Vehicle1 = game.Workspace.Orta.CarShop["Cycle(Platform)"].Proxy
local Vehicle2 = game.Workspace.Orta.CarShop["Motorbike(Platform)"].Proxy
local Vehicle3 = game.Workspace.Orta.CarShop["Car(Platform)"].Proxy
local Vehicle4 = game.Workspace.Orta.CarShop["SmallTruck(Platform)"].Proxy
local Vehicle5 = game.Workspace.Orta.CarShop["Truck(Platform)"].Proxy
local Vehicle6 = game.Workspace.Orta.CarShop["BigTruck(Platform)"].Proxy
local Vehicle7 = game.Workspace.Orta.CarShop["Helicopter(Platform)"].Proxy

local AllVehicles = {Vehicle1,Vehicle2,Vehicle3,Vehicle4,Vehicle5,Vehicle6}



local VehicleDeb = false

local UserInputService = game:GetService("UserInputService")

local c = 0


print("hocam birşey de artık lütfen")

print(AllVehicles)
--for i , z in pairs(data.VehicleTable) do
--	return z
--end
while wait(0.1) do
	for i , v in pairs(AllVehicles) do
		local x = nil
	--	print(v.Parent.Name)
	--	while wait(0.1) do
		local aralik = (hmr.Position - v.Position).magnitude
		if aralik < 11 then
			x = 0
			v.BillboardGui.ImageButton.Visible = true
		
			v.ClickDetector.MouseClick:Connect(function()
				if aralik < 11 then
					if VehicleDeb == false then
						VehicleDeb = true
						game.ReplicatedStorage.VehicleRemotes.Cycle:FireServer(v.Fiyat.Value,v.Vehicle.Value,v,aralik,v.renderImage.Value)
						wait(0.5)
						VehicleDeb = false
					end	
				end	
			end)
			
			UserInputService.InputBegan:Connect(function(KeyPressed)          
				local KeyCodePressed = KeyPressed.KeyCode                       --
				if KeyCodePressed == Enum.KeyCode.E then 
					if aralik < 11 then
						if VehicleDeb == false then
							if x == 0 then
								x = 1
								local ara = (hmr.Position - v.Position).magnitude
								if ara < 11 then
									if VehicleDeb == false then
										VehicleDeb = true
										if c == 0 then
											c = 1
											game.ReplicatedStorage.VehicleRemotes.Cycle:FireServer(v.Fiyat.Value,v.Vehicle.Value,v,aralik,v.renderImage.Value)
											wait(1)
											c = 0
										end
										
										wait(0.3)
										VehicleDeb = false
									end	
								end	
							end	
						end	
					end	
				end
			end)
		else
			x = 1
			v.BillboardGui.ImageButton.Visible = false
		end	
	--	end
	end
end

--DİKKAT DİKKAT BU SCRİPTTE TOUCH TAP YOK


--Vehicle3.BillboardGui.ImageButton.TouchTap:Connect(function()
	
--end)



