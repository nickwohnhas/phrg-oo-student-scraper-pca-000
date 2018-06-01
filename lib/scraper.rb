require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = []
    page = Nokogiri::HTML(open(index_url))

    page.css('div.student-card').each_with_index do |data_object, index|
        data_hash = {}
        data_hash[:name] = data_object.css('h4').text
        data_hash[:location] = data_object.css('div.card-text-container p.student-location').text
        data_hash[:profile_url] = data_object.css('a')[0]['href']

        scraped_students << data_hash
        end
   scraped_students
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))

    student_hash = {}
    page.css('div.vitals-container').each do |data_object|

    data_object.css('div.social-icon-container a').each do |social_string|

        if self.parse_email(social_string['href'])

      student_hash[self.parse_email(social_string['href'])] = social_string['href']
        end
      end
    student_hash[:profile_quote] = data_object.css('div.vitals-text-container div.profile-quote').text

  end
  page.css('div.details-container').each do |data_object|
  student_hash[:bio] = data_object.css('div.description-holder')[0].text.strip
  end
  student_hash
end

def self.parse_email(email_string)
  if email_string.include?("twitter")
    :twitter
  elsif email_string.include?("github")
    :github
  elsif email_string.include?("linked")
    :linkedin
  elsif email_string.include?("joemburg")
    :blog
  else
    nil
  end

 end

end
