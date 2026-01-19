# Step 1: Use a lightweight Nginx image
FROM nginx:alpine

# Step 2: Copy your static files to the Nginx html folder
COPY . /usr/share/nginx/html

# Step 3: Expose port 80
EXPOSE 80

# Step 4: Start Nginx (Default command, but good practice to be explicit)
CMD ["nginx", "-g", "daemon off;"]
