
# 🏭 Toy Factory Tycoon (Technical Prototype)
> **Role:** Lead Scripter & System Architect  
> **Platform:** Roblox (Luau)  
> **Status:** Archived (Technical Showcase)

## 📖 About the Project
**Toy Factory Tycoon** is a hybrid simulation game that combines traditional tycoon mechanics with complex supply chain management and vehicle logistics. Unlike standard Roblox tycoons, this project features a **server-authoritative architecture** ensuring secure transactions and a highly optimized, custom-written interaction engine.

## 🛠️ Technical Systems & Architecture
Key engineering patterns implemented in this project:

### 1. Server-Authoritative Tycoon Core
The entire tycoon progression is managed securely on the server to prevent exploitation.
- **Dependency Graph:** Button unlocks are chained via a dependency system (`OncekiButon` check), ensuring players cannot skip progression stages.
- **State Persistence:** The game saves not just currency, but the exact state of the factory. Upon rejoining, the `DataManager` reconstructs the tycoon piece-by-piece using saved unique identifiers.
- **Multiplayer Ownership:** Handles concurrent tycoon slot assignment (`Sahip1` to `Sahip4`) dynamically when players join.

> **Code Highlight (`DataManager.lua`):**
> *Logic that reconstructs the player's tycoon from saved data upon login:*

```lua
-- Iterating through saved "Tycoon" data to restore purchased buttons and machines
for i, v in pairs(Data.Tycoon) do
    local button = Tft.Buttons:FindFirstChild(v)
    button.SatinAlindimi.Value = true -- Mark as purchased
    button.Transparency = 1           -- Hide the button
    
    -- Cloning the purchased item (Machine/Dropper) from ReplicatedStorage to Workspace
    local itemToClone = game.ReplicatedStorage.ToyFactory1.SatinAlincaklar:FindFirstChild(button.AlincakEsya.Value)
    local item = itemToClone:Clone()
    item.Parent = Tft.SatinAlindi
end

```

### 2. Custom "Magnitude-Based" Interaction Engine

To optimize performance and bypass the limitations of standard Roblox ProximityPrompts, I engineered a custom interaction handler.

* **Distance Checks:** Uses `(Vector3 - Vector3).Magnitude` calculations in a highly optimized client-side loop to determine interactable objects within range (< 11 studs).
* **UI culling:** Automatically renders/derenders 3D UI elements (`BillboardGui`) based on player distance to save resources.

> **Code Highlight (`ProximityOptimizer.lua`):**
> *Client-side optimization loop for vehicle shops:*

```lua
-- Real-time distance calculation for interaction visibility
local aralik = (hmr.Position - v.Position).magnitude
if aralik < 11 then
    v.BillboardGui.ImageButton.Visible = true -- Show UI
    
    -- Input handling for interaction (E Key)
    UserInputService.InputBegan:Connect(function(KeyPressed)
        if KeyCodePressed == Enum.KeyCode.E then 
            game.ReplicatedStorage.VehicleRemotes.Cycle:FireServer(v.Fiyat.Value,v.Vehicle.Value,v,aralik,v.renderImage.Value)
        end
    end)
else
    v.BillboardGui.ImageButton.Visible = false -- Hide UI for optimization
end

```

### 3. Secure Transaction & Vehicle Logic

Purchasing logic verifies player funds on the server before authorizing any changes.

* **Validation:** `VehicleTransaction` script confirms the player's balance matches the server-side price, preventing client-side spoofing.
* **Dynamic Spawning:** Spawns vehicles relative to the player's specific tycoon plot (`Island1` vs `Island2`), adjusting CFrames dynamically.

## 📂 Source Code

You can explore the core systems in the repository:

* [DataManager.lua](https://www.google.com/search?q=DataManager.lua) - Save/load logic and tycoon reconstruction.
* [Buttons.lua](https://www.google.com/search?q=Buttons.lua) - Core tycoon button mechanics and tween animations.
* [ProximityOptimizer.lua](https://www.google.com/search?q=ProximityOptimizer.lua) - Custom interaction system.
* [VehicleTransaction.lua](https://www.google.com/search?q=VehicleTransaction.lua) - Secure server-side purchasing logic.

```

```
