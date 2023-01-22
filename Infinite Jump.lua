local g = getgenv()

if g._swim then
    g._swim:Disconnect()
    g._swim = nil
end

local u = game:GetService("UserInputService")
g._swim = u.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then
        return
    end

    if input.KeyCode == Enum.KeyCode.Space then
        game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)
