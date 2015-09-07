# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  firstname              :text
#  lastname               :text
#  username               :text
#  role                   :integer          default(1), not null
#  email                  :text
#  phonenumber            :integer
#  password_digest        :string
#  token                  :string
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  active                 :boolean          default(TRUE)
#  main_store_contact     :boolean          default(FALSE)
#  main_business_contact  :boolean          default(FALSE)
#  confirmed              :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'rails_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

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
    @venue_user = User.create({
      firstname: 'baz',
      lastname: 'far',
      phonenumber: 6173889520,
      username: 'bazfar',
      role: 'venue_admin',
      email: 'baz@far.com',
      password: 'supersecret'
    })
  end

  it 'has a firstname' do
    expect(@admin_user.firstname).to_not be_nil
    expect(@admin_user.firstname.class).to eq String
    expect(@admin_user.firstname).to eq 'foo'
    expect(@venue_user.firstname).to eq 'baz'
  end

  it 'has a lastname' do
    expect(@admin_user.lastname).to_not be_nil
    expect(@admin_user.lastname.class).to eq String
    expect(@admin_user.lastname).to eq 'bar'
    expect(@venue_user.lastname).to eq 'far'
  end

  it 'has a valid email address' do
    expect(@admin_user.email).to eq 'foo@bar.com'
    expect(@venue_user.email).to eq 'baz@far.com'
  end

  it 'has a role of admin' do
    expect(@admin_user.role).to eq 'admin'
    expect(@venue_user.role).to eq 'venue_admin'
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

  it 'has a uuid generated from the uuid adapter' do
    expect(@admin_user.id).to_not be_nil
    expect(@admin_user.id).to match(/([\w\d\-]){36}/)
  end
end
