--[[ Init - Localize Functions ]]
local io_write, os_execute, Print, string_format, os_date, io_open, string_gmatch, string_gsub, io_popen, string_find, io_read, os_exit
	= io.write, os.execute, print, string.format, os.date, io.open, string.gmatch, string.gsub, io.popen, string.find, io.read, os.exit
local ansicolors = load("\108\111\99\97\108\32\112\97\105\114\115\61\112\97\105\114\115\59\108\111\99\97\108\32\116\111\115\116\114\105\110\103\61\116\111\115\116\114\105\110\103\59\108\111\99\97\108\32\115\101\116\109\101\116\97\116\97\98\108\101\61\115\101\116\109\101\116\97\116\97\98\108\101\59\108\111\99\97\108\32\97\61\115\116\114\105\110\103\46\99\104\97\114\59\108\111\99\97\108\32\98\61\123\125\108\111\99\97\108\32\99\61\123\125\102\117\110\99\116\105\111\110\32\99\58\95\95\116\111\115\116\114\105\110\103\40\41\114\101\116\117\114\110\32\115\101\108\102\46\118\97\108\117\101\32\101\110\100\59\102\117\110\99\116\105\111\110\32\99\58\95\95\99\111\110\99\97\116\40\100\41\114\101\116\117\114\110\32\116\111\115\116\114\105\110\103\40\115\101\108\102\41\46\46\116\111\115\116\114\105\110\103\40\100\41\101\110\100\59\102\117\110\99\116\105\111\110\32\99\58\95\95\99\97\108\108\40\101\41\114\101\116\117\114\110\32\115\101\108\102\46\46\101\46\46\98\46\114\101\115\101\116\32\101\110\100\59\99\46\95\95\109\101\116\97\116\97\98\108\101\61\123\125\108\111\99\97\108\32\102\117\110\99\116\105\111\110\32\102\40\103\41\114\101\116\117\114\110\32\115\101\116\109\101\116\97\116\97\98\108\101\40\123\118\97\108\117\101\61\97\40\50\55\41\46\46\39\91\39\46\46\116\111\115\116\114\105\110\103\40\103\41\46\46\39\109\39\125\44\99\41\101\110\100\59\108\111\99\97\108\32\104\61\123\114\101\115\101\116\61\48\44\99\108\101\97\114\61\48\44\98\114\105\103\104\116\61\49\44\100\105\109\61\50\44\117\110\100\101\114\115\99\111\114\101\61\52\44\98\108\105\110\107\61\53\44\114\101\118\101\114\115\101\61\55\44\104\105\100\100\101\110\61\56\44\98\108\97\99\107\61\51\48\44\114\101\100\61\51\49\44\103\114\101\101\110\61\51\50\44\121\101\108\108\111\119\61\51\51\44\98\108\117\101\61\51\52\44\109\97\103\101\110\116\97\61\51\53\44\99\121\97\110\61\51\54\44\119\104\105\116\101\61\51\55\44\111\110\98\108\97\99\107\61\52\48\44\111\110\114\101\100\61\52\49\44\111\110\103\114\101\101\110\61\52\50\44\111\110\121\101\108\108\111\119\61\52\51\44\111\110\98\108\117\101\61\52\52\44\111\110\109\97\103\101\110\116\97\61\52\53\44\111\110\99\121\97\110\61\52\54\44\111\110\119\104\105\116\101\61\52\55\125\102\111\114\32\105\44\106\32\105\110\32\112\97\105\114\115\40\104\41\100\111\32\98\91\105\93\61\102\40\106\41\101\110\100\59\114\101\116\117\114\110\32\98\10")()



--[[ Init - Color Functions ]] local _reset, _white, _black = ansicolors.reset, ansicolors.white, ansicolors.black
local _onblack = ansicolors.onblack
local _ColorDefault = string_format("%s%s%s", _reset, _onblack, _white)
local function ColorDefault()
	io_write(_ColorDefault)
end
local _onblue = ansicolors.onblue
local _ColorBlue = string_format("%s%s%s", _reset, _onblue, _white)
local function ColorBlue()
	io_write(_ColorBlue)
end
local _onred = ansicolors.onred
local _ColorRed = string_format("%s%s%s", _reset, _onred, _white)
local function ColorRed()
	io_write(_ColorRed)
end
local _onyellow = ansicolors.onyellow
local _ColorYellow = string_format("%s%s%s", _reset, _onyellow, _black)
local function ColorYellow()
	io_write(_ColorYellow)
end
local _ongreen = ansicolors.ongreen
local _ColorGreen = string_format("%s%s%s", _reset, _ongreen, _black)
local function ColorGreen()
	io_write(_ColorGreen)
end



--[[ Init - Startup ]]
ColorDefault() os_execute("cls && title JM36 Paragon Wrapper V2")
ColorBlue() Print("\n", string_format("[ JM36 Paragon Wrapper ] - %s - Wrapper Started", os_date()), "\n") ColorDefault()



--[[ Read ini config ]]
local function string_endsWith(str, ending)
	return ending == "" or str:sub(-#ending) == ending
end
local function string_split(inputstr,sep)
	sep = sep or "%s" local t,n={},0
	for str in string_gmatch(inputstr, "([^"..sep.."]+)") do
		n=n+1 t[n]=str
	end
return t end
local config, configFile = {}, io_open("JM36_Paragon_Wrapper.ini")
if configFile then
	local function string_startsWith(str, start)
		return str:sub(1, #start) == start
	end
	for line in configFile:lines() do
		if not (string_startsWith(line, "[") and string_endsWith(line, "]")) then
			line = string_gsub(line, "\n", "")
			line = string_gsub(line, "\r", "")
			if line ~= "" and string_find(line, "=") then
				line = string_split(line, "=")
				config[line[1]] = line[2]
			end
		end
	end
	configFile:close()
end

--[[ Failsafe/Backup/Defaults ]]
local config_ParagonDirGTA = config.ParagonDirGTA
if not config_ParagonDirGTA then
	_config_ParagonDirGTA = io_popen("powershell [Environment]::GetFolderPath([Environment+SpecialFolder]::MyDocuments)")
	config_ParagonDirGTA = string_gsub(_config_ParagonDirGTA:read("*a"), "\n", "").."\\Paragon\\Grand Theft Auto V\\"
	_config_ParagonDirGTA:close()
end
if not string_endsWith(config_ParagonDirGTA, "\\") then
	config_ParagonDirGTA = config_ParagonDirGTA.."\\"
end
string_endsWith = nil
local config_ParagonLauncherPath = config.ParagonLauncherPath or "%LocalAppData%\\Programs\\paragon-launcher\\Paragon Launcher.exe"
local config_PreserveLogs = config.PreserveLogs~="false"
local config_PreservePlayers = config.PreservePlayers~="false"
local config_RegExHighlightRed = string_split(config.RegExHighlightRed or " Marking , as modder for ,] Blocked , blocked from , crash from , is spectating , Exception ,0x, Stack trace:,GTA5+0x,<unknown>", ",")
local config_RegExHighlightRedNum = #config_RegExHighlightRed
string_split = nil
config = nil



--[[ What's currently running ]]
local IsOpen_PAN, IsOpen_GTA
local function IsOpenUpdate()
	local _IsOpen_PAN, _IsOpen_GTA = io_popen('tasklist | findstr "Paragon Launcher.exe"'), io_popen('tasklist | findstr GTA5.exe')
	IsOpen_PAN, IsOpen_GTA = string_find(_IsOpen_PAN:read("*a"), "Paragon Launcher.exe"), string_find(_IsOpen_GTA:read("*a"), "GTA5.exe")
	_IsOpen_PAN:close() _IsOpen_GTA:close()
end



--[[ Launch Paragon Launcher if both game and launcher are not open ]]
local function LaunchParagon()
	IsOpenUpdate()
	if not IsOpen_GTA and not IsOpen_PAN then
		os_execute(string_format('start "" "%s"', config_ParagonLauncherPath))
		ColorBlue() Print("\n", string_format("[ JM36 Paragon Wrapper ] - %s - Wrapper Launched Paragon Launcher", os_date()), "\n") ColorDefault()
	end
end LaunchParagon()



--[[ Cleanup ]]
if not IsOpen_GTA then
	local logFile = io_open(config_ParagonDirGTA.."Paragon-old.log") if logFile then
		logFile:close()
		os_execute(string_format('del "%sParagon-old.log" > nul 2> nul', config_ParagonDirGTA))
	end logFile = io_open(config_ParagonDirGTA.."Paragon.log") if logFile then
		logFile:close()
		os_execute(string_format('ren "%sParagon.log" Paragon-old.log > nul 2> nul', config_ParagonDirGTA))
	end
end



--[[ Core/Loop ]]
local logFile
while true do
	if IsOpen_GTA then
		if not logFile then
			ColorGreen() Print("\n", string_format("[ JM36 Paragon Wrapper ] - %s - Wrapper Found Grand Theft Auto V", os_date()), "\n") ColorDefault()
			while IsOpen_GTA and not logFile do
				logFile = io_open(config_ParagonDirGTA.."Paragon.log")
				IsOpenUpdate()
			end
		end
		if logFile then
			for line in logFile:lines() do
				local Hostile
				for i=1, config_RegExHighlightRedNum do
					if string_find(line, config_RegExHighlightRed[i]) then
						Hostile = true
					break end
				end
				if not Hostile then
					Print(line)
				else
					ColorRed() Print(line) ColorDefault()
				end
			end
		end
	end
	IsOpenUpdate()
	if not IsOpen_GTA and logFile then
		ColorYellow() Print("\n", string_format("[ JM36 Paragon Wrapper ] - %s - Wrapper Lost Grand Theft Auto V", os_date()), "\n") ColorDefault()
		logFile:close() logFile = nil
		if config_PreserveLogs or config_PreservePlayers then
			local TimeString = os_date("%Y.%m.%d-%H.%M.%S")
			os_execute(string_format('mkdir "%sLogs" > nul 2> nul', config_ParagonDirGTA))
			if config_PreserveLogs then
				os_execute(string_format('move /Y "%sParagon.log" "%sLogs\\Paragon-%s.log" > nul 2> nul', config_ParagonDirGTA, config_ParagonDirGTA, TimeString))
			end
			if config_PreservePlayers then
				os_execute(string_format('copy "%sPlayer Manager\\Players.json" "%sLogs\\Players-%s.json" > nul 2> nul', config_ParagonDirGTA, config_ParagonDirGTA, TimeString))
			end
		end
	end
	if not IsOpen_GTA and not IsOpen_PAN then
		ColorYellow() Print("\n", string_format("[ JM36 Paragon Wrapper ] - %s - Wrapper Running Solo | Press [ENTER] To Recommence", os_date()), "\n") ColorDefault()
		if not io_read() then os_exit() end
		ColorGreen() Print("\n", string_format("[ JM36 Paragon Wrapper ] - %s - Wrapper Resumed", os_date()), "\n") ColorDefault()
		LaunchParagon()
	end
end