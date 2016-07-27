require 'uri'
require 'net/http'
require 'json'

class CreateIssueJob < ActiveJob::Base

  def perform
    uri = URI.parse(Rails.application.secrets.github_api)
    http_client = Net::HTTP.new(uri.host, uri.port)
    http_client.use_ssl = true
    request = Net::HTTP::Post.new(uri.path)
    request.basic_auth 'RubyBenchBot', Rails.application.secrets.github_password
    request.body = {"title" => "Benchmark Regresion Detected"}.to_json
    response = http_client.request(request)
    raise StandardError, "Request failed with response code #{response.code}" if response.code != "201"
    response
  end
end
