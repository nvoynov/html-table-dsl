require_relative "tag"

module HTMLTableDSL

  class Th < Tag; end
  class Td < Tag; end

  class Tr < Tag
    # @param body [Array<Th|Td>]
    def initialize(body = [], **prop)
      super(body, **prop)
    end

    def th(body = '', **prop)
      @body << Th.new(body, **prop)
    end

    def td(body = '', **prop)
      @body << Td.new(body, **prop)
    end

    def body
      @body.map(&:to_s).join(?\n)
    end
  end


end
