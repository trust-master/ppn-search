class Jobs::Scrapers::AbstractScraper

  def agent
    @agent ||= ::Mechanize.new
  end

end
