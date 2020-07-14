local defsave = require "defsave.defsave"
local monarch = require "monarch.monarch"
local _pokemon = require "pokedex.pokemon"
local storage = require "pokedex.storage"
local pokedex = require "pokedex.pokedex"
local nature = require "pokedex.natures"
local defsave = require "defsave.defsave"
local movedex = require "pokedex.moves"
local generate = require "screens.generate_pokemon.generate_pokemon"
local backup = require "utils.backup"
local network = require "pokedex.network"

local M = {}

M.loaded_backup = false
M.SHARE = false

local function add_pokemon(species)
	local level = math.min(rnd.range(1, 20), pokedex.get_minimum_wild_level(species))
	generate.add_pokemon(species, level)
end


function M.add_pokemon(amount)
	amount = amount or 1
	local save = defsave.save
	defsave.save = function() end
	for i=1, amount do
		local random_pokemon = pokedex.list[rnd.range(1, #pokedex.list)]
		add_pokemon(random_pokemon)
	end
	defsave.save = save
end


function M.add_all_pokemon()
	local save = defsave.save
	defsave.save = function() end
	for _, species in pairs(pokedex.list) do
		add_pokemon(species)
	end
	defsave.save = save
end

function M.load_backup()
	local success, file_path = diags.open()
	if success == diags.OKAY then
		backup.load_backup(file_path)
		M.loaded_backup = true
	end
end

function M.start_server()
	network.start_server(8190)
end

function M.find_and_connect_to_server()
	network.find_broadcast(function(ip, port)
		network.start_client(ip, port)
		network.client_send_message("Hello this is the client sending a message to the server")
	end)
end

return M