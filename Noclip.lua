local a=game.Players.LocalPlayer;game:GetService("RunService").Stepped:Connect(function()for b,c in pairs(a.Character:GetDescendants())do if c:IsA("BasePart")then c.CanCollide=false end end end
