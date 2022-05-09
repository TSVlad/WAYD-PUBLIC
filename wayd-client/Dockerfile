FROM node:current-alpine3.15
WORKDIR /app
COPY package.json /app
RUN npm cache clear --force
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]