local ID = game.PlaceId
local baseURL = nil
local Players = game:GetService("Players")
local plr = Players.LocalPlayer

function GetGame()
    if ID == 4982363836 then
        return "CoH.lua"
    else
        plr:Kick("Jogo sem suporte")
        return nil
    end
end

local gameScript = GetGame()

if gameScript then
    loadstring(game:HttpGet(baseURL .. gameScript))()
end

for _, v in next, getconnections(plr.Idled) do
    v:Disable()
end

local VirtualUser = game:GetService("VirtualUser")
local status = getgenv().afk_toggle
if status == nil then
    getgenv().afk_toggle = false
end

if not plr then
    error("Falha ao obter referência: LocalPlayer")
end

plr.Idled:Connect(function()
    if not getgenv().afk_toggle then return end
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)
