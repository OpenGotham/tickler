require File.expand_path('../helper', __FILE__)

class TestFunnyBone < MiniTest::Unit::TestCase
  def setup
    @groper = MiniTest::Mock.new
    @funny_bone = FunnyBone.new(nil, nil)
    @funny_bone.set_groper @groper
  end

  def test_that_a_groper_is_invoked
    @groper.expect(:perform, true, [])
    assert @funny_bone.to_html.match(/will now get gropey/), "Message was wrong: '#{@funny_bone.to_html}'"
    assert @groper.verify
  end

  def test_that_a_false_groper_is_invoked
    @groper.expect(:perform, false, [])
    assert @funny_bone.to_html.match(/could not respond in kind/), "Message was wrong: '#{@funny_bone.to_html}'"
    assert @groper.verify
  end
end
