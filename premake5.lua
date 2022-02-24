workspace "TandyEngine"
    architecture "x64"

    configurations {
        "Debug",
        "Release",
        "Dist"
    }

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include directories for 3rd party libraries
IncludeDir = {}
IncludeDir["GLFW"] = "TandyEngine/vendor/GLFW/include"
IncludeDir["Glad"] = "TandyEngine/vendor/Glad/include"
IncludeDir["ImGui"] = "TandyEngine/vendor/ImGui/"

include "TandyEngine/vendor/GLFW"
include "TandyEngine/vendor/Glad"
include "TandyEngine/vendor/ImGui"

project "TandyEngine"
    location "TandyEngine"
    kind "SharedLib"
    language "C++"
    staticruntime "Off"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

    includedirs {
        "%{prj.name}/src",
        "%{prj.name}/vendor/spdlog/include",
        "%{IncludeDir.GLFW}",
        "%{IncludeDir.Glad}",
        "%{IncludeDir.ImGui}"
    }

    links {
        "GLFW",
        "Glad",
        "ImGui",
        "opengl32.lib"
    }

    filter "system:Windows"
        cppdialect "C++17"
        systemversion "latest"

        defines {
            "TS_PLATFORM_WINDOWS",
            "TS_BUILD_DLL"
        }

        postbuildcommands {
            ("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
        }

    filter "configurations:Debug"
        defines "TS_DEBUG"
        symbols "On"

    filter "configurations:Release"
        defines "TS_RELEASE"
        optimize "On"

    filter "configurations:Dist"
        defines "TS_DIST"
        optimize "On"

project "Sandbox"
    location "Sandbox"
    kind "ConsoleApp"
    language "C++"
    staticruntime "Off"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

    includedirs {
        "TandyEngine/vendor/spdlog/include",
        "TandyEngine/src"
    }

    links {
        "TandyEngine"
    }

    filter "system:Windows"
        cppdialect "C++17"
        systemversion "latest"

        defines {
            "TS_PLATFORM_WINDOWS"
        }

    filter "configurations:Debug"
        defines "TS_DEBUG"
        symbols "On"

    filter "configurations:Release"
        defines "TS_RELEASE"
        optimize "On"

    filter "configurations:Dist"
        defines "TS_DIST"
        optimize "On"
