require 'sinatra'
require 'clearbit'

Clearbit.key = '<CLEARBIT_API_KEY>'

InvalidTokenError = Class.new(Exception)

post '/' do

  raise(InvalidTokenError) unless params[:token] == '<SLACK_TOKEN>'

  email = params.fetch("text").strip

  if /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.match(email) 
    
    person = Clearbit::Enrichment::Person.find(email: "#{email}")

    if person.respond_to?('name')
      
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
      They have no name! Try another email address!
      TEXT
      
    end 

  else

    <<-TEXT 
    Enter an email address
    TEXT

  end

end
