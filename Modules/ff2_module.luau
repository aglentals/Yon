--@todo: ermmmmm I have no idea yet

local Eternal = {}

--// Types
export type Eternal = {
	Randomized_Hands: () -> BasePart?,
	Get_Closest_Player: () -> Model?,
	Get_Closest_Football: () -> BasePart?,
	FireTouchInterest: (Part: BasePart?, Transmitter: BasePart?, Value: number) -> (),
	GetPingMS: () -> number,
}

--// Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

--// Player
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local HRP: BasePart = Character:WaitForChild("HumanoidRootPart")
local Hum: Humanoid = Character:WaitForChild("Humanoid")

--// Functions
function Eternal.Randomized_Hands(): BasePart?
	local CatchParts = { "CatchLeft", "CatchRight" }
	return Character:FindFirstChild(CatchParts[math.random(1, #CatchParts)]) :: BasePart?
end

function Eternal.Get_Closest_Player(): Model?
	local Closest: Model? = nil
	local ClosestDistance = math.huge

	for _, Player in Players:GetPlayers() do
		if Player ~= LocalPlayer and Player.Team ~= LocalPlayer.Team then
			local Char = workspace:FindFirstChild(Player.Name)
			local Root = Char and Char:FindFirstChild("HumanoidRootPart") :: BasePart?

			if Root then
				local Distance = (HRP.Position - Root.Position).Magnitude
				if Distance < ClosestDistance then
					ClosestDistance = Distance
					Closest = Char
				end
			end
		end
	end

	return Closest
end

function Eternal.Get_Closest_Football(): BasePart?
	local ClosestFootball: BasePart? = nil
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

-- // i have fucking 0 idea why i have this anymore ill just keep it :)
function Eternal.FireTouchInterest(Part: BasePart?, Transmitter: BasePart?, Value: number)
	if Part and Transmitter and Value == 0 then
		local tween = TweenService:Create(Part, TweenInfo.new(0, Enum.EasingStyle.Linear), {Position = Transmitter.Position})
		tween:Play()
	end
end

function Eternal.GetPingMS(): number
	return math.floor((LocalPlayer:GetNetworkPing() or 0) * 1000)
end

return Eternal :: Eternal
