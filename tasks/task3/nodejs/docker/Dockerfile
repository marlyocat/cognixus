# Official nodejs image
FROM node:23.9.0-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Set the Environment variable for the port
ENV PORT=3000

# Set correct permissions for the node user
RUN chown -R node:node /app

# Switch to non-root user for security
USER node

# Expose the application port
EXPOSE 3000

# Command to run the application
CMD ["node", "app.js"]