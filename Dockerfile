# Use an existing base image with Node.js and Nginx
FROM node:14.17.0 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the LLMConnectOpenAPI.json file to the container
COPY LLMConnectOpenAPI.json .

# Use an existing base image with Nginx
FROM nginx:1.21.0-alpine

# Copy the HTML file to the Nginx image
COPY Cloud_function.html /usr/share/nginx/html/index.html

# Copy the LLMConnectOpenAPI.json file to the Nginx image
COPY --from=build /app/LLMConnectOpenAPI.json /usr/share/nginx/html/LLMConnectOpenAPI.json

# Expose the port that Nginx listens on
EXPOSE 80

# Start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
