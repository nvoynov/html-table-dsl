module HTMLTableDSL

  # CSS properties container
  # @example
  #   CSS.('tr, td', prop1: '42')
  #   # tr, td {}
  #   #   prop1: 42
  #   # }
  class CSS
    def self.call(key, **prop)
      new(key, **prop).to_s
    end

    # private_class_method :new
    def initialize(key, **prop)
      @key = key
      @prop = prop
    end

    def to_s
      body = @prop.map{|par, val| "\s\s#{par}: #{val};"}.join(?\n)
      ["#{@key} {", body, '}'].join(?\n)
    end
  end

end
