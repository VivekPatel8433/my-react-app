# Use Node 24 to match your dependencies
FROM node:22.17.1-alpine

# Set working directory
WORKDIR /app

# Copy only package files first for caching npm installs
COPY package*.json ./

# Install netlify-cli globally
RUN npm install -g netlify-cli

# Install dependencies (use legacy-peer-deps to avoid peer conflicts)
RUN npm install --legacy-peer-deps

# Copy rest of the app source
COPY . .

# Build the React app
RUN npm run build

# Default command
CMD ["sh"]