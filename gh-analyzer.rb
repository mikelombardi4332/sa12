require 'httparty'
require 'json'

def fetch_repositories(username)
  url = "https://api.github.com/users/#{username}/repos"
  response = HTTParty.get(url)
  
  if response.code == 200
    JSON.parse(response.body)
  else
    puts "Error fetching repositories: #{response.message}"
    nil
  end
end

def analyze_repositories(repos)
  return unless repos

  most_starred_repo = repos.max_by { |repo| repo['stargazers_count'] }
  
  {
    name: most_starred_repo['name'],
    description: most_starred_repo['description'],
    stars: most_starred_repo['stargazers_count'],
    url: most_starred_repo['html_url']
  }
end

def display_repository(repo)
  puts "Name: #{repo[:name]}"
  puts "Description: #{repo[:description]}"
  puts "Stars: #{repo[:stars]}"
  puts "URL: #{repo[:url]}"
end

username = #'example_username'
repositories = fetch_repositories(username)

if repositories
  most_starred_repo = analyze_repositories(repositories)
  display_repository(most_starred_repo)
end
