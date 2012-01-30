Before do |scenario|
  # @current_scenario = scenario
  # @feature_name, @feature_description = @current_scenario.feature.name.split("\n", 2)
  # @tag_names = @current_scenario.instance_variable_get("@tags").tag_names
  # @feature_tag_names = @current_scenario.feature.instance_variable_get("@tags").tag_names

  #reset_email
  @logger = Rails.respond_to?(:logger) ? Rails.logger : ActionController::Base.logger
end

Then(/^I should see the ([()\[\]{}\w\s\/\-:.]+) message$/) do |key|
  key = key.split(/[^\w]+/).compact.join('.').downcase
  # begin
  message = I18n.translate!(key)
  # rescue I18n::MissingTranslationData
  #   message = I18n.translate!(key, scope: @feature_name.downcase)
  # end
  page.should have_content(message)
end

Then(/^I should be (?:on|at|viewing) the ([\w ]+) path$/) do |identifier|
  identifier = identifier.split(/[^\w]+/).compact.join('_').downcase
  current_path.should == send("#{identifier}_path")
end
