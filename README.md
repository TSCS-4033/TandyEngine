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

# Project 1 - Layered Event System
For project 1, we will implement a layered event system. In a layered event system, the application is composed of several Z-layers, where each layer is a collection of components that implement event handlers. These are called Z-layers because they exist as layers along the Z-axis, where the Z-axis is the dimension that extends into the screen.

To implement a layered event system, we will implement several components, which include the Events, the Layer Stack, and the Window. The Events component is our type hierarchy of applicable events that can be handled by our engine and its applications. The principle purpose of the Events component is to define these applicable events, their properties, and group the events into usable categories. The Layer Stack manages an open stack of Layers, where each layer contains components that define event handlers, and the stack maintains a hierarchy of layers. The Layer Stack uses an open stack, so that new layers can be inserted anywhere into the layer stack. Finally, the Window will be a GLFW window that will serve as a canvas for generating events.

The Event Dispatcher is a common component included in many event systems. The Event Dispatcher is responsible for connecting applicable events to event handlers that can act upon the event. However, Event Dispatchers are largely unnecessary in many applications and are included primarily for convenience. As such, the Event Dispatcher has been left as an optional task.

If this sounds like a lot, the only right thing to do is to get started :)

## Events
The Events component defines the event types that our applications can handle and their characteristics. It also groups the events into categories, so that event handlers can handle categories of events rather than just particular events. Event categories are often defined using bit-flags. This is done so that an event handler can handle multiple categories. For example, we could set all Application Events to use the 0th bit and all Input Events to use the 1th bit. An event handler that sets a bit-filter of 3 would receive all Application Events and all Input Events, since the value 3 has the 0th and 1th bit set to 1 (turned on).
- [ ] Add an Events folder to TandyEngine/src/Tandy
- [ ] In the Events folder, add an Event header file (Event.h)
- [ ] In the Event.h header, within the Tandy namespace, define an <code>enum class EventType</code>, an <code>enum EventCategory</code>, and a <code>class Event</code>.
- The EventType should define enums for the following event types:
  - [ ] None
  - [ ] WindowClose
  - [ ] WindowResize
  - [ ] WindowFocus
  - [ ] WindowLostFocus
  - [ ] AppStart
  - [ ] AppUpdate
- Note: we'll handle input events later.
- The EventCategory should define enums for the following event categories:
  - [ ] None
  - [ ] EventCategoryApplication
- Note: the enums for the event categories should not share any bits in common.
- [ ] The Event class should be exported as a part of the TANDY\_API.
- It should have the following public API:
  - [ ] <code>virtual EventType GetEventType()</code>
  - [ ] <code>virtual int GetCategoryFlags()</code>
  - [ ] <code>virtual std::string ToString()</code>
- Next, define the header file ApplicationEvent.h in the Events folder
- In the ApplicationEvent.h header, define the following subclasses within the Tandy namespace:
    - [ ] <code>WindowCloseEvent</code>
    - [ ] <code>WindowResizeEvent(unsigned int width, unsigned int height)</code>
    - [ ] <code>WindowFocusEvent</code>
    - [ ] <code>WindowLostFocusEvent</code>
    - [ ] <code>AppStartEvent</code>
    - [ ] <code>AppUpdateEvent</code>
- Note: see [theCherno - Events](https://www.youtube.com/watch?v=xnopUoZbMEk) for an example

## (Optional) Event Dispatcher
The event dispatcher is responsible for sending triggered events to event handlers that can handle those events.
- [ ] In the Event.h header, define the <code>class EventDispatcher</code> within the Tandy namespace
- Note: the event dispatcher is not exported and is only used within the engine
- It should have the following public API:
    - [ ] <code>EventDispatcher(Event& event)</code>
    - [ ] <code>bool Dispatch(std::function<bool(T&)> func)</code>
    - Note: T is a generic type, which can be defined with <code>template\<typename T\></code>
- Note: see [theCherno - Events](https://www.youtube.com/watch?v=xnopUoZbMEk) for an example

## Layer Stack
The Layer Stack is responsible for ordering Layers into a hierarchy, where Layers include components that can handle events.
- [ ] In TandyEngine/src/Tandy, add a Layer class with corresponding .cpp and .h files
- [ ] In the Layer.h header, define the <code>class Layer</code> within the Tandy namespace
- [ ] It should be exported as part of the TANDY\_API
- It should define the following public API:
    - [ ] <code>virtual void OnAttach()</code>
    - [ ] <code>virtual void OnDetach()</code>
    - [ ] <code>virtual void OnUpdate()</code>
    - [ ] <code>virtual void OnEvent(Event& event)</code>
    - [ ] <code>virtual std::string ToString()</code>
- [ ] In TandyEngine/src/Tandy, add a LayerStack class with corresponding .cpp and .h files
- [ ] In the LayerStack.h header, define the <code>class LayerStack</code> within the Tandy namespace
- [ ] It should be exported as part of the TANDY\_API
- It should define the following public API:
    - [ ] <code>void PushLayer(Layer* layer)</code>
    - [ ] <code>void PopLayer(Layer* layer)</code>
    - [ ] <code>std::vector\<Layer*\>::iterator begin()</code>
    - [ ] <code>std::vector\<Layer*\>::iterator end()</code>
- Note: see [theCherno - Layers](https://www.youtube.com/watch?v=_Kj6BSfM6P4) for an example

## Window
The Window component is the final component that we will implement as part of the Event System. The Window is technically not a component of the event system. However, it provides a necessary canvas for generating events. A Window is a simple object that can be interacted with. All of our applicable events, except for AppStart, will be in some way associated with the Window object.
- We'll be using GLFW to create our Window object. I've already included GLFW into our build system.
- [ ] In TandyEngine/src/Tandy, add a Window.h header file.
- [ ] In the Window.h header file, within the Tandy namespace, define a <code>class Window</code>.
- [ ] It should be exported as part of the TANDY\_API
- [ ] It should define the following public API:
    - [ ] <code>virtual void OnUpdate();</code>
    - [ ] <code>virtual unsigned int GetWidth();</code>
    - [ ] <code>virtual unsigned int GetHeight();</code>
    - [ ] <code>virtual void SetEventCallback(const std::function\<void(Event&)\>& callback);</code>
    - [ ] <code>static Window* Create(std::string Title, unsigned int Width, unsigned int Height);</code>
- [ ] In TandyEngine/src/, add a Platform folder
- [ ] In TandyEngine/src/Platform/, add a Windows folder
- [ ] In TandyEngine/src/Platform/Windows/, add a new item WindowsWindow class with corresponding .h and .cpp files
- [ ] In the WindowsWindow.h header file, define <code>class WindowsWindow : public Window</code>
- [ ] Implement the WindowsWindow class
- Note: see [theCherno - Window Abstraction and GLFW](https://www.youtube.com/watch?v=88dmtleVywk) for an example

# Project 2 - Renderer
For project 2, we will be implementing a rendering system that supports GUI elements using the ImGui library.

## ImGui
The ImGui build system has already been integrated into the project to render ImGui elements in a GLFW window.
- [ ] Add an ImGui folder to TandyEngine/src/Tandy
- [ ] In the ImGui folder, add an ImGuiLayer class (with corresponding .cpp and .h files)
- [ ] It should extend the Layer class
- It should define the following public API:
    - [ ] <code>virtual void OnAttach();</code>
    - [ ] <code>virtual void OnDetach();</code>
    - [ ] <code>virtual void OnUpdate(float deltaTime);</code>
    - [ ] <code>virtual void OnEvent(Event& event);</code>
- [ ] Implement the ImGui layer with constructors and destructors
- Note: see [theCherno - ImGui](https://www.youtube.com/watch?v=st4lgNI6_F4) for an example
- Note: see [theCherno - ImGui Docking and Viewports](https://www.youtube.com/watch?v=lZuje-3iyVE) for an example
- Note: you don't need to worry about the OpenGL platform folder; I've already configured it for you
- Note: you don't need to worry about keymaps
- Note: you'll likely need to modify Application to return the current the singleton instance and the current window; see next

## Application
Modify the Application class to support the use of Layers and Overlays
- Add the following public API to Application
    - [ ] <code>void PushLayer(Layer* layer);</code>
    - [ ] <code>void PushOverlay(Layer* overlay);</code>
    - [ ] <code>Window& GetWindow();</code>
    - [ ] <code>ImGuiLayer* GetImGuiLayer();</code>
    - [ ] <code>static Application& GetApplication();</code>
- Implement the new API of Application
- Note: you'll need to modify the LayerStack API to support the new Application API

## LayerStack
Modify the LayerStack class to support the new API of Application
- Add the following public API to LayerStack
    - [ ] <code>void PushOverlay(Layer* overlay);</code>
    - [ ] <code>void PopOverlay(Layer* overlay);</code>

## Layer
Modify the Layer API so that the update method requires a delta time
- Modify the following public API on Layer
    - [ ] <code>void OnUpdate(float deltaTime);</code>

## Renderer
Implement a renderer to render your first triangle. This will require using a rendering context in OpneGL.
- Modify the WindowsWindow.cpp file to use a rendering context.
- Note: see [theCherno - Rendering Context](https://www.youtube.com/watch?v=YZKEjaCnsjU) for an example
- Note: see [theCherno - Our First Triangle!](https://www.youtube.com/watch?v=bwFYXo0VgCc) for an example

# Project 3 - Shaders and Vertex Buffers
For project 3, we will be implementing shaders and vertex buffers to support the creation of an orthographic camera.

## Shaders
Add folder TandyEngine/src/Tandy/Renderer. Create Shader.h and Shader.cpp files.
- Implement <code>class Shader</code> within the Tandy Namespace with the following public API:
    - [ ] <code>Shader(const std::string& vertexSrc, const std:string& fragmentSrc)</code>
    - [ ] <code>void Bind()</code>
    - [ ] <code>void Unbind()</code>
Follow the instructions in [theCherno - OpenGL Shaders](https://www.youtube.com/watch?v=QBCCHm_9HV) to complete the Shader class.

## Vertex Buffer
Create Buffer.h and Buffer.cpp files inside of Tandy/Renderer.
- Implement <code>class VertexBuffer</code> within the Tandy Namespace with the following public API:
    - [ ] <code>virtual void Bind()</code>
    - [ ] <code>virtual void Unbind()</code>
    - [ ] <code>static VertexBuffer* Create(float* vertices, uint32_t size)</code>
- Implement <code>class IndexBuffer</code> within the Tandy Namespace with the following public API:
    - [ ] <code>virtual void Bind()</code>
    - [ ] <code>virtual void Unbind()</code>
    - [ ] <code>static IndexBuffer* Create(uint32_t* indices, uint32_t size)</code>
- Create OpenGL implementations of both VertexBuffer and IndexBuffer. The implementations should be included in files OpenGLBuffer.h and OpenGLBuffer.cpp in Platform/OpenGL. Should be included within the Tandy Namespace.
Follow the instructions in [theCherno - Renderer API Abstraction](https://www.youtube.com/watch?v=BwCqRqqbB1Y) to complete this step.

## Vertex Buffer Layout
In Buffer.h and Buffer.cpp,
- Implement <code>class BufferLayout</code> with the following public API:
    - [ ] <code>std::vector\<BufferElement\>& GetElements()</code>
- Implement <code>struct BufferElement</code> with the following properties:
    - [ ] <code>std::string Name</code>
    - [ ] <code>ShaderDataType type</code>
    - [ ] <code>uint32_t Size</code>
    - [ ] <code>uint32_t Offset</code>
    - [ ] <code>BufferElement(const std::string& name, ShaderDataType type)</code>
- Implement <code>enum class ShaderDataType</code> with the following enums:
    - [ ] <code>None = 0</code>
    - [ ] <code>Float</code>
    - [ ] <code>Float2</code>
    - [ ] <code>Float3</code>
    - [ ] <code>Float4</code>
    - [ ] <code>Mat3</code>
    - [ ] <code>Mat4</code>
    - [ ] <code>Int</code>
    - [ ] <code>Int2</code>
    - [ ] <code>Int3</code>
    - [ ] <code>Int4</code>
    - [ ] <code>Bool</code>
- These should all be included within the Tandy Namespace.
Follow the instructions in [theCherno - Vertex Buffer Layouts](https://www.youtube.com/watch?v=jIJFM_pi6gQ) to complete this step.

## Vertex Array
Create VertexArray.h and VertexArray.cpp files inside of Tandy/Renderer.
- Implement <code>class VertexArray</code> with the following public API:
    - [ ] <code>void Bind()</code>
    - [ ] <code>void Unbind()</code>
    - [ ] <code>void AddVertexBuffer(const std::shared_ptr\<VertexBuffer\>& vertexBuffer)</code>
    - [ ] <code>void AddIndexBuffer(const std::shared_ptr\<IndexBuffer\>& vertexBuffer)</code>
    - [ ] <code>static VertexArray* Create()</code>
- Create OpenGL implementation of VertexArray within OpenGLVertexArray.h and OpenGLVertexArray.cpp files, which should be located in Platform/OpenGL. Should be included within the Tandy Namespace.
Follow the instructions in [theCherno - Vertex Arrays](https://www.youtube.com/watch?v=rkxrw8dNrvI) to complete this step.

Other videos that may be useful:
- [theCherno - Rendering Context](https://www.youtube.com/watch?v=YZKEjaCnsjU)
- [theCherno - Render Flow and Submission](https://www.youtube.com/watch?v=akxevYYWd9g)

# Project 4 - Cameras
For project 4, we will be implementing an orthographic camera.

## Orthographic Camera
Create OrthographicCamera.h and OrthographicCamera.cpp files inside of Tandy/Renderer.
- Implement <code>class OrthographicCamera</code> with the following public API:
    - [ ] <code>OrthographicCamera(float left, float right, float bottom, float top)</code>
    - [ ] <code>glm::vec3& GetPosition()</code>
    - [ ] <code>float GetRotation()</code>
    - [ ] <code>void SetPosition(const glm::vec3& position)</code>
    - [ ] <code>void SetRotation(float rotation)</code>
    - [ ] <code>glm::mat4& GetProjectionMatrix()</code>
    - [ ] <code>glm::mat4& GetViewMatrix()</code>
    - [ ] <code>glm::mat4& GetViewProjectionMatrix()</code>
Follow the instructions in [theCherno - Creating an Orthographic Camera](https://www.youtube.com/watch?v=NjKv-HWstxA) to complete this step.

## Input Events
Go back to the Events folder in Tandy. Add input events for mouse and keyboard inputs.
Follow the instructions in [theCherno - Event System](https://www.youtube.com/watch?v=xnopUoZbMEk) to complete this step.

Other videos that may be useful:
- [theCherno - Cameras and How They Work](https://www.youtube.com/watch?v=LfbqtmqxX04)