require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    User.destroy_all
    @admin_user = User.create(
      {
        firstname: 'foo',
        lastname: 'bar',
        phonenumber: 6173889520,
        username: 'foobar',
        role: 'admin',
        email: 'foo@bar.com',
        password: 'secret',
      }
    )
  end

  it 'has a firstname' do
    expect(@admin_user.firstname).to_not be_nil
    expect(@admin_user.firstname.class).to eq String
    expect(@admin_user.firstname).to eq 'foo'
  end

  it 'has a lastname' do
    expect(@admin_user.lastname).to_not be_nil
    expect(@admin_user.lastname.class).to eq String
    expect(@admin_user.lastname).to eq 'bar'
  end

  it 'has a valid email address' do
    expect(@admin_user.email).to eq 'foo@bar.com'
  end

  it 'has a role of admin' do
    expect(@admin_user.role).to eq 'admin'
  end

  it 'has a unique admin_username' do
    expect(@admin_user.username).to eq 'foobar'
  end

  it 'digests the password' do
    expect(@admin_user.password_digest).to_not be_nil
  end

  it 'has a token generated from a password digest' do
    expect(@admin_user.token).to_not be_nil
    expect(@admin_user.token).to match(/([\w\d]){32}/)
  end

  it 'has a uuid generated from the postgres adapter' do
    expect(@admin_user.id).to_not be_nil
    expect(@admin_user.id).to match(/([\w\d\-]){36}/)
  end
end
