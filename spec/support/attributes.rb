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

  def user_attributes4(overrides = {})
    {
      id: 39,
      name: "Naomi Wallace",
      email: "naomi.wallace@scotland.com",
      password: "Testing1",
      admin: "true"
    }.merge(overrides)
  end

  def user_attributes5(overrides = {})
    {
      id: 68,
      name: "Delete Wallace",
      email: "delete.wallace@scotland.com",
      password: "Testing1"
    }.merge(overrides)
  end
