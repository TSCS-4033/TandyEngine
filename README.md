# TandyEngine
A game engine based on the Hazel engine intended for educational projects.

# Project 1
In project 1, we will configure a logger, an event system, and a text component. The engine entrypoint has already
been modified for this project to use the logger to report on the engine's initialization process. As such, the engine
is now breaking and must be fixed by implementing the logger. Once the engine has been fixed, the Sandbox application
includes a scene from a text-based adventure. It uses the engine's dialogue component and event system. These must both
be implemented to support the construction of a text-based adventure.
## logger
Game engines include loggers to provide information that can assist with debugging how the engine and its applications
perform. Typically loggers support a variety of "logging levels". These levels include trace, info, warn, error, and
fatal. trace is used for debugging. info is used for state-based information. warn is used unexpected behavior that
doesn't interfere with the application. error is used for non-breaking errors. fatal is used for breaking errors.
Logging levels are used so that loggers can be defined to accept some levels while ignoring others. This way, logging
code doesn't have to be conditioned within if-blocks or stripped using macros. Instead, the logger decides if a logging
call should be handled based on its chosen logging levels.

The spdlog third-party library has been included to support the implementation of a logger. A simple logger could be
easily built use console commands for printing and coloring text. However, a simple logger would not support printing
the variety of objects that we'll use later in the construction of the game engine. The spdlog library can be used to
log just about anything we create, which I hope will help you in debugging any errors that may arise in the future.

To build the logger:
- In Visual Studio, create a Log class (or create Log.cpp and Log.h files) in TandyEngine/src/Tandy
- Include Log.h in TandyEngine/src/Tandy.h so that the logger can be accessed from the client application
- In the logger (Log.cpp and Log.h), implement an <code>inline static std::shared_ptr\<spdlog::logger\>& GetLogger()</code>
function
- In the logger, implement a <code>void Init()</code> function to initialize and configure the spdlog logger
- (Optional) Define macros to simplify logging calls; you can simplify EntryPoint.h to use the defined macros
- Note: spdlog can be included at "spdlog/spdlog.h"
- Note: you must also include "spdlog/sinks/stdout_color_sinks.h" when configuring the spdlog logger
- Note: you can watch [theCherno - Logging](https://www.youtube.com/watch?v=dZr-53LAlOw) for an example
- Note: we are only using a single logger rather than separate core and client loggers since this isn't a production
level game engine
## text component
The text component will be simple. It only needs to format bold and italics and print messages to the screen.

To build the text component:
- In Visual Studio, create a Text class (or create Text.cpp and Text.h files) in TandyEngine/src/Tandy
- Include Text.h in TandyEngine/src/Tandy.h so that the Text component can be accessed from the client application
- In the Text class, implement a static function <code>void textf(std::string& msg)</code>
- The textf function should format all substrings between \<b> and \</b> as bold
- The textf function should format all substring between \<i> and \</i> as italicized
- The textf function should output the formatted string to the window