#include <Tandy.h>

class Sandbox : public Tandy::Application {
	public:
		Sandbox() {}
		~Sandbox() {}
};

Tandy::Application* Tandy::CreateApplication() {
	return new Sandbox();
}