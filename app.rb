require_relative 'advice'
require 'erb'

class App
  def call(env)
    case env['REQUEST_PATH']
    when '/'
      ['200', { 'Content-Type' => 'text/html' }, [erb(:index)]
      ]
    when '/advice'
      piece_of_advice = Advice.new.generate
      [
        '200',
        { "Content-Type" => 'text/html' },
        [erb(:advice, message: piece_of_advice)]
      ]
    else
      [
        '404',
        { "Content-Type" => 'text/html' },
        [erb(:not_found)]
      ]
    end
  end

  def erb(filename, local = {})
    b = binding
    message = local[:message]
    content = File.read("views/#{filename}.erb")
    ERB.new(content).result(b)
  end
end
