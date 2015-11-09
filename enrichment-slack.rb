require 'sinatra'
require 'clearbit'

InvalidTokenError = Class.new(Exception)

post '/' do

  raise(InvalidTokenError) unless params[:token] == '<SLACK_TOKEN>'

  text = params.fetch('text').strip

  Clearbit.key = '<CLEARBIT_API_KEY>'

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
  else
    <<-TEXT 
    This profile does not exist 🤔
    TEXT
  end
end
