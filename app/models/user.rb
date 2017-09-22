# frozen_string_literal: true

class User < ApplicationRecord
  include Blacklight::User
  include Hyrax::User
  include Hyrax::UserUsageStats
  include Hydra::RoleManagement::UserRoles

  if Blacklight::Utils.needs_attr_accessible?
    attr_accessible :email, :password, :password_confirmation
  end

  # Connects this user object to Blacklights Bookmarks.
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def preferred_locale; end

  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account.
  def to_s
    email
  end
end
