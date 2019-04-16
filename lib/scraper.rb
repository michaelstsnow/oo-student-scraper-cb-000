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
    doc = Nokogiri::HTML(open(profile_url))
    student_hash={}
    social_icons=doc.css('div.social-icon-container a')
    social_icons.each do |social_icon|
      link=social_icon['href']
      case
      when link.include?('twitter')
        student_hash[:twitter] = link
      when link.include?('linkedin')
        student_hash[:linkedin] = link
      when link.include?('github')
        student_hash[:github] = link
      else
        student_hash[:blog] = link
      end # of case statement
    end #end of loop

    profile_quote=doc.css('div.profile-quote').text
    profile_bio=doc.css('div.details-container p').text

    student_hash[:profile_quote] = profile_quote
    student_hash[:bio] = profile_bio

    student_ha
  end # end of scrape_profile_page

end
