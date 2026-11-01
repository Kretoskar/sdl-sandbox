workspace "SDL-Sandbox"
    architecture "x64"
    configurations { "Debug", "Release" }
    startproject "App"

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "Core"
    kind "StaticLib"
    language "C++"
    cppdialect "C++20"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files 
	{
        "src/Core/src/**.h",
        "src/Core/src/**.hpp",
        "src/Core/src/**.cpp",
		"src/Core/include/**.h",
        "src/Core/include/**.hpp",
    }

    includedirs 
	{
        "src/Core/include",
    }

    filter "system:windows"
        systemversion "latest"

    filter "configurations:Debug"
		defines "DEBUG"
        symbols "On"
        runtime "Debug"

    filter "configurations:Release"
		defines "RELEASE"
        optimize "On"
        runtime "Release"
		
project "Engine"
    kind "StaticLib"
    language "C++"
    cppdialect "C++20"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files 
	{
        "src/Engine/src/**.h",
        "src/Engine/src/**.hpp",
        "src/Engine/src/**.cpp",
		"src/Engine/include/Engine/**.h",
        "src/Engine/include/Engine/**.hpp",
    }

    includedirs 
	{
		"src/Core/include/",
		"src/Engine/include",
        "vendor/SDL3/include",
        "vendor/SDL3_image/include"
    }

    libdirs 
	{
        "vendor/SDL3/lib/x64",
        "vendor/SDL3_image/lib/x64"
    }
	
	dependson { "Core" }

    filter "system:windows"
        systemversion "latest"

    filter "configurations:Debug"
		defines "DEBUG"
        symbols "On"
        runtime "Debug"

    filter "configurations:Release"
		defines "RELEASE"
        optimize "On"
        runtime "Release"

project "Game"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++20"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files 
	{
        "src/Game/src/**.h",
        "src/Game/src/**.hpp",
        "src/Game/src/**.cpp",
		"src/Game/include/**.h",
        "src/Game/include/**.hpp",
    }

    includedirs 
	{
        "vendor/SDL3/include",
        "vendor/SDL3_image/include",
		"src/Core/include",
		"src/Engine/include",
		"src/Game/include",
    }

    libdirs 
	{
        "vendor/SDL3/lib/x64",
        "vendor/SDL3_image/lib/x64"
    }

    links 
	{
        "SDL3",
        "SDL3_image",
		"Core",
		"Engine"
    }
	
	dependson { "Core", "Engine" }
	
	defines 
	{
		'ASSETS_DIR="%{wks.location}/assets"'
	}

    postbuildcommands 
	{
         '{COPYFILE} "%{wks.location}/vendor/SDL3/lib/x64/SDL3.dll" "%{cfg.targetdir}"',
         '{COPYFILE} "%{wks.location}/vendor/SDL3_image/lib/x64/SDL3_image.dll" "%{cfg.targetdir}"',
    }

    filter "system:windows"
        systemversion "latest"

    filter "configurations:Debug"
		defines "DEBUG"
        symbols "On"
        runtime "Debug"

    filter "configurations:Release"
		defines "RELEASE"
        optimize "On"
        runtime "Release"