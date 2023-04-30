require_relative "../test_helper"

describe Tag do
  it {
    assert_equal "<tag>\n  body\n</tag>", Tag.('body')

    sample = <<~EOF
      <tag width="10px">
        body
      </tag>
    EOF
    assert_equal sample.strip, Tag.('body', width: '10px')

    sample = <<~EOF
      <tag style="width:100%; height:100%">
        body
      </tag>
    EOF
    assert_equal sample.strip, Tag.('body', style: {width: '100%', height: '100%'})
    # puts Tag.('body', style: {width: '100%', height: '100%'})

    class SomeKey < Tag; end
    assert_equal "<somekey>\n  body\n</somekey>", SomeKey.('body')
  }
end
