#AbstractValidator
* simple gem that allows you to create validators for your taste
* each validator has #valid? and #errors methods that tells you if object you're verifying is valid and its errors if it is not
```ruby
class UserValidator < AbstractValidator
  VALIDATIONS = [{
    method: ->(name){ name.match(/[\W]+/)== nil },
    message: "username contains bullshit",
    keys: [:username]
  },{
    method: ->(email){ email.match(/\w+@\w+\.\w+/)!= nil },
    message: "email is not emailish",
    keys: [:email]
  }]
end
user = Struct.new(:username, :email).new("deedee","deedee.ramone@ramones.com")
validator  = UserValidator.new(user)
validator.valid? #=> true
```
