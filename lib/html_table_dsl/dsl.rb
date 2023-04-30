require_relative "sentry"
require_relative "css"

module HTMLTableDSL

  MustbeSize = Sentry.new(:size, "must be Integer 1..100"
  ) {|v| v.is_a?(Integer) && v.between?(1, 100)}

  MustbePxPc = Sentry.new(:key, "must be String /\d+(px|%)/"
  ) {|v| v.is_a?(String) && v =~ /\d+(px|%)/}

  MustbePx = Sentry.new(:key, "must be String /\d+px/"
  ) {|v| v.is_a?(String) && v =~ /\d+px/}

  MustbePadding = Sentry.new(:key, "must be Hash of padding|top|left|right|bottom: \d+px"
  ) {|v|
    v.is_a?(Hash) &&
    v.keys.all?{|key| %i[top left right bottom].include?(key)} &&
    v.values.all?{|val| val =~ /\d+px/}
  }

  # just to have this tag
  class Table < Tag; end

  # HTML Table DSL
  class DSL
    class << self
      def build(rows: 0, cols: 0, &blk)
        obj = new(rows, cols)
        obj.instance_eval(&blk) if block_given?
        obj.to_s
      end
      alias :call :build
    end

    private_class_method :new
    def initialize(rows = 0, cols = 0)
      @styl = []
      @opts = {}
      @rows = []
      if rows != 0 && cols != 0
        @rows = Array.new(3) { Tr.new(Array.new(3) { Td.new }) }
      end
    end

    def tr(**props, &blk)
      row = Tr.new(**props)
      row.instance_eval(&blk) if block_given?
      @rows << row
    end

    def width(arg)
      @opts[:width] = MustbePxPc.(arg, :width)
    end

    def height(arg)
      @opts[:height] = MustbePxPc.(arg, :height)
    end

    # 3. Specifying the table's border and cellpadding values
    def border(arg, **opts)
      # @todo check border options collapse: collapse
      if opts[:collapse]
        fail "must be collapse: collapse" unless opts[:collapse] == 'collapse'
      end

      prfx = opts.transform_keys{|key| "border-#{key}"}
      prfx[:border] = arg
      @styl << CSS.new('table, th, td', **prfx)
    end

    def cellpadding(arg = nil, **opts)
      MustbePadding.(opts)
      prfx = opts.transform_keys{|key| "padding-#{key}" }
      prfx[:padding] = MustbePx.(arg) if arg
      @styl << CSS.new('tr, th', **prfx)
    end

    def to_s
      [].tap{|lines|
        lines << Style.(@styl)
        lines << Table.(@rows.map(&:to_s).join(?\n), **@opts)
      }.join(?\n)
    end
  end

end
