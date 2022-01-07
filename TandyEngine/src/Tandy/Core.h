#pragma once

#ifdef TS_PLATFORM_WINDOWS
	#ifdef TS_BUILD_DLL
		#define TANDY_API __declspec(dllexport)
	#else
		#define TANDY_API __declspec(dllimport)
	#endif
#else
	#error TandyEngine only supports Windows!
#endif