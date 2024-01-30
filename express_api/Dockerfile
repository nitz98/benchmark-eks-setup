FROM node:latest as builder

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

#Multistaging to reduce image size
FROM node:alpine

WORKDIR /app

# Copy only necessary files from the builder stage
COPY --from=builder /app/ .

EXPOSE 3000

CMD [ "npm", "start" ]


