require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    student_info_array = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    s_info = doc.css("div.student-card")
    s_info.each do |student|
      student_hash = {}
      student_hash[:name] = student.css(".card-text-container h4").text
      student_hash[:location] = student.css("p").text
      student_hash[:profile_url] = student.css("a").attribute("href").value
      student_info_array << student_hash
    end
    student_info_array
  end

  def self.scrape_profile_page(profile_url)
    s_hash = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    pages = doc.css("div.social-icon-container a")
    pages.map do |link|
       url = link.attribute("href").value
       if url.include? "twitter"
         s_hash[:twitter] = url
       elsif url.include? "linkedin"
         s_hash[:linkedin] = url
       elsif url.include? "github"
         s_hash[:github] = url
       elsif url != nil
         s_hash[:blog] = url
       end
    end
    s_hash[:profile_quote] = doc.css(".profile-quote").text
    s_hash [:bio] = doc.css(".description-holder p").text
    s_hash
  end

end
