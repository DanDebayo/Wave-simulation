# Wave Simulation with OpenGL

This is a simulation implemented in C++ using OpenGL. The program renders a dynamic water surface with animated waves.

## Features
- **Grid-Based Water Mesh** – A 300x300 grid represents the water surface.
- **Wave Animation** – Uses sine wave functions in the vertex shader to simulate realistic water motion.
- **Phong Lighting Model** – Enhances the water surface with realistic reflections and shading.
- **Skybox Integration** – Adds environmental reflections for a more immersive experience.
- **Cubemap Reflections & Refractions** – Simulates realistic light interactions with the water.

## Getting Started

### Prerequisites
- **C++ Compiler** – Ensure you have a compiler supporting C++11 or later.
- **OpenGL (3.3+)** – Required for rendering.
- **GLFW** – For handling window creation and input.
- **GLAD** – For managing OpenGL function pointers.
- **GLM** – For mathematical operations.
- **STB Image** – For texture loading.

### Cloning the Repository
To get started, clone this repository to your local machine:
```bash
git clone https://github.com/DanDebayo/Wave-Simulation.git
cd Wave-Simulation
```

### Building the Project
Compile the project using CMake or manually with `g++`.

### Running on Linux

If you are using Linux, ensure you have installed the required dependencies:
```bash
sudo apt-get update
sudo apt-get install build-essential cmake libglfw3-dev libglm-dev libglew-dev libstb-dev
```
To compile and run the project:
```bash
g++ -std=c++11 main.cpp -o WaveSimulation -lglfw -lGL -ldl -lX11 -pthread -lXrandr -lXi -lXxf86vm -lXinerama -lXcursor
./WaveSimulation
```
### Run the program
A file will be made to run without compiling wave-simulation.exe

## Controls
- `ESC` – Exit the application

## How It Works
1. **Grid Generation** – The water surface is constructed as a 300x300 vertex grid.
2. **Wave Motion** – The vertex shader dynamically modifies vertex heights using sine wave functions.
3. **Lighting & Shading** – Implements the Phong lighting model for realism.
4. **Reflections & Refractions** – Utilizes a cubemap texture to simulate water reflections.

## File Structure
- `main.cpp` – Initializes OpenGL, sets up the grid, shaders, and rendering loop.
- `grid.vert` – Vertex shader for the wave simulation.
- `grid.frag` – Fragment shader for water shading and lighting.
- `Shader_m.h` – Manages shader programs.
- `Camera.h` – Handles camera.
- `stb_image.h` – Loads textures for the skybox and other assets.

## Future Enhancements
- Implement Perlin noise for more natural wave motion.
- Add screen-space reflections (SSR) for enhanced realism.
- Optimize performance using tessellation shaders.
- Add more realism to the scene like moving clouds

### Note
As a first public project I am happy with what i have made and I would want to improve on it and try out more things

