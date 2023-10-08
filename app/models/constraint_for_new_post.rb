# route constraint class that constraints 'get /posts/new' & 'post /posts' to only work as turbo frames (and not independent requests)

class ConstraintForNewPost
  def initialize
    @header = 'Turbo-Frame'
  end

  def matches?(request)
    request.headers.include? @header
  end
end