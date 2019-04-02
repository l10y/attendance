require 'app/models/calculator'

def times(event:, context:)
  request = JSON.parse(event['body'])

  calc = Calculator.new(
    request['started_at'],
    request['ended_at']
  )

  {
    statusCode: 200,
    body: {
      times: {
        work: calc.worktime,
        over: calc.overtime,
        rate: calc.ratetime
      }
    }.to_json
  }
end
