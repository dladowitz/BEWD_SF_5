require 'rails_helper'

RSpec.describe Url, :type => :model do
  let(:url) { Url.new(link: 'http://google.com') }

  context 'validations' do
    it { should validate_presence_of :link }

    it 'requires hash_code to be set' do
      url.hash_code = nil
      expect(url.valid?).to eq false
      expect(url.errors.count).to eq 1
      expect(url.errors[:hash_code]).to match ["can't be blank"]
    end
  end

  context 'when saving' do
    it 'automatically creates a hash_code when initialized' do
      expect(url.hash_code).not_to be_nil
    end
  end
end
