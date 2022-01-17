#include <Tandy.h>

class Sandbox : public Tandy::Application {
	public:
		Sandbox() {}
		~Sandbox() {}

		void Sandbox::OnEvent() override {
			Tandy::Log::GetLogger()->info("Application Start!");
			Tandy::Log::GetLogger()->warn("Incoming Copyright Infringment!!!");
			Tandy::Text::textf(std::string("It is a period of civil wars in the galaxy. A brave alliance of underground freedom fighters has challenged the tyranny and oppression of the awesome <b>GALACTIC EMPIRE</b>.\n \n"));
			Tandy::Text::textf(std::string("Striking from a fortress hidden among the billion stars of the galaxy, rebel spaceships have won their first victory in a battle with the powerful Imperial Starfleet. The <b>EMPIRE</b> fears that another defeat could bring a thousand more solar systems into the rebellion, and Imperial control over the galaxy would be <u>lost forever</u>.\n \n"));
			Tandy::Text::textf(std::string("To crush the rebellion once and for all, the <b>EMPIRE</b> is constructing <u>a sinister new battle station</u>. Powerful enough to destroy an entire planet, its completion spells certain doom for the champions of freedom.\n \n"));
		}
};



Tandy::Application* Tandy::CreateApplication() {
	return new Sandbox();
}