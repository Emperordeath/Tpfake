Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Death Hub | Baús",
    LoadingTitle = "Death Hub",
    LoadingSubtitle = "By IamEmperorDeath",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "DeathHubConfigs",
        FileName = "ChestTouch"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = false
    },
    KeySystem = false,
})

local Main = Window:CreateTab("Baús", 4483362458)

local autoTouch = false
local touchDelay = 2

Main:CreateSlider({
    Name = "Delay entre coletas (segundos)",
    Range = {1, 5},
    Increment = 1,
    Suffix = "s",
    CurrentValue = touchDelay,
    Callback = function(Value)
        touchDelay = Value
    end
})

Main:CreateToggle({
    Name = "Auto Coletar RewardChest (Sem TP)",
    CurrentValue = false,
    Callback = function(Value)
        autoTouch = Value
        if autoTouch then
            Rayfield:Notify({
                Title = "Auto Coleta Ativado",
                Content = "Tentando tocar no RewardChest a cada " .. touchDelay .. " segundos.",
                Duration = 3
            })
            task.spawn(function()
                while autoTouch do
                    local rewardChest = workspace:FindFirstChild("RewardChest")
                    local char = game.Players.LocalPlayer.Character
                    if rewardChest and char then
                        local part = char:FindFirstChildWhichIsA("BasePart")
                        if part and rewardChest:IsA("BasePart") then
                            firetouchinterest(part, rewardChest, 0)
                            firetouchinterest(part, rewardChest, 1)
                        end
                    else
                        Rayfield:Notify({
                            Title = "Erro",
                            Content = "RewardChest ou personagem não encontrado.",
                            Duration = 3
                        })
                    end
                    task.wait(touchDelay)
                end
            end)
        else
            Rayfield:Notify({
                Title = "Auto Coleta Desativado",
                Content = "Parando as coletas automáticas.",
                Duration = 3
            })
        end
    end
})
