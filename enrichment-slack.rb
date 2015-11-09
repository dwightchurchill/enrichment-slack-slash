require 'sinatra'
require 'clearbit'

Clearbit.key = '<CLEARBIT_API_KEY>'

InvalidTokenError = Class.new(Exception)

post '/' do

  raise(InvalidTokenError) unless params[:token] == '<SLACK_TOKEN>'

  text = params.fetch('text').strip

  person = Clearbit::Enrichment::Person.find(email: "#{text}")

  if person
    <<-TEXT
    Name: #{person.name.fullName} 😎  
    Location: #{person.location}
    Bio: #{person.bio}
    Company: #{person.employment.name}
    Job Title: #{person.employment.title}
    Company Website: #{person.employment.domain}
    Linkedin: linkedin.com/#{person.linkedin.handle}
    Twitter: twitter.com/#{person.twitter.handle}
    Github: github.com/#{person.github.handle}
    TEXT
  end
end
