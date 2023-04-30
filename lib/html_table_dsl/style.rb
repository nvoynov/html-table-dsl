require_relative "tag"

module HTMLTableDSL

  class Style < Tag
    def initialize(body = [], **prop)
      super(body, **prop)
    end

    def body
      @body.map(&:to_s).join(?\n)
    end
  end

end
