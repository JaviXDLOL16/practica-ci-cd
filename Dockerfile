FROM node:14

WORKDIR /app

COPY package*.json ./

RUN npm install --unsafe-perm
RUN npm install mocha supertest --global

COPY . .

EXPOSE 3000
CMD ["node", "index.js"]
