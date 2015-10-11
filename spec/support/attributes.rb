  def user_attributes(overrides = {})
    {
      id: 1,
      name: "William Wallace",
      email: "william.wallace@scotland.com",
      password: "Testing1"
    }.merge(overrides)
  end
