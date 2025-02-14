# frozen_string_literal: true

module Ex21
  class User
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def authenticated?
      true
    end

    def role?(_role)
      true
    end
  end
end
