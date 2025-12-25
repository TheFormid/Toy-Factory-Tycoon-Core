local VehicleCycleRemote = game.ReplicatedStorage.VehicleRemotes.Cycle
local DataManager = require(game.ReplicatedStorage.DataManager)

local x = 0

VehicleCycleRemote.OnServerEvent:Connect(function(plr,Fiyat,Vehicle,v,aralik)
	print(Vehicle)
--	plr.Vehicles:FindFirstChild(Vehicle).Value = true
	local data = DataManager:Get(plr)
	
	if aralik < 11 then
	--	if v.BillboardGui.ImageButton.Visible == true then
			
			--	if data.VehicleTable:Get(v.Vehicle.Value) then
		if data.Money >= v.Fiyat.Value then
			
			plr.PlayerGui.buy.Enabled = true
			plr.PlayerGui.buy.label.TextLabel.Text = tostring("Would you like to buy this ")..tostring(Vehicle)..tostring(" for ")..tostring(Fiyat)..tostring(" coins?")
			plr.PlayerGui.buy.label.yes.MouseButton1Down:Connect(function()
				
				if x == 0 then
					x = 1
					plr.PlayerGui.buy.Enabled = false
					data.Money -= Fiyat
					local normalImage = v.BillboardGui.ImageButton.Image
					local pressedImage = v.BillboardGui.ImageButton.PressedImage
					v.BillboardGui.ImageButton.Image = v.BillboardGui.ImageButton.PressedImage
					
					local aracModule = require(game.ReplicatedStorage.Chest.Araclar)
		
					
					local gui = game.ReplicatedStorage.Chest.arac
					local guicik = gui:Clone()
					
					guicik.Arac.Value = Vehicle
					guicik.Parent = plr.PlayerGui.InventoryGui.Background.Araclar
					guicik.Equip.Visible = true
					local Stringcik = tostring(guicik.Arac.Value)..tostring("Statistics")
					local arak = aracModule[Stringcik]
					local renderImage = arak.VehicleImageId
					local studname = arak.Studs
					guicik.render.Image = renderImage
					guicik.Name = studname
					data.LastEquipVehicle = guicik.Arac.Value
					table.insert(data.VehicleTable,1,arak)
					
					if plr.Island.Value == "Island1" then
						
						local cycle = game.ReplicatedStorage.ToyFactory1.Vehicles:FindFirstChild(Vehicle):Clone()
						game.Workspace.Island1.ToyFactory1.Vehicle:ClearAllChildren()
						cycle.Parent = game.Workspace.Island1.ToyFactory1.Vehicle
						cycle.PrimaryPart.CFrame = game.Workspace.Island1.ToyFactory1.VehicleStartPoint.CFrame
						cycle.Name = "Cycle"
						
						data.LastEquipVehicle = guicik.Arac.Value
						
						
						guicik.Equip.MouseButton1Down:Connect(function()
							local cycle = game.ReplicatedStorage.ToyFactory1.Vehicles:FindFirstChild(Vehicle):Clone()
							game.Workspace.Island1.ToyFactory1.Vehicle:ClearAllChildren()
							cycle.Parent = game.Workspace.Island1.ToyFactory1.Vehicle
							cycle.PrimaryPart.CFrame = game.Workspace.Island1.ToyFactory1.VehicleStartPoint.CFrame
							cycle.Name = "Cycle"
							
							data.LastEquipVehicle = guicik.Arac.Value
						end)
						
					elseif plr.Island.Value == "Island2" then
						
						local cycle = game.ReplicatedStorage.ToyFactory2.Vehicles:FindFirstChild(Vehicle):Clone()
						game.Workspace.Island2.ToyFactory2.Vehicle:ClearAllChildren()
						cycle.Parent = game.Workspace.Island2.ToyFactory2.Vehicle
						cycle.PrimaryPart.CFrame = game.Workspace.Island2.ToyFactory2.VehicleStartPoint.CFrame
						cycle.Name = "Cycle"
						
						data.LastEquipVehicle = guicik.Arac.Value
						
						guicik.Equip.MouseButton1Down:Connect(function()
							local cycle = game.ReplicatedStorage.ToyFactory2.Vehicles:FindFirstChild(Vehicle):Clone()
							game.Workspace.Island2.ToyFactory2.Vehicle:ClearAllChildren()
							cycle.Parent = game.Workspace.Island2.ToyFactory2.Vehicle
							cycle.PrimaryPart.CFrame = game.Workspace.Island2.ToyFactory2.VehicleStartPoint.CFrame
							cycle.Name = "Cycle"
							
							data.LastEquipVehicle = guicik.Arac.Value
						end)
						
					elseif plr.Island.Value == "Island3" then
						
						data.LastEquipVehicle = guicik.Arac.Value
						
						local cycle = game.ReplicatedStorage.ToyFactory3.Vehicles:FindFirstChild(Vehicle):Clone()
						game.Workspace.Island3.ToyFactory3.Vehicle:ClearAllChildren()
						cycle.Parent = game.Workspace.Island3.ToyFactory3.Vehicle
						cycle.PrimaryPart.CFrame = game.Workspace.Island3.ToyFactory3.VehicleStartPoint.CFrame
						cycle.Name = "Cycle"
						
						guicik.Equip.MouseButton1Down:Connect(function()
							local cycle = game.ReplicatedStorage.ToyFactory3.Vehicles:FindFirstChild(Vehicle):Clone()
							game.Workspace.Island3.ToyFactory3.Vehicle:ClearAllChildren()
							cycle.Parent = game.Workspace.Island3.ToyFactory3.Vehicle
							cycle.PrimaryPart.CFrame = game.Workspace.Island3.ToyFactory3.VehicleStartPoint.CFrame
							cycle.Name = "Cycle"
							
							data.LastEquipVehicle = guicik.Arac.Value
						end)
						
					elseif plr.Island.Value == "Island4" then
						
						local cycle = game.ReplicatedStorage.ToyFactory4.Vehicles:FindFirstChild(Vehicle):Clone()
						game.Workspace.Island4.ToyFactory4.Vehicle:ClearAllChildren()
						cycle.Parent = game.Workspace.Island4.ToyFactory4.Vehicle
						cycle.PrimaryPart.CFrame = game.Workspace.Island4.ToyFactory4.VehicleStartPoint.CFrame
						cycle.Name = "Cycle"
						
						data.LastEquipVehicle = guicik.Arac.Value
						
						guicik.Equip.MouseButton1Down:Connect(function()
							local cycle = game.ReplicatedStorage.ToyFactory4.Vehicles:FindFirstChild(Vehicle):Clone()
							game.Workspace.Island4.ToyFactory4.Vehicle:ClearAllChildren()
							cycle.Parent = game.Workspace.Island4.ToyFactory4.Vehicle
							cycle.PrimaryPart.CFrame = game.Workspace.Island4.ToyFactory4.VehicleStartPoint.CFrame
							cycle.Name = "Cycle"
							
							data.LastEquipVehicle = guicik.Arac.Value
						end)
						
					end
					
					print("arabayı aldın")
					print(Vehicle)
					wait(0.4)
					v.BillboardGui.ImageButton.Image = normalImage
					wait(0.8)
					x = 0
				end
			end)
		end
			--	end
	--	end
	end
	
	
end)


--local function SatinAl()
	
--end

