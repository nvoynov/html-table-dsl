require_relative "../test_helper"

describe CSS do
  it {
    assert_equal "key {\n\n}", CSS.('key')
    sample = <<~EOF
      key {
        prop1: 1px;
        prop2: 2px;
      }
    EOF
    assert_equal sample, CSS.('key', prop1: '1px', prop2: '2px') + ?\n
  }
end
