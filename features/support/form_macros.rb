module FormMacros



  def form_label_for(model_names, attribute_name, lookup_action = nil)
    namespace = :labels
    lookups = []

    model_class = model_names.last.try(:to_s).try(:classify).try(:safe_constantize)

    while !model_names.empty?
      joined_model_names = model_names.join(".")
      model_names.shift

      lookups << :"#{joined_model_names}.#{lookup_action}.#{attribute_name}"
      lookups << :"#{joined_model_names}.#{attribute_name}"
    end
    lookups << :"defaults.#{lookup_action}.#{attribute_name}"
    lookups << :"defaults.#{attribute_name}"

    if model_class
      lookups << model_class.human_attribute_name(attribute_name)
    end

    I18n.t!(lookups.shift, :scope => :"simple_form.#{namespace}", :default => lookups)
  end
end

World(FormMacros)
