# route constraint class that constraints requests to only work as turbo frames (and not independent requests)

class TurboFrameConstraint
  def initialize
    @header = 'Turbo-Frame'
  end

  def matches?(request)
    request.headers.include? @header
  end
end