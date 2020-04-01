# Build section
FROM node:alpine as builder

WORKDIR /app

COPY ./package.json .
RUN npm install

COPY . .
RUN npm run build

# /app/build static content

# Run server section
FROM nginx:alpine
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

# Default command start nginx