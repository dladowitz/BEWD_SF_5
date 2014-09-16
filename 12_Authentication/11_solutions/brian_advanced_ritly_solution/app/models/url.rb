class Url < ActiveRecord::Base
  validates :hash_code, :link, presence: true

  # This creates a "callback" that triggers when the model is initialized
  # (with Url.new) and it is used to automatically generate a code. This
  # way, an Url always has a valid code.
  #
  # See http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html
  after_initialize :generate_code

  private
  def generate_code
    self.hash_code ||= SecureRandom.urlsafe_base64(8)
  end
end
