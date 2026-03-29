FROM ghcr.io/cirruslabs/flutter:3.24.5 AS builder

WORKDIR /app

COPY frontend/pubspec.yaml frontend/analysis_options.yaml ./
RUN flutter config --enable-web && flutter pub get

COPY frontend/ ./

ARG API_BASE_URL=/api/v1
RUN flutter build web --release --dart-define=API_BASE_URL=${API_BASE_URL}

FROM nginx:1.27-alpine

COPY frontend/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
