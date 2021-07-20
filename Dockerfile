FROM nginx:1.17.1-alpine
COPY /dist/FormSubmit /usr/share/ngnix/html
