local Eternal = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

function Eternal.Randomized_Hands()
    local CatchParts = {
        [1] = "Right Arm",
        [2] = "Left Arm"
    }

    return Character:FindFirstChild(CatchParts[math.random(1, #CatchParts)])
end

return Eternal
