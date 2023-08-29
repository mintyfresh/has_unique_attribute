# frozen_string_literal: true

module HasUniqueAttribute
  # @param attribute_name [String]
  # @param index [String]
  # @param message [Symbol, String]
  # @return [void]
  def has_unique_attribute(attribute_name, # rubocop:disable Naming/PredicateName
                           index:   default_index_name_for_attribute(attribute_name),
                           message: :taken)
    assert_unique_index_defined!(index)

    handle_unique_attribute_on_save(attribute_name, index, message)
    handle_unique_attribute_on_save!(attribute_name, index, message)
  end

private

  # @param index_name [String]
  # @return [void]
  def assert_unique_index_defined!(index_name)
    index = connection.indexes(table_name).find { |index_definition| index_definition.name == index_name }

    raise ArgumentError, "#{name} does not have index: `#{index_name}`" if index.nil?
    raise ArgumentError, "#{name} defines an index `#{index_name}`, but it is not unique" unless index.unique
  rescue ActiveRecord::NoDatabaseError, ActiveRecord::StatementInvalid
    # Database or table does not exist yet. Ignore for now.
  end

  # @param attribute_name [String]
  # @return [String]
  def default_index_name_for_attribute(attribute_name)
    "index_#{table_name}_on_#{attribute_name}"
  end

  # @param attribute_name [String]
  # @param index_name [String]
  # @param message [Symbol, String]
  # @return [void]
  def handle_unique_attribute_on_save(attribute_name, index_name, message)
    existing_method = instance_method(:save)

    define_method(:save) do |*args, **kwargs|
      existing_method.bind_call(self, *args, **kwargs)
    rescue ActiveRecord::RecordNotUnique => error
      if error.message.include?(index_name)
        errors.add(attribute_name, message)

        return false
      end

      raise error
    end
  end

  # @param attribute_name [String]
  # @param index_name [String]
  # @param message [Symbol, String]
  # @return [void]
  def handle_unique_attribute_on_save!(attribute_name, index_name, message)
    existing_method = instance_method(:save!)

    define_method(:save!) do |*args, **kwargs|
      existing_method.bind_call(self, *args, **kwargs)
    rescue ActiveRecord::RecordNotUnique => error
      if error.message.include?(index_name)
        errors.add(attribute_name, message)

        raise ActiveRecord::RecordInvalid, self
      end

      raise error
    end
  end
end
