FROM node:alpine
RUN mkdir /home/app
WORKDIR /home/app
COPY package.json /home/app
RUN npm install
COPY . /home/app/
CMD ["node", "index.js"]
