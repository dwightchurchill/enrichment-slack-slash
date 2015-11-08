require 'sinatra'
require 'clearbit'

InvalidTokenError = Class.new(Exception)

post '/' do

  raise(InvalidTokenError) unless params[:token] == '2BEFUpP1nHFKvh20EHT8r9Cb'

  text = params.fetch('text').strip

  Clearbit.key = 'd824e501bce714c3d32798606a5a43df'

  person = Clearbit::Enrichment::Person.find(email: "#{text}")

  if person
    <<-TEXT
    Name: #{person.name.fullName}
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
    No
    TEXT
  end
end
