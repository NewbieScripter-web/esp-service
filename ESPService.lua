-- ESP Service Script
local ESPService = {}

-- Colores para cada tipo de jugador
local colors = {
    Innocent = Color3.fromRGB(169, 169, 169),  -- Gris
    Murderer = Color3.fromRGB(255, 0, 0),      -- Rojo
    Sheriff = Color3.fromRGB(0, 0, 255),       -- Azul
    Hero = Color3.fromRGB(255, 255, 0)          -- Amarillo
}

-- Crear un marco para mostrar el ESP
function ESPService:AddESP(player)
    -- Crear un 'billboard' sobre el personaje del jugador
    local character = player.Character
    if character and character:FindFirstChild("Head") then
        local head = character.Head

        -- Crear un objeto GUI para el ESP
        local espPart = Instance.new("BillboardGui")
        espPart.Adornee = head
        espPart.Size = UDim2.new(0, 5, 0, 5)  -- Tamaño del marcador
        espPart.StudsOffset = Vector3.new(0, 2, 0)  -- Eleva el marcador sobre la cabeza
        espPart.AlwaysOnTop = true

        -- Crear un marco para dibujar
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        frame.BackgroundTransparency = 0.8
        frame.Parent = espPart

        -- Configurar el color dependiendo del rol
        espPart.Parent = game.CoreGui

        return espPart
    end
end

-- Función para actualizar el color del ESP según el rol
function ESPService:UpdateESP(player, role)
    local espPart = self:AddESP(player)
    if espPart then
        if role == "Innocent" then
            espPart.Frame.BackgroundColor3 = colors.Innocent
        elseif role == "Murderer" then
            espPart.Frame.BackgroundColor3 = colors.Murderer
        elseif role == "Sheriff" then
            espPart.Frame.BackgroundColor3 = colors.Sheriff
        elseif role == "Hero" then
            espPart.Frame.BackgroundColor3 = colors.Hero
        end
    end
end

-- Actualizar los jugadores cuando se unan
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        local role = player:FindFirstChild("PlayerRole") and player.PlayerRole.Value or "Innocent"
        ESPService:UpdateESP(player, role)
    end)
end)

-- Actualizar los jugadores existentes al iniciar
for _, player in ipairs(game.Players:GetPlayers()) do
    if player.Character then
        local role = player:FindFirstChild("PlayerRole") and player.PlayerRole.Value or "Innocent"
        ESPService:UpdateESP(player, role)
    end
end

return ESPService
