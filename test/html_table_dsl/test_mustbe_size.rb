require_relative "../test_helper"

describe MustbeSize do
  let(:proper) { [1, 3, 100] }
  let(:faulty) { [nil, Object, Object.new, '', '1', 1.5] }

  it {
    proper.each{|arg| assert_equal arg, MustbeSize.(arg)}
    faulty.each{|arg|
      assert_raises(ArgumentError) { MustbeSize.(arg) }
    }
  }
end
