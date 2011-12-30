Before do |scenario|
  @current_scenario = scenario
  @feature_name, @feature_description = @current_scenario.feature.name.split("\n", 2)
  @tag_names = @current_scenario.instance_variable_get("@tags").tag_names
  @feature_tag_names = @current_scenario.feature.instance_variable_get("@tags").tag_names
end

Then(/^I should see the ([()\[\]{}\w\s]+) message$/) do |key|
  key = key.gsub(/[^\w]+/, '.').downcase
  page.should have_content I18n.translate!(key, scope: @feature_name.downcase)
end