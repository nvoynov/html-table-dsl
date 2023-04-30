require_relative "../test_helper"

class TestDSL < Minitest::Test
  def test_dry_run
    DSL.() do
      width '200px'
      height '100%'
      cellpadding top: '15px'
      border '1px solid black', collapse: 'collapse'

      tr class: 'yellow' do
        th '1'
        th '2'
        th '3'
      end
      tr do
        td '0', class: 'red'
        td 'X'
        td '0'
      end
      tr do
        td 'X'
        td '0', class: 'red'
        td 'X'
      end
      tr do
        td '0'
        td 'X'
        td '0', class: 'red'
      end
    end
  end

  def test_build
    dummy = DSL.()
    assert_kind_of String, dummy
    assert_match '<table>', dummy
    assert_match '</table>', dummy

    dummy = DSL.(rows: 3, cols: 3)
    ['<tr>', '</tr>', '<td>', '</td>'
    ].each{|tag|
      assert_match tag, dummy
    }
  end

  def test_width
    dummy = DSL.() { width '100%' }
    assert_match 'width="100%"', dummy

    dummy = DSL.() { width '100px' }
    assert_match 'width="100px"', dummy

    assert_raises(ArgumentError) {
      DSL.() { width '100 faulty' }
    }
  end

  def test_height
    dummy = DSL.() { height '100%' }
    assert_match 'height="100%"', dummy

    dummy = DSL.() { height '100px' }
    assert_match 'height="100px"', dummy

    assert_raises(ArgumentError) {
      DSL.() { height '100 faulty' }
    }
  end

  # cellpadding top: '15px'
  def test_cellpadding
    text = DSL.() { cellpadding '10px' }
    assert_match '<style>', text
    assert_match 'padding: 10px', text

    text = DSL.() { cellpadding top: '10px', left: '15px' }
    assert_match 'padding-top: 10px', text
    assert_match 'padding-left: 15px', text

    assert_raises(ArgumentError) {
      DSL.() { cellpadding faulty: '10px' }
    }
  end

  def test_border
    text = DSL.() { border '1px solid black', collapse: 'collapse' }
    assert_match '<style>', text
    assert_match 'border: 1px solid black', text
    assert_match 'border-collapse: collapse', text
  end

  def test_tr
    text = DSL.() {
      tr {
        th 'header', class: 'strong'
        td 'column'
      }
    }
    assert_match '<th class="strong">', text
    assert_match '<td>', text
    assert_match 'column', text
  end

end
