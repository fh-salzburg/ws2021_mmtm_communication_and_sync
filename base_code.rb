require "sinatra/reloader"
require "faraday"
require "nats/io/client"
require "securerandom"
require "pry"

require "opentelemetry-sdk"
require "opentelemetry-exporter-otlp"
require "opentelemetry-instrumentation-all"

OpenTelemetry::SDK.configure do |c|
  c.use_all()
end

configure do
  nats = NATS::IO::Client.new;
  nats.connect("nats")
  nats.on_error do |e|
    raise e
  end

  set :nats, nats
end

class Order
  attr_reader :state, :id

  def initialize
    @state = :pending
    @id = SecureRandom.uuid
  end

  def success!
    @state = :success
  end

  def failure!
    @state = :failure
  end
end
