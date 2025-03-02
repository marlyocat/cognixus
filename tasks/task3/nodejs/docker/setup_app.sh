# Initialize new Node.js project
npm init -y  

# Install 'ip' package
npm install ip  

# Build Docker image
docker build -t my-nodejs-app .  

# Run container "my-nodejs-app" on port 3000
docker run -it -p 3000:3000 my-nodejs-app  