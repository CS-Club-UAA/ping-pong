workspace "ping-pong"
	configurations {"Release", "Debug"}

project "ping-pong"
	kind "ConsoleApp"
	language "C++"
    architecture "x86_64"
	targetdir "bin/%{cfg.buildcfg}"
	includedirs {"include/", "src/"}
	files {"src/main.cpp", "src/**.cpp", "src/**.c", "include/**.h", "include/**.hpp", "src/**.h", "src/**.hpp"}

    filter "action:vs*"
        includedirs {"./lib/windows/"}
        libdirs {"./lib/windows"}
        libdirs {"./lib/windows/libsfml"} -- just incase
        defines {"PING_PONG_WINDOWS"}

    filter {"action:gmake*", "toolset:gcc"}
        defines {"PING_PONG_LINUX"}
        includedirs {"./lib/linux/"}
        libdirs {"./lib/linux/"}
        libdirs {"./lib/linux/libsfml"} -- just incase
        buildoptions {"-Wall", "-Wextra", "-Werror"}
        
	filter {"configurations:Debug", "action:gmake2*", "toolset:gcc"}
        links {"sfml-system", "sfml-window", "sfml-graphics", "sfml-audio", "sfml-network"}
		defines {"DEBUG"}
		symbols "On"

    filter {"configurations:Release", "action:gmake2*", "toolset:gcc"}
        links {"sfml-system", "sfml-window", "sfml-graphics", "sfml-audio", "sfml-network"}
		defines {"NDEBUG"}
		optimize "On"

    filter {"configurations:Debug", "action:vs*"}
        links {"sfml-system-d", "sfml-window-d", "sfml-graphics-d", "sfml-audio-d", "sfml-network-d"}
        defines {"DEBUG"}
        symbols "On"

    filter {"configurations:Release", "action:vs*"}
        links {"sfml-system", "sfml-window", "sfml-graphics", "sfml-audio", "sfml-network"}
		defines {"NDEBUG"}
		optimize "On"