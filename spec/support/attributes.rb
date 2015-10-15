  def user_attributes(overrides = {})
    {
      id: 1,
      name: "William Wallace",
      email: "william.wallace@scotland.com",
      password: "Testing1"
    }.merge(overrides)
  end

  def user_attributes2(overrides = {})
    {
      id: 26,
      name: "Mary Wallace",
      email: "mary.wallace@scotland.com",
      password: "Testing1"
    }.merge(overrides)
  end

  def user_attributes3(overrides = {})
    {
      id: 36,
      name: "Billy Wallace",
      email: "billy.wallace@scotland.com",
      password: "Testing1",
      admin: "true"
    }.merge(overrides)
  end
