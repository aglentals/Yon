local Eternal = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local HRP: Part = Character and Character:WaitForChild("HumanoidRootPart")
local Hum: Humanoid = Character and Character:WaitForChild("Humanoid")

function Eternal.Randomized_Hands()
    local CatchParts = {
        [1] = "Right Arm",
        [2] = "Left Arm"
    }

    return Character:FindFirstChild(CatchParts[math.random(1, #CatchParts)])
end

function Eternal.Get_Closest_Player()
    local Closest = nil
	local ClosestDistance = 9e9

	for _, Value in Players.GetPlayers(Players) do
		if Value ~= LocalPlayer then
			if Value.Team ~= LocalPlayer.Team then
				if Value and workspace[Value.Name]:FindFirstChild("HumanoidRootPart") then
					local DistanceTwo = (HRP.Position - workspace[Value.Name].HumanoidRootPart.Position).Magnitude
					if DistanceTwo < ClosestDistance then
						ClosestDistance = DistanceTwo
						ClosestDistance = workspace[Value.Name]
					end
				end
			end
		end
	end

	return Closest
end

function Eternal.Get_Closest_Football()
    local ClosestFootball = nil
    local ClosestDistance = math.huge

    for _, Value in workspace:GetChildren() do
        if Value.Name == "Football" and Value:IsA("BasePart") then
            local Distance = (Value.Position - HRP.Position).Magnitude

            if Distance < ClosestDistance then
                ClosestFootball = Value
                ClosestDistance = Distance
            end
        end
    end

    return ClosestFootball
end

function Eternal.FireTouchInterest(Part, Transmitter, Value)
    if Transmitter and Part then
        if (Value == 0) then
            local tweenInfo = TweenInfo.new(0, Enum.EasingStyle.Linear)
            local goal = {Position = Transmitter.Position}
            local tween = TweenService:Create(Part, tweenInfo, goal)
            tween:Play()
        end
    end
end

function Eternal.GetPingMS()
    return math.floor((Players.LocalPlayer:GetNetworkPing() or 0) * 1000)
end

return Eternal
