rnv = {}
cache = {}
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
----------------------------------------------------------------------------------------------------------------------------------
--------------- VERSÃO GRATUITA DO SCRIPT DE HORAS, PARA ADQUIRIR A VERSÃO COMPLETA POR R$25 -----------------------------------------------
----------------- COM BANCO DE DADOS DE HORAS + BATEPONTOS POLICIA/HP e STAFF, CONTATE:Renv#2453-----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
local webhookhoras = "https://discord.com/api/webhooks/894549405695373343/08T_l-H9Ft6zFNFsf5hm4ysUer9krCfZUv0cyVvgSnxXTI3mLAfM24Oua4uS5H0mIs7F" -- COLOQUE AQUI O SEU WEBHOOK

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

function rnv.horalogin(user_id)
    cache[user_id] = os.time()
end

function rnv.cachehoralogin(user_id)
    return cache[user_id]
end

function rnv.tempototal(user_id)
	tempoentrada = rnv.cachehoralogin(user_id)
	end_time = os.time()
	tempodecorrido = os.difftime(end_time, tempoentrada)
    local hours = math.floor(tempodecorrido/3600)
    tempodecorrido = tempodecorrido - hours * 3600
    local minutes = math.floor(tempodecorrido/60)
    tempodecorrido = tempodecorrido - minutes * 60
	valorhoras = string.format("%d Horas, %d Minutos e %d Segundos",hours,minutes,tempodecorrido)
	SendWebhookMessage(webhookhoras,"```prolog\n[ID]: "..user_id.." \n[=========SAIU DO SERVIDOR=========]\nTEMPO DE JOGO: "..valorhoras.."\n"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local source = source
    local user_id = vRP.getUserId(source)
	if first_spawn then
		rnv.horalogin(user_id)
	end
end)

AddEventHandler("playerDropped", function(user_id)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
		rnv.tempototal(user_id)
    end
end)