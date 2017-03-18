require "mockserver-client"

class ExpectationGenerator

  include MockServer
  include MockServer::Model::DSL

  def create_expectation
    client = MockServerClient.new('localhost', 1080)
    expectation = expectation do |expectation|
         expectation.request do |request|
            request.method = 'GET'
            request.path = '/api3/Session/GetAcceptedSessionsByTimeslot'
            request.query_string_parameters << parameter('year', '2017')
         end

        expectation.response do |response|
            response.status_code = 200
            response.headers << header('Content-Type', 'application/json; charset=utf-8')
            response.body = body(File.read('sessions.json').to_json)
            response.delay = delay_by(:SECONDS, 1)
        end
    end
    expectation.times = unlimited()
    client.register(expectation)
  end
end
