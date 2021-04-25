--[[ Init - Localize Functions ]]
local os_execute, print, string_format, os_date, io_open, string_gmatch, string_gsub, io_popen, string_find, io_read, os_exit
	= os.execute, print, string.format, os.date, io.open, string.gmatch, string.gsub, io.popen, string.find, io.read, os.exit



--[[ Init - Startup ]]
os_execute("cls && title JM36 Paragon Wrapper")
print("\n", string_format("[ JM36 Paragon Wrapper ] - %s - Wrapper Started", os_date()), "\n")



--[[ Read ini config ]]
local function string_endsWith(str, ending)
	return ending == "" or str:sub(-#ending) == ending
end
local config, configFile = {}, io_open("JM36_Paragon_Wrapper.ini")
if configFile then
	local function string_startsWith(str, start)
		return str:sub(1, #start) == start
	end
	local function string_split(inputstr,sep)
		sep = sep or "%s" local t,n={},0
		for str in string_gmatch(inputstr, "([^"..sep.."]+)") do
			n=n+1 t[n]=str
		end
		return t
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
		print("\n", string_format("[ JM36 Paragon Wrapper ] - %s - Wrapper Launched Paragon Launcher", os_date()), "\n")
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
			print("\n", string_format("[ JM36 Paragon Wrapper ] - %s - Wrapper Found Grand Theft Auto V", os_date()), "\n")
			while IsOpen_GTA and not logFile do
				logFile = io_open(config_ParagonDirGTA.."Paragon.log")
				IsOpenUpdate()
			end
		end
		if logFile then
			for line in logFile:lines() do
				print(line)
			end
		end
	end
	IsOpenUpdate()
	if not IsOpen_GTA and logFile then
		print("\n", string_format("[ JM36 Paragon Wrapper ] - %s - Wrapper Lost Grand Theft Auto V", os_date()), "\n")
		logFile:close() logFile = nil
		os_execute(string_format('mkdir "%sLogs" > nul 2> nul', config_ParagonDirGTA))
		os_execute(string_format('move /Y "%sParagon.log" "%sLogs\\Paragon-%s.log" > nul 2> nul', config_ParagonDirGTA, config_ParagonDirGTA, os_date("%Y.%m.%d-%H.%M.%S")))
	end
	if not IsOpen_GTA and not IsOpen_PAN then
		print("\n", string_format("[ JM36 Paragon Wrapper ] - %s - Wrapper Running Solo | Press [ENTER] To Recommence", os_date()), "\n")
		if not io_read() then os_exit() end
		print("\n", string_format("[ JM36 Paragon Wrapper ] - %s - Wrapper Resumed", os_date()), "\n")
		LaunchParagon()
	end
end