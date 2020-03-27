require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper
    def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end
  
  def get_courses
    doc = self.get_page
    doc.css(".posts-holder")
  end

  def make_courses
    course_array = get_courses
    course_array.map do |course|
      newy = Course.new
      newy.title = course.css("h2").text
      newy.schedule = course.css(".date").text
      newy.description = course.css("p").text
    end
  end
end



