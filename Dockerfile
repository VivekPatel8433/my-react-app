FROM node:24.14.0-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install -g netlify-cli

RUN npm install --legacy-peer-deps

COPY . .

RUN npm run build

CMD ["sh"]