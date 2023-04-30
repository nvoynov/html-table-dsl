require_relative "../test_helper"

describe MustbePadding do
  let(:proper_keys) { %i[top left right bottom] }
  let(:faulty_keys) { [nil, Object, Object.new, 'opt', '1', 1.5] }

  it {
    MustbePadding.({top: '15px'})
    assert_raises(ArgumentError) { MustbePadding.({top: '15'}) }

    proper = proper_keys.map{|arg| [arg, '15px']}.to_h
    MustbePadding.(proper)
    faulty_keys.each{|arg|
      assert_raises(ArgumentError) { MustbePadding.({arg => '15'}) }
    }
  }
end
