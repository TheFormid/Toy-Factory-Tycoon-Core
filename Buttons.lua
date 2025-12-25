local TweenService = game:GetService("TweenService")

local event = game.ReplicatedStorage.Remotes.Reset2
local DataManager = require(game.ReplicatedStorage.DataManager)
local ProfileManager require(game.ReplicatedStorage.ProfileService)

local TweeningInformation = TweenInfo.new(

	1, --Length

	Enum.EasingStyle.Sine, -- Easing style of the TweenInfo
	Enum.EasingDirection.InOut, -- Easing direction of the TweenInfo
	0, -- Number of times the tween will repeat	
	false, -- Should the tween repeat ?	
	0 -- Delay between each tween

)

local debounce = 0	

--function Reset()
--	debounce = 1 
--	wait(5)
--	debounce = 0
--end

local factoryReis = game.Workspace.Island1.ToyFactory1

for i , button in pairs(factoryReis.Buttons:GetChildren()) do
	print("reis sen oluyonmu")
	local x = 0
	local y = 0
	if button.OncekiButon.Value == "" then
		if button:FindFirstChild("AlinmasiGerekenButonSayisi") then
			script.SatinAlinanButonSayisi.Changed:Connect(function()
				if script.SatinAlinanButonSayisi.Value == button.AlinmasiGerekenButonSayisi.Value then
					if button.SatinAlindimi.Value ==  false then
						if y == 0 then
							y = 1
							local pos = button.Position
							local size = button.Size
							local ori = button.Orientation
							button.Position = button.Position + Vector3.new(0,-3,0)
							button.Size = Vector3.new(0.1,0.1,0.1)
							button.Orientation = Vector3.new(0,90,0)
							local zopla = {Position = pos,Size = size,Transparency = 0}
							local don = {Orientation = ori}
							local bak = TweenService:Create(button,TweeningInformation,zopla)
							local bakdon = TweenService:Create(button,TweeningInformation,don)
							--	button.Parent = game.Workspace.Island1.ToyFactory1.SatinAlindi
							--	button.Transparency = 0
							bak:Play()
							wait(0.3)
							bakdon:Play()
							--	TweenService:Create(button, TweenInfo.new(1,Enum.EasingStyle.Back),{Position = pos,Size = size}):Play()
							--	button.Transparency = 0
							--	wait(0)
							button.BillboardGui.Enabled = true
							--	wait(5)
						end	
					end	
				end
			end)
		end
	else
		button.BillboardGui.down.Text =  tostring("$")..tostring(button.Fiyat.Value)
		local Buttons = script.Parent.Buttons:GetChildren()
		for i , cocuk in pairs(Buttons) do
			
			if cocuk.Name == button.OncekiButon.Value then
				
				local ihtiyac = cocuk
				ihtiyac.Touched:Connect(function(touched)	
					local store = game.ReplicatedStorage.Sahip
					local player = store.TycoonSahibi1.Value
					
					if touched.Parent:FindFirstChild("Humanoid") then
						
						if ihtiyac.Transparency == 0 then
						--	ihtiyac.Transparency = 1
						
							if touched.Parent.Name == store.TycoonSahibi1.Value then
								local plr = game.Players:GetPlayerFromCharacter(touched.Parent)
								local data = DataManager:Get(plr)
								if data then
									if data.Money >= ihtiyac.Fiyat.Value then
										if ihtiyac.SatinAlindimi.Value == false then
											
											if y == 0 then
												print("what the ff fuck")
												y = 1
												local pos = button.Position
												local size = button.Size
												local ori = button.Orientation
												button.Position = button.Position + Vector3.new(0,-3,0)
												button.Size = Vector3.new(0.1,0.1,0.1)
												button.Orientation = Vector3.new(0,90,0)
												local zopla = {Position = pos,Size = size,Transparency = 0}
												local don = {Orientation = ori}
												local bak = TweenService:Create(button,TweeningInformation,zopla)
												local bakdon = TweenService:Create(button,TweeningInformation,don)
											--	button.Parent = game.Workspace.Island1.ToyFactory1.SatinAlindi
											--	button.Transparency = 0
												bak:Play()
												wait(0.3)
												bakdon:Play()
											--	TweenService:Create(button, TweenInfo.new(1,Enum.EasingStyle.Back),{Position = pos,Size = size}):Play()
												--	button.Transparency = 0
											--	wait(0)
												button.BillboardGui.Enabled = true
											--	wait(5)
											--	y = 0
												
												
											end	
										end	
									end	 
								end	
							end	
						end
					end
				end)
			end
		end
	end

	button.Touched:Connect(function(touched)
		
		if button.SatinAlindimi.Value == false then
			if touched.Parent:FindFirstChild("Humanoid") then
				
				local store = game.ReplicatedStorage.Sahip
				local player = store.TycoonSahibi1.Value
				if touched.Parent.Name == player then
					
					local plr = game.Players:GetPlayerFromCharacter(touched.Parent)
					if button.Transparency == 0 then
						local data = DataManager:Get(plr)
						if data then
							if data.Money >= button.Fiyat.Value then
								
								if x == 0 then
									x = 1
									if button.SatinAlindimi.Value == false then
										
										wait(0.4)
										button.SatinAlindimi.Value = true 							
										data.Money -= button.Fiyat.Value
										button.Transparency = 1
										button.BillboardGui.Enabled = false
									---	local b = data.Tycoon
										table.insert(data.Tycoon,button.Name)
										script.SatinAlinanButonSayisi.Value += 1
									--	wait(5)
									--	x = 0
										
										for i, cocuk in pairs(game.ReplicatedStorage.ToyFactory1.SatinAlincaklar:GetChildren()) do
											if cocuk.Name == button.AlincakEsya.Value then
												local Alincak = cocuk:Clone()
												Alincak.Name = cocuk.Name
												Alincak.Parent = game.Workspace.Island1.ToyFactory1.SatinAlindi
												
												if button:FindFirstChild("Şekil") then
													
													local RealValue = Alincak.Cevirici.Value
													local tabl = data.CeviriciToys
													plr.PlayerGui.ChooseGui.Enabled = true
													local gui = game.ReplicatedStorage.Chest.gui
													for i , v in pairs(data.ToyTable)do
														--event:FireClient(v.ToyName,v.ToyImageId,v.K)
														print(v.ToyName)
														local guicik = gui:Clone()
														guicik.Name = v.Studs
														guicik.TextLabel.Text = v.K
														guicik.render.Image = v.ToyImageId
														guicik.Parent = player.PlayerGui:FindFirstChild("ChooseGui").Background.Oyuncaklar
														guicik.DeleteButton.Visible = true
														guicik.ToyName.Value = v.ToyName
														
														local d = 0
														guicik.DeleteButton.MouseButton1Down:Connect(function()
															local gui = plr.PlayerGui.InventoryGui.Background.Oyuncaklar:FindFirstChild(v.Studs)
															gui:Destroy()
															guicik:Destroy()
															player.PlayerGui.ChooseGui.Enabled = false
															Alincak.Cevirici.Value = guicik.ToyName.Value
															table.remove(data.ToyTable,i)
													--		for k , z in pairs(data.ToyTable) do
														--		if z.ToyName == v.ToyName then
															--		if d == 0 then
																	--	d = 1
																	--	table.remove(data.ToyTable,k)
																		
																	--	print(k)
																--	end	
															--	end
														--	end
														end)
														
													end
													table.insert(data.CeviriciToys,#tabl,Alincak.Cevirici.Value.Value)
													
												end
											--	local pos = Alincak.Reference.Position
											--	local ori = Alincak.Orientation
											--	Alincak.Reference.Position = Alincak.Reference.Position+Vector3.new(0,-8,0)
												for i, alincakParts in pairs(Alincak:GetDescendants()) do
													if alincakParts:IsA("BasePart") then
														if alincakParts.Anchored == false then
													--	elseif alincakParts.CanCollide == false then
														elseif alincakParts.Transparency == 1 then
														elseif alincakParts:FindFirstChild("NotTween") then
														--	alincakParts.Transparency = 1
														else
															
														--	alincakParts.CanCollide = true
															local CanCollide = alincakParts.CanCollide

															local pos = alincakParts.Position
															local ori = alincakParts.Orientation
															local size = alincakParts.Size
														--	wait(0.01)
															--	alincakParts.Transparency = 0
															alincakParts.CanCollide = false
															alincakParts.Position = Vector3.new(math.random(-10,10)+alincakParts.Position.X,math.random(-10,10)+alincakParts.Position.Y,math.random(-10,10)+alincakParts.Position.Z)
															alincakParts.Orientation = Vector3.new(math.random(-10,10)+alincakParts.Orientation.X,math.random(-10,10)+alincakParts.Orientation.Y,math.random(-10,10)+alincakParts.Orientation.Z)
															alincakParts.Size = Vector3.new(math.random(-10,10)+alincakParts.Size.X,math.random(-10,10)+alincakParts.Size.Y,math.random(-10,10)+alincakParts.Size.Z)
															TweenService:Create(alincakParts, TweenInfo.new(0.5,Enum.EasingStyle.Back),{Position = pos,Orientation = ori,Size = size}):Play()
															alincakParts.CanCollide = CanCollide
															
														end
													elseif alincakParts:IsA("Script") then
														alincakParts.Disabled = false
													end
												end
											end
										end



									--				local pos = drop.Position
									--				local ori = drop.Orientation
									--				drop.Position = Vector3.new(math.random(-10,10)+drop.Position.X,math.random(-10,10)+v.Position.Y,math.random(-10,10)+drop.Position.Z)
									--				drop.Orientation = Vector3.new(math.random(-10,10)+drop.Orientation.X,math.random(-10,10)+v.Orientation.Y,math.random(-10,10)+drop.Orientation.Z)
									--				TweenService:Create(drop, TweenInfo.new(math.random(5,15)/10,Enum.EasingStyle.Back),{Position = pos,Orientation = ori}):Play()

									--				v.BrickColor = BrickColor.new("Neon orange")
									--				drop.BrickColor = BrickColor.new("Really red")
									
									end
								end	
							end	
						end	
					end	
				end	
			end
		end
		
	end)
end
