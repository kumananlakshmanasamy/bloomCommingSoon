# bloom & body co. — launch page
# Static site served by nginx. Coolify: Build Pack = Dockerfile, Port = 80.
FROM nginx:1.27-alpine

# Replace default config
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/bloom.conf

# Site files
COPY public/ /usr/share/nginx/html/

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://127.0.0.1/healthz || exit 1
