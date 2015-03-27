require 'spec_helper'
require 'abstract_validator'

class NameValidator < AbstractValidator
  VALIDATIONS = [{ 
    message: "name is wrong, at least two symbols, letters only", 
    keys:[:name], 
    method: ->(name){ name.match(/^[\w][^\d]+$/) != nil; } 
  }]
end
class PasswordValidator < AbstractValidator
  VALIDATIONS = [{
    message: "passwords mismatch", 
    keys: [:password, :password_confirmation], 
    method: ->(pw1, pw2){ pw1 == pw2 && pw1.length > 10; }
  }]
end

describe AbstractValidator do

  let(:good_user) { Struct.new(:name).new("Rudie") }
  let(:good_pw_pair) { Struct.new(:password, :password_confirmation).new("secr3t_pa44word","secr3t_pa44word") }
  let(:bad_pw_pair) { Struct.new(:password, :password_confirmation).new("secr3t","s3cr3t") }
  let(:bad_user) { Struct.new(:name).new("Basdalsd1123123") }

  it "forbids to use asbtract class without VALIDATIONS hash" do
    expect{AbstractValidator.new({})}.to raise_error  NotImplementedError
  end

  describe "PasswordValidator, lamdba with 2 params" do
    it "good is valid" do
      expect(PasswordValidator.new(good_pw_pair).valid?).to eq(true)
    end
    it "bad is invalid" do
      expect(PasswordValidator.new(bad_pw_pair).valid?).to eq(false)
    end
  end

  describe "NameValidator, lambda with 1 param" do
    it "good is valid" do
      expect(NameValidator.new(good_user).valid?).to eq(true)
    end
    it "bad is invalid" do
      expect(NameValidator.new(bad_user).valid?).to eq(false)
    end
  end
end
