require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    ## Review the Nokogiri info - https://nokogiri.org/index.html#license
    # and reattempt
    doc = Nokogiri::HTML(open(index_url))
    all_student_cards=doc.css('div.student-card')
    student_hash=[]
    all_student_cards.each do |card|
      card.css('a').each do |student|
        name=student.css('h4.student-name').text
        location=student.css('p.student-location').text
        profile=student['href']
        student_hash << {name: name, location: location, profile_url: profile }
      end #end of student
    end #end of card
    student_hash
  end #end of def

  def self.scrape_profile_page(profile_url)

  end

end
