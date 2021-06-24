FROM ruby:3.0-alpine

COPY webserver.rb /

ENTRYPOINT ["ruby", "/webserver.rb"]
