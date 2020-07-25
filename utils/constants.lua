local M = {}

M.ABILITY_LIST = {"STR", "DEX", "CON", "INT", "WIS", "CHA"}

M.SR_LIST = {"1/8", "1/4", "1/2", "1", "2", "3", "4", "5", "6", "7","8", "9", "10", "11", "12", "13", "14", "15"}
M.SR_TO_NUMBER = {["1/8"]=0.125, ["1/4"]=0.25, ["1/2"]=0.5, ["1"]=1, ["2"]=2, ["3"]=3, ["4"]=4, ["5"]=5, ["6"]=6, ["7"]=7,["8"]=8, ["9"]=9, ["10"]=10, ["11"]=11, ["12"]=12, ["13"]=13, ["14"]=14, ["15"]=15}


M.NUMBER_TO_SR = {[0.125]="1/8", [0.25]="1/4", [0.5]="1/2"}

-- Set a metatable that returns a string of the input number if it is missing
setmetatable(M.NUMBER_TO_SR, {
	__index = function(t, i)
		if type(i) == "number" then
			return tostring(i)
		else
			return nil
		end
	end
})





return M