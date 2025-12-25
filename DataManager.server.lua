local spawnpoint1 = game.Workspace.sahip1
local spawnpoint2 = game.Workspace.sahip2
local spawnpoint3 = game.Workspace.sahip3
local spawnpoint4 = game.Workspace.sahip4

local DataManager = require(game.ReplicatedStorage.DataManager)

game.Players.PlayerAdded:Connect(function(plr)
	wait(3)
	local oyuncular = game.ReplicatedStorage.Sahip
	
	
	
	if oyuncular.Sahip1.Value == false then
		
		
		
		oyuncular.Sahip1.Value = true
		oyuncular.TycoonSahibi1.Value = plr.Name
		print(oyuncular.TycoonSahibi1.Value)
		local Island = Instance.new("StringValue",plr)
		Island.Name = "Island"
		Island.Value = "Island1"
		
		local Tft = game.Workspace.Island1.ToyFactory1
		
		local a = game.Workspace:WaitForChild(plr.Name)
		if a then
			a.HumanoidRootPart.CFrame = spawnpoint1.CFrame
			wait(15)
		
			local x = 0
			while wait(0.1) do
				local Data = DataManager:Get(plr)
				if x == 0 then
					print("yani kanka benlik birşey yok")
					if Data then
						x = 1
						print("oldunmu hocam")
						local b = Tft.CollectMoney
						b.Para.Value = Data.CollectMoney
						print(Data.CollectMoney)
						for i , v in pairs(Data.Tycoon) do
							--	local c = tostring("Şekillendirici")..tostring(i)..tostring("-5")
							print(Data.Tycoon)
							local button = Tft.Buttons:FindFirstChild(v)
							button.SatinAlindimi.Value = true
							button.Transparency = 1
							button.BillboardGui.Enabled = false
							print(button.Name)
							local ihtiyac1 = game.ReplicatedStorage.ToyFactory1.SatinAlincaklar:FindFirstChild(button.AlincakEsya.Value)
							print(ihtiyac1.Name)
							local ihtiyac = ihtiyac1:Clone()
							
							ihtiyac.Name = ihtiyac1.Name
							ihtiyac.Parent = Tft.SatinAlindi
							for sira , partcikcuk in pairs(ihtiyac:GetDescendants()) do
								if partcikcuk:IsA("Script") then
									partcikcuk.Disabled = false
								end
							end
						end
						for i , v in pairs(Tft.Buttons:GetChildren()) do
							if v.SatinAlindimi.Value == false then
								
								local onceki = Tft.Buttons:FindFirstChild(v.OncekiButon.Value)
								if onceki then
									if onceki:FindFirstChild("SatinAlindimi") then
										if onceki.SatinAlindimi.Value == true then
											v.BillboardGui.Enabled = true
											v.Transparency = 0
										end
									else
										onceki.Transparency = 0
									end	
								end	
							end	
						end					
						for siracik , valuecikcik in pairs(Data.CeviriciToys) do
							local c = tostring("Şekillendirici")..tostring(siracik)..tostring("-5")
							local SekilMakinasi = Tft.SatinAlindi:FindFirstChild(c)
							SekilMakinasi.Cevirici.Value.Value = valuecikcik
						end
						for storeSira, Store in pairs(Data.SellFolderStorage) do
							local Coin = Data.SellFolderCoins[storeSira]
							local Storage = Instance.new("IntValue",Tft.Sell.Stores)
							Storage.Name = "Store"
							Storage.Value = Store
							
							local Para = Instance.new("IntValue",Storage)
							Para.Name = "Para"
							Para.Value = Coin
						end
					end	
				end	
			end	
		end
		
		game.Players.PlayerRemoving:Connect(function(player)
			if player.Name == plr.Name then
				oyuncular.Sahip1.Value = false
				oyuncular.TycoonSahibi1.Value = ""
			end	
		end)
		
		
		
	elseif oyuncular.Sahip2.Value == false then
		
		
		oyuncular.Sahip2.Value = true
		oyuncular.TycoonSahibi2.Value = plr.Name
		local Island = Instance.new("StringValue",plr)
		Island.Name = "Island"
		Island.Value = "Island2"
		local a = game.Workspace:WaitForChild(plr.Name)
		if a then
			a.HumanoidRootPart.CFrame = spawnpoint2.CFrame
		end
		
		game.Players.PlayerRemoving:Connect(function(player)
			if player.Name == plr.Name then	
				oyuncular.Sahip2.Value = false
				oyuncular.TycoonSahibi2.Value = ""
			end	
		end)
		
		
		
	elseif oyuncular.Sahip3.Value == false then
		
		
		oyuncular.Sahip3.Value = true
		oyuncular.TycoonSahibi3.Value = plr.Name
		local Island = Instance.new("StringValue",plr)
		Island.Name = "Island"
		Island.Value = "Island3"
		local a = game.Workspace:WaitForChild(plr.Name)
		if a then
			a.HumanoidRootPart.CFrame = spawnpoint3.CFrame
		end
		
		game.Players.PlayerRemoving:Connect(function(player)
			if player.Name == plr.Name then	
				oyuncular.Sahip3.Value = false
				oyuncular.TycoonSahibi3.Value = ""
			end	
		end)
		
		
		
	elseif oyuncular.Sahip4.Value == false then
		
		
		oyuncular.Sahip4.Value = true
		oyuncular.TycoonSahibi4.Value = plr.Name
		local Island = Instance.new("StringValue",plr)
		Island.Name = "Island"
		Island.Value = "Island4"
		local a = game.Workspace:WaitForChild(plr.Name)
		if a then
			a.HumanoidRootPart.CFrame = spawnpoint4.CFrame
		end
		
		game.Players.PlayerRemoving:Connect(function(player)
			if player.Name == plr.Name then	
				oyuncular.Sahip4.Value = false
				oyuncular.TycoonSahibi4.Value = ""
			end	
		end)
		
		
		
	end
	
end)