FROM ruby:3
RUN apt-get update
RUN apt-get install -y less
RUN gem install sinatra sinatra-contrib nats-pure pry puma slim httparty faraday opentelemetry-sdk opentelemetry-exporter-otlp opentelemetry-instrumentation-all opentelemetry-instrumentation-aws_sdk

WORKDIR /usr/src/app
COPY . /usr/src/app

EXPOSE 4567

CMD ["ruby", "app.rb", "-b", "0.0.0.0"]
