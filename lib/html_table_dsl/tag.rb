module HTMLTableDSL

  class Tag
    # @param body [respond_to? :to_s] tag body
    # @param prop [Hash<prop,value>] of tag properties, where
    #   value can be nested hash<prop,value>
    def self.call(body = '', **prop)
      new(body, **prop).to_s
    end

    # private_class_method :new
    def initialize(body = '', **prop)
      @tagn = self.class.name.split('::').last.downcase
      @body = body
      @prop = prop
    end

    def to_s
      indented = body.to_s.lines.map{|l| "\s\s#{l}"}.join
      ["<#{@tagn}#{prop}>", indented, "</#{@tagn}>"].join(?\n) # + ?\n
    end

    protected

    def body
      @body
    end

    def prop
      return '' unless @prop.any?
      fu = proc{|v| v.is_a?(Hash) ? v.map{|k,v| "#{k}:#{v}"}.join('; ') : v}
      ?\s + @prop.map{|k, v| "#{k}=\"#{fu.(v)}\""}.join(?\s)
    end
  end

end
