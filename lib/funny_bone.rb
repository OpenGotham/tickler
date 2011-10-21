class FunnyBone < Webmachine::Resource
  attr_reader :groper

  def initialize(groper = nil)
    set_groper
    super
  end

  def set_groper(groper = Groper.new)
    @groper = groper
  end

  def to_html
    if @groper.perform
      "<html><body>Server has been tickled, and will now get gropey.</body></html>"
    else
      "<html><body>Server has been tickled, but could not respond in kind.</body></html>"
    end
  end
end
