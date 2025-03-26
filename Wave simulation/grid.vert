#version 330 core

layout(location = 0) in vec3 aPos; 

uniform mat4 model;                   
uniform mat4 view;                    
uniform mat4 projection;     

uniform vec3 translation;
uniform float time;                   
uniform float wavelength;              
uniform float amplitude;              
uniform float speed;

out vec3 FragPos;  // Pass the position to the fragment shader
out vec3 Normal;   // Pass the normal to the fragment shader

// Function to compute height based on sum of exponentials of sines
float getHeight(float x, float z) {
    float frequency = 2.0 / wavelength;

    // Use exp() to create sharper peaks with Euler's number
    float waveHeightX = (exp(sin((x + z)  * frequency + time * speed)) * amplitude) +
                        (exp(sin((x + -z) * frequency * 0.2 + time * speed * 0.5)) * amplitude * 0.3) +
                        (exp(sin(-x  * frequency * 0.4 + time * speed * 1.0)) * amplitude * 0.5) +
                        (exp(sin(-x * frequency * 0.6 + time * speed * 0.8)) * amplitude * 1.0);

    float waveHeightZ = (exp(sin((z + x) * frequency / 2.5 + time * speed * 1.2)) * amplitude * 1.2)+
                        (exp(sin((z + -x) * frequency * 0.2 + time * speed * 0.5)) * amplitude * 0.4) +
                        (exp(sin((-z + x )* frequency * 0.5 + time * speed * 2.0)) * amplitude * 1.1) +
                        (exp(sin(-z * frequency * 0.6 + time * speed * 1.5)) * amplitude * 0.3);

    return waveHeightX + waveHeightZ;
}

void main()
{
    float delta = 0.01; // Small offset for numerical derivative

    vec3 translatedPos = aPos + translation; // Use a different name to avoid shadowing

    // Original position
    float height = getHeight(translatedPos.x, translatedPos.z);
    vec3 currentPos = vec3(translatedPos.x, height, translatedPos.z);

    // Sample positions slightly offset in the x and z directions for numerical normal approximation
    float heightX = getHeight(translatedPos.x + delta, translatedPos.z);  // Height at a small x-offset
    float heightZ = getHeight(translatedPos.x, translatedPos.z + delta);  // Height at a small z-offset

    // Calculate tangents along x and z directions
    vec3 tangentX = normalize(vec3(delta, heightX - height, 0.0));
    vec3 tangentZ = normalize(vec3(0.0, heightZ - height, delta));

    // Compute normal as the cross product of tangents
    Normal = normalize(cross(tangentZ, tangentX));

    // Pass the modified position and normal to the fragment shader
    FragPos = currentPos;
    gl_Position = projection * view * model * vec4(currentPos, 1.0);
}
