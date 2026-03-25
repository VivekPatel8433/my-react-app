# Use Node 22 LTS Alpine
FROM node:22.17.1-alpine

# Set working directory
WORKDIR /app

# Copy package files first (for caching)
COPY package*.json ./

# Install global tools (like Netlify CLI)
RUN npm install -g netlify-cli

# Install dependencies using legacy-peer-deps to avoid conflicts
RUN npm install --legacy-peer-deps

# Copy the rest of the app
COPY . .

# Optional: install specific ajv version to fix react-scripts build
RUN npm install ajv@8.12.0 --legacy-peer-deps

# Build React app
RUN npm run build

# Default command (you can change this later)
CMD ["sh"]