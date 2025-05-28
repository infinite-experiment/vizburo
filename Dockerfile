FROM nginx:alpine

# remove default config if you have custom one
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# copy your built site (html, css, js, assets)
COPY . /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
