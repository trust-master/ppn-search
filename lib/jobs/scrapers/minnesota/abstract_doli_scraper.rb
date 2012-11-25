require 'mechanize'
require 'json'

class Jobs::Scrapers::Minnesota::AbstractDOLIScraper < AbstractScraper
  attr_reader :license_number
  attr_reader :company_id

  DATE_FORMAT = '%m/%d/%Y'


  def parse_page
    page = get_results_page

    self.class.instance_variable_get(:@ids).each do |id|
      if node = page.search(".//span[@id='#{id}']").first and value = node.text.try(:strip).presence
        output.send("#{id.underscore}=", value)
      end
    end

    output.sanity_check!
  end

  def get_results_page
    page = agent.get(url)
    assert_results_found(page)

    prepare_form(page.forms[0]).submit
  end

  def prepare_form(form)
    # these fields are set normally by the __doPostBack function at the bottom of the rendered page
    form['__EVENTARGUMENT'] = 'Select$0' # click 'Details' for the first result (should be the _only_ result)
    form['__EVENTTARGET'] = 'gvLicensing'

    form.radiobutton_with(name: 'licenseType', id: 'rbPersonal').checked = (license_type == :personal)
    form.radiobutton_with(name: 'licenseType', id: 'rbBusiness').checked = (license_type == :business)
    return form
  end

  private

  def output
    @output ||= LicenseData.new(license_type)
  end

  def company_id=(id)
    ::Company.find(id) # ensure that a company with this ID exists
    @company_id = id
  end

  def license_number=(lic_no)
    @license_number = LicenseNumber.new(lic_no)
  end

  def parse_date(date_string)
    if date_string.present?
      Date.strptime(date_string, DATE_FORMAT)
    end
  end

  def license_class
    license_type.to_s.titlecase[0..2]
  end

  def url
    [ DOLI_BASE_URL,
      { Advanced: 'yes', LicNo: license_number, LicClass: license_class, DiscType: 'ALL',
        DiscVal: nil, Type: 'ALL', Name: nil, City: nil, Zip: nil, Status: 'NONE',
        PageSize: 10 }.to_query
    ].join('?')
  end

  def assert_results_found(page)
    if page.search(%{//td//*[contains(text(), "#{license_number}")]}).empty?
      raise NoResultsError, "No results were found for license_number: #{license_number}"
    end
  end

end
