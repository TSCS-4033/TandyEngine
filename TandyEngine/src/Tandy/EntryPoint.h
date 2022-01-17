#pragma once

#ifdef TS_PLATFORM_WINDOWS

	#include <stdio.h>

	extern Tandy::Application* Tandy::CreateApplication();

	int main(int argc, char** argv) {
		// initialize logger
		Tandy::Log::Init();
		// TODO: (optional) can be rewritten to use a macro instead
		Tandy::Log::GetLogger()->info("Tandy Engine Start!");
		// start app
		auto app = Tandy::CreateApplication();
		// trigger app start event
		app->OnEvent();
		app->Run();
		delete app;
	}

#endif