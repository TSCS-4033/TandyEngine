# TandyEngine
A game engine based on the Hazel engine intended for educational projects.

# Project 0 - Getting Started
To get started, we will configure a logger, an event handler, and a text component. The engine entrypoint has already been modified for this project to use the logger to report on the engine's initialization process. As such, the engine is now breaking and must be fixed by implementing the aforementioned components.

## logger
Game engines include loggers to provide information that can assist with debugging the engine and its applications. Typically loggers support a variety of *logging levels*. These levels include **trace**, **info**, **warn**, **error**, and **fatal**. *trace* is used for debugging. *info* is used for state-based information. *warn* is used for unexpected behavior that doesn't interfere with the application. *error* is used for non-breaking errors. *fatal* is used for breaking errors. Logging levels are used so that loggers can be defined to accept some levels while ignoring others. This way, logging code doesn't have to be conditioned within if-blocks or stripped using macros. Instead, the logger decides if a logging call should be handled based on its chosen logging levels.

The **spdlog** third-party library has been included to support the implementation of a logger. A simple logger could be easily built use console commands for printing and coloring text. However, a simple logger would not support printing the variety of objects that we'll use later in the construction of the game engine. The spdlog library can be used to log just about anything we create, which I hope will help you in debugging any errors that may arise in the future.

**To build the logger:**
- [ ] In Visual Studio, create <code>class Log</code> (or create Log.cpp and Log.h files) in TandyEngine/src/Tandy
- [ ] In Log.h, encapsulate <code>class Log</code> within the <code>namespace Tandy</code>
- [ ] In Log.h, export <code>class Log</code> as part of the <code>TANDY_API</code>
    - Note: use the defined core macro as so: <code>class TANDY_API Log</code>
- In Log.h and Log.cpp, declare and implement the following **public** functions
    - [ ] <code>void Init()</code>
    - [ ] <code>inline static std::shared_ptr\<spdlog::logger\>& GetLogger()</code>
- [ ] (Optional) In Log.h, define macros to simplify logging calls
    - Note: macros should be named as so: <code>TS_TRACE</code>, etc.
    - [ ] (Optional) You can simplify EntryPoint.h to use the defined macros
- [ ] In Tandy.h, include Log.h so that the logger can be accessed from the client application
- Note: spdlog can be included at "spdlog/spdlog.h"
- Note: you must also include "spdlog/sinks/stdout_color_sinks.h" when configuring the spdlog logger
- Note: you can watch [theCherno - Logging](https://www.youtube.com/watch?v=dZr-53LAlOw) for an example
- Note: we are only using a single logger rather than separate core and client loggers since this isn't a production level game engine

## event handler
An event system is one of the most critical components of a game engine. Many system level applications are event-driven applications which rely on an event system to determine when and what code should be executed. The when is determined through the creation of an event and the what is handled by event handlers. We will use event handlers within our client application to capture events such as application start, application updates, mouse actions, keyboard actions, changes to the windows, etc.
To get started on the event system, we are going to define our first event handler for application start. Event handlers will be defined on the client application. When we implement an event system in project 1, we'll have the game engine dispatch events to the client application using a layered approach. For now, we'll just have the game engine directly call the application's event handlers.

**To build the event handler:**
- In Tandy/Application.h and Tandy/Application.cpp, define and implement the following **public** function:
    - [ ] <code>virtual void OnEvent()</code>
- Note: it can have an empty definition in Tandy/Application.cpp (<code>{}</code>)
- Note: we'll just use this for application start events for now

## text component
A basic text component was not included as part of the original Hazel design because Hazel is intended for 2D and 3D applications. The text component that we will define here is intended to support console applications, such as text-based adventures. This inclusion is intended to be a fun exercise to familiarize you with string IO.

**To build the text component:**
- [ ] In Visual Studio, create <code>class Text</code> (or create Text.cpp and Text.h files) in TandyEngine/src/Tandy
- [ ] In Text.h, encapsulate <code>class Text</code> within the <code>namespace Tandy</code>
- [ ] In Text.h, export <code>class Text</code> as part of the <code>TANDY_API</code>
- In Text.h and Text.cpp, declare and implement the following **public** function
    - [ ] <code>static void textf(std::string& msg)</code>
- The stated function should do three things:
    - [ ] Format all substrings in msg between \<b> and \</b> to be bold after stripping away the markup
    - [ ] Format all substrings in msg between \<u> and \</u> to be underlined after stripping away the markup
    - [ ] Output the message
    - Note: it does need to handle standard formatting characters, such as <code>%.2f</code> or <code>%d</code> as those can already be handled for string::format
- [ ] In Tandy.h, include Text.h so that the text component can be accessed from the client application