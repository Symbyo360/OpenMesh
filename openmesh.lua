project "openmesh"
	language "C++"
	kind "SharedLib"
	targetdir (bin_path .. "/%{cfg.platform}/%{cfg.buildcfg}/")
	location  (build_path .. "/openmesh/")

	files
	{
		"src/OpenMesh/Core/Geometry/**.hh",
		"src/OpenMesh/Core/Geometry/**.inl",
		"src/OpenMesh/Core/Geometry/**.cc",

		"src/OpenMesh/Core/IO/**.hh",
		"src/OpenMesh/Core/IO/**.inl",
		"src/OpenMesh/Core/IO/**.cc",

		"src/OpenMesh/Core/Mesh/**.hh",
		"src/OpenMesh/Core/Mesh/**.inl",
		"src/OpenMesh/Core/Mesh/**.cc",

		"src/OpenMesh/Core/System/**.hh",
		"src/OpenMesh/Core/System/**.inl",
		"src/OpenMesh/Core/System/**.cc",

		"src/OpenMesh/Core/Utils/**.hh",
		"src/OpenMesh/Core/Utils/**.inl",
		"src/OpenMesh/Core/Utils/**.cc",

		"src/OpenMesh/Tools/Decimater/**.hh",
		"src/OpenMesh/Tools/Decimater/**.inl",
		"src/OpenMesh/Tools/Decimater/**.cc",

		"src/OpenMesh/Tools/Dualizer/**.hh",
		"src/OpenMesh/Tools/Dualizer/**.inl",
		"src/OpenMesh/Tools/Dualizer/**.cc",

		"src/OpenMesh/Tools/Smoother/**.hh",
		"src/OpenMesh/Tools/Smoother/**.inl",
		"src/OpenMesh/Tools/Smoother/**.cc",

		"src/OpenMesh/Tools/Subdivider/**.hh",
		"src/OpenMesh/Tools/Subdivider/**.inl",
		"src/OpenMesh/Tools/Subdivider/**.cc"
	}

	removefiles {"src/OpenMesh/Tools/**T.cc"}

	includedirs
	{
		"src/"
	}

	--language configuration
	exceptionhandling "ON"
	rtti "ON"
	warnings "Extra"
	cppdialect "c++14"


	--linux configuration
	filter "system:linux"
		linkoptions {"-pthread"}

	filter { "system:linux", "configurations:debug" }
		linkoptions {"-rdynamic"}


	--windows configuration
	filter "system:windows"
		defines { "WIN32" }
		if os.getversion().majorversion == 10.0 then
			systemversion(win10_sdk_version())
		end
		
	filter { "system:windows", "configurations:debug" }
		links {"dbghelp"}


	--os agnostic configuration
	filter "configurations:debug"
		targetsuffix "d"
		defines {"DEBUG", "BUILDOPENMESHDLL", "OPENMESHDLL", "_USE_MATH_DEFINES"}
		symbols "On"

	filter "configurations:release"
		defines {"NDEBUG", "BUILDOPENMESHDLL", "OPENMESHDLL", "_USE_MATH_DEFINES"}
		optimize "On"

	filter "platforms:x86"
		architecture "x32"

	filter "platforms:x64"
		architecture "x64"