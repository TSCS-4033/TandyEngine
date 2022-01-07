#include <Tandy.h>

class Sandbox : public Tandy::Application {
	public:
		Sandbox() {}
		~Sandbox() {}
};

int main() {
	Sandbox* sandbox = new Sandbox();
	sandbox->Run();
	delete sandbox;
}