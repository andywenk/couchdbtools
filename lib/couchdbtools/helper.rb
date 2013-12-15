module Couchdbtools

  module Helper
    # create a querystring
    # @param query_params (hash)
    def querystring(query_params)
      return "" if query_params.empty?
      query = query_params.map do |key, value|
        "#{key}=#{value}"
      end
      "?#{query.join('&')}"
    end

    def raise_error_unless_params_is_a_hash(params_hash)
      raise Couchdbtools::Error::HashAsParamExpected unless params_hash.is_a?(Hash)
    end

    def raise_error_if_params_are_empty
      raise Couchdbtools::Error::EmptyParamNotAllowed if params_hash.empty?
    end

    def symbolize_keys(hash)
      hash.inject({}) do |result, (key, value)|
        symbolized_key(result, key, value)
      end
    end

    def symbolized_key(result, key, value)
      new_key = key.is_a?(String) ? key.to_sym : key
      new_value = value.is_a?(Hash) ? symbolize_keys(value) : value
      result[new_key] = new_value
      result
    end
  end
end
