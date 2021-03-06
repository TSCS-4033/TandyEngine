#pragma once

#ifdef TS_PLATFORM_WINDOWS

	#include <stdio.h>

	extern Tandy::Application* Tandy::CreateApplication();

	int main(int argc, char** argv) {
		printf("Tandy Engine Start!\n");
		auto app = Tandy::CreateApplication();
		app->Run();
		delete app;
	}

#endif