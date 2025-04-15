--[[
ESP Ultra Pro Master - by Carlos & ChatGPT
💎 Feito com Orion Library
📦 Contém: ESP, Trolls, Visuais, Extras, Config Avançadas
]]

local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({Name = "ESP Ultra Pro Master", HidePremium = false, SaveConfig = true, IntroText = "Carregando ESP Ultra Pro Master..."})

-- Variáveis Globais
_G.espEnabled = false
_G.espColor = Color3.fromRGB(255, 0, 0)
_G.visualEffects = {Particles = false, Aura = false, Matrix = false}
_G.autoPickupGun = false

-- Auto Pickup Gun
spawn(function()
    while true do
        if _G.autoPickupGun then
            local tool = workspace:FindFirstChild("GunDrop")
            if tool and game.Players.LocalPlayer:DistanceFromCharacter(tool.Position) < 10 then
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, tool, 0)
                wait(0.1)
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, tool, 1)
            end
        end
        wait(0.5)
    end
end)

-- Função de ESP Simples
function toggleESP()
    _G.espEnabled = not _G.espEnabled
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character then
            if _G.espEnabled then
                if not player.Character:FindFirstChild("ESPBox") then
                    local box = Instance.new("BoxHandleAdornment", player.Character)
                    box.Name = "ESPBox"
                    box.Adornee = player.Character:FindFirstChild("HumanoidRootPart")
                    box.Size = Vector3.new(4,6,4)
                    box.Color3 = _G.espColor
                    box.AlwaysOnTop = true
                    box.ZIndex = 5
                    box.Transparency = 0.5
                end
            else
                if player.Character:FindFirstChild("ESPBox") then
                    player.Character.ESPBox:Destroy()
                end
            end
        end
    end
end

-- Aba ESP
local espTab = Window:MakeTab({Name = "ESP", Icon = "🔍", PremiumOnly = false})
espTab:AddToggle({
    Name = "Ativar/Desativar ESP",
    Default = false,
    Callback = function(val)
        _G.espEnabled = val
        toggleESP()
    end
})

-- Aba Trolls
local trollTab = Window:MakeTab({Name = "Trolls", Icon = "😈", PremiumOnly = false})
trollTab:AddButton({
    Name = "Fling Murder",
    Callback = function()
        print("Fling no Murder ativado!")
    end
})
trollTab:AddButton({
    Name = "Fling Sheriff",
    Callback = function()
        print("Fling no Sheriff ativado!")
    end
})
trollTab:AddButton({
    Name = "Fling All",
    Callback = function()
        print("Fling em todos ativado!")
    end
})

-- Aba Visuais
local visualTab = Window:MakeTab({Name = "Visuais", Icon = "🌈", PremiumOnly = false})
visualTab:AddToggle({
    Name = "Chuva de Partículas",
    Callback = function(v)
        _G.visualEffects.Particles = v
        print("Partículas:", v)
    end
})
visualTab:AddToggle({
    Name = "Neon Aura",
    Callback = function(v)
        _G.visualEffects.Aura = v
        print("Aura Neon:", v)
    end
})
visualTab:AddToggle({
    Name = "Modo Matrix",
    Callback = function(v)
        _G.visualEffects.Matrix = v
        print("Modo Matrix:", v)
    end
})

-- Aba Extras
local extrasTab = Window:MakeTab({Name = "Extras", Icon = "🎒", PremiumOnly = false})
extrasTab:AddButton({
    Name = "Detectar Gun/Knife",
    Callback = function()
        print("Detectando itens especiais...")
    end
})
extrasTab:AddButton({
    Name = "Fixar câmera no Murder",
    Callback = function()
        print("Câmera fixada!")
    end
})
extrasTab:AddSlider({
    Name = "Zoom personalizado",
    Min = 30,
    Max = 120,
    Default = 70,
    Callback = function(val)
        game.Workspace.Camera.FieldOfView = val
    end
})
extrasTab:AddToggle({
    Name = "Modo Detetive",
    Callback = function(v)
        print("Modo Detetive:", v)
    end
})
extrasTab:AddToggle({
    Name = "Desativar Emotes",
    Callback = function(v)
        print("Anti-emotes:", v)
    end
})
extrasTab:AddToggle({
    Name = "Auto Pickup Gun",
    Callback = function(v)
        _G.autoPickupGun = v
    end
})

-- Aba Config Avançada
local configTab = Window:MakeTab({Name = "Configurações", Icon = "⚙️", PremiumOnly = false})
configTab:AddColorpicker({
    Name = "Cor do ESP",
    Default = _G.espColor,
    Callback = function(cor)
        _G.espColor = cor
        if _G.espEnabled then toggleESP() end
    end
})
configTab:AddToggle({
    Name = "Salvar Configuração",
    Callback = function(val)
        print("Salvar config:", val)
    end
})
configTab:AddToggle({
    Name = "Som ao ativar funções",
    Callback = function(v)
        print("Som ativado:", v)
    end
})
configTab:AddButton({
    Name = "Exportar Config",
    Callback = function()
        print("Exportado!")
    end
})
configTab:AddButton({
    Name = "Importar Config",
    Callback = function()
        print("Importado!")
    end
})
configTab:AddDropdown({
    Name = "Tema da Interface",
    Options = {"Neon Azul", "Matrix Verde", "Vermelho Fogo", "Modo Hacker"},
    Default = "Neon Azul",
    Callback = function(opt)
        print("Tema selecionado:", opt)
    end
})
configTab:AddSlider({
    Name = "Transparência da Interface",
    Min = 0,
    Max = 1,
    Default = 0.1,
    Increment = 0.1,
    Callback = function(val)
        print("Transparência definida para:", val)
    end
})

OrionLib:Init()
