#version 330 core

// Inputs from the vertex shader
in vec3 FragPos;  
in vec3 Normal;

// Light and material properties
#define MAX_LIGHTS 7
uniform vec3 lightPos[MAX_LIGHTS];   // Array of light positions
uniform vec3 lightColor[MAX_LIGHTS]; // Array of light colors
uniform int numLights;              // Number of active lights
uniform vec3 viewPos;               // Camera position
uniform vec3 objectColor;

// Reflection and refraction
uniform samplerCube skybox;         // Environment map for reflections
uniform float reflectivity;         // Reflection strength (0 = none, 1 = full mirror)
uniform float refractivity;         // Refraction strength
uniform float refractiveIndex;      // Index of refraction (e.g., 1.33 for water)

out vec4 FragColor;

void main()
{
    // Normalize the normal vector
    vec3 norm = normalize(Normal);

    // View direction
    vec3 viewDir = normalize(viewPos - FragPos);

    // Accumulate light contributions
    vec3 ambient = vec3(0.3);
    vec3 diffuse = vec3(0.0);
    vec3 specular = vec3(0.0);

    for (int i = 0; i < numLights; i++) {
        // Ambient lighting
        float ambientStrength = 0.5;
        ambient += ambientStrength * lightColor[i];

        // Diffuse lighting
        vec3 lightDir = normalize(lightPos[i] - FragPos);
        float diff = max(dot(norm, lightDir), 0.0);
        diffuse += diff * lightColor[i];

        // Specular lighting
        float specularStrength = 0.8;
        vec3 reflectDir = reflect(-lightDir, norm);
        float spec = pow(max(dot(viewDir, reflectDir), 0.0), 22.0); // Shininess hardcoded as 32
        specular += specularStrength * spec * lightColor[i];
    }

    // Combine lighting results
    vec3 lighting = (ambient + diffuse + specular) * objectColor;

    // Reflection vector
    vec3 reflection = reflect(-viewDir, norm);
    vec3 reflectionColor = texture(skybox, reflection).rgb;

    // Refraction vector
    vec3 refraction = refract(-viewDir, norm, 1.0 / refractiveIndex);
    vec3 refractionColor = texture(skybox, refraction).rgb;

    // Combine reflection, refraction, and lighting
    vec3 result = mix(lighting, reflectionColor, reflectivity); // Add reflection
    result = mix(result, refractionColor, refractivity);        // Add refraction

    // Final color output
    FragColor = vec4(result, 1.0);
}
