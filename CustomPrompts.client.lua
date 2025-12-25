local ProximityPromptService = game:GetService("ProximityPromptService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui", 30)

local PromptGui = PlayerGui:WaitForChild("Prompt", 30)

--- CONFIGURATION ---
local touchIcon = "rbxasset://textures/ui/controls/TouchTapIcon.png"
local basicColor = Color3.fromRGB(24, 31, 48)
local holdColor = Color3.fromRGB(33, 43, 70)

local PromptTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local PromptHoldTweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
--- END ---

local GamepadButtonImage = {
	[Enum.KeyCode.ButtonX] = "rbxasset://textures/ui/Controls/xboxX.png",
	[Enum.KeyCode.ButtonY] = "rbxasset://textures/ui/Controls/xboxY.png",
	[Enum.KeyCode.ButtonA] = "rbxasset://textures/ui/Controls/xboxA.png",
	[Enum.KeyCode.ButtonB] = "rbxasset://textures/ui/Controls/xboxB.png",
	[Enum.KeyCode.DPadLeft] = "rbxasset://textures/ui/Controls/dpadLeft.png",
	[Enum.KeyCode.DPadRight] = "rbxasset://textures/ui/Controls/dpadRight.png",
	[Enum.KeyCode.DPadUp] = "rbxasset://textures/ui/Controls/dpadUp.png",
	[Enum.KeyCode.DPadDown] = "rbxasset://textures/ui/Controls/dpadDown.png",
	[Enum.KeyCode.ButtonSelect] = "rbxasset://textures/ui/Controls/xboxmenu.png",
	[Enum.KeyCode.ButtonL1] = "rbxasset://textures/ui/Controls/xboxLS.png",
	[Enum.KeyCode.ButtonR1] = "rbxasset://textures/ui/Controls/xboxRS.png",
}

local buttonDown
local holdBeganConnection
local holdEndedConnection
local triggeredConnection
local triggerEndedConnection

local function Tween(tweenInfo, instances, properties)
    pcall(function()
        for _, instance in ipairs(instances) do
            local TweenInstance = TweenService:Create(instance, tweenInfo, properties)
            TweenInstance:Play()
        end
    end)
end

local function onShown(prox, input, Prompt)
    if input == Enum.ProximityPromptInputType.Touch then
        Prompt.ActivateButton.Text = ""
        Prompt.ActivateButton.Icon.Image = touchIcon
    elseif input == Enum.ProximityPromptInputType.Keyboard then
        local text = UserInputService:GetStringForKeyCode(prox.KeyboardKeyCode)
        Prompt.ActivateButton.Text = text

        Prompt.ActivateButton.Icon.Image = ""

        if text == "" then
            warn("ProximityPrompt \"" .. prox.Name .. "\" has unsupported Keyboard KeyCode for rendering.")

            Prompt.ActivateButton.Text = "?"
        end
    elseif input == Enum.ProximityPromptInputType.Gamepad then
        Prompt.ActivateButton.Text = ""

        local success = pcall(function()
            Prompt.ActivateButton.Icon.Image = GamepadButtonImage[prox.GamepadKeyCode]
        end)

        if not success then
            warn("ProximityPrompt \"" .. prox.Name .. "\" has unsupported Gamepad KeyCode for rendering.")

            Prompt.ActivateButton.Icon.Image = ""
            Prompt.ActivateButton.Text = "?"
        end
    end

    Prompt.ActivateButton.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) and input.UserInputState ~= Enum.UserInputState.Change then
            buttonDown = true
            prox:InputHoldBegin()
        end
    end)

    Prompt.ActivateButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            if buttonDown then
                buttonDown = false
                prox:InputHoldEnd()
            end
        end
    end)

    Prompt.Adornee = prox.Parent

    Tween(PromptTweenInfo, { Prompt.ActivateButton }, { TextTransparency = 0, BackgroundTransparency = 0, Position = UDim2.fromScale(0.5, 0.5), })
    Tween(PromptTweenInfo, { Prompt.ActivateButton.Icon }, { ImageTransparency = 0, })

    if prox.HoldDuration > 0 then
        holdBeganConnection = prox.PromptButtonHoldBegan:Connect(function()
            if Prompt:FindFirstChild("ActivateButton") then
                Tween(PromptHoldTweenInfo, { Prompt.ActivateButton }, { BackgroundColor3 = holdColor, Size = UDim2.fromScale(1.2, 1.2), })
            end
        end)

        holdEndedConnection = prox.PromptButtonHoldEnded:Connect(function()
            if Prompt:FindFirstChild("ActivateButton") then
                Tween(PromptHoldTweenInfo, { Prompt.ActivateButton }, { BackgroundColor3 = basicColor, Size = UDim2.fromScale(1, 1), })
            end
        end)
    end

    triggeredConnection = prox.Triggered:Connect(function()
        if Prompt:FindFirstChild("ActivateButton") then
            Tween(PromptHoldTweenInfo, { Prompt.ActivateButton }, { BackgroundColor3 = holdColor, Size = UDim2.fromScale(1.2, 1.2), })
        end
    end)

    triggerEndedConnection = prox.TriggerEnded:Connect(function()
        if Prompt:FindFirstChild("ActivateButton") then
            Tween(PromptHoldTweenInfo, { Prompt.ActivateButton }, { BackgroundColor3 = basicColor, Size = UDim2.fromScale(1, 1), })
        end
    end)
end

local function onHidden(pr)
    Tween(PromptTweenInfo, { pr.ActivateButton }, { TextTransparency = 1, BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.7), })
    Tween(PromptTweenInfo, { pr.ActivateButton.Icon }, { ImageTransparency = 1, })

    if holdBeganConnection and holdEndedConnection then
        holdBeganConnection:Disconnect()
        holdEndedConnection:Disconnect()
    end

    triggerEndedConnection:Disconnect()
    triggeredConnection:Disconnect()

    wait(0.3)

    pr:Destroy()
end

ProximityPromptService.PromptShown:Connect(function(prompt, inputType)
    if prompt.Style == Enum.ProximityPromptStyle.Default then
        return
    end

    local Prompt = PromptGui:Clone()
    Prompt.Name = "DisplayPrompt"
    Prompt.Parent = PlayerGui

    onShown(prompt, inputType, Prompt)

    prompt.PromptHidden:Wait()

    onHidden(Prompt)
end)