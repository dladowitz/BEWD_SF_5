require 'rails_helper'

RSpec.describe UrlsController, :type => :controller do
  let(:url) { Url.create!(link: 'http://google.com') }

  describe 'GET show' do
    before { get :show, id: url.id }

    it 'assigns the url' do
      expect(assigns(:url)).to eq url
    end

    it 'assigns the full_path' do
      expect(assigns(:full_path)).to eq url_redirector_url(url.hash_code)
    end
  end

  describe 'GET new' do
    it 'assigns a new Url to @url' do
      get :new
      expect(assigns(:url)).to be_new_record
    end
  end

  describe 'POST create' do
    context 'with a valid new link' do
      let(:link) { "http://url#{rand(1000..9999)}.com" }
      before { post :create, url: {link: link} }

      it 'saves an Url' do
        expect(Url.count).to eq 1
        expect(Url.first.link).to eq link
      end
    end

    context 'with an already existing Url link' do
      before { post :create, url: {link: url.link} }

      it 'does not create a new url' do
        expect(Url.count).to eq 1
        expect(Url.first).to eq url
      end

      it 'redirects to existing Url id show page' do
        expect(response).to redirect_to url_path(url)
      end
    end

    context 'with invalid params' do
      before { post :create, url: {link: ''} }

      it 'renders new template' do
        expect(response).to render_template 'new'
      end

      it 'does not create an Url' do
        expect(Url.count).to eq 0
      end
    end
  end

  describe 'GET redirect' do
    context 'with a valid code' do
      before { get :redirector, {hash_code: url.hash_code} }

      it 'assigns the @url from the code' do
        expect(assigns(:url)).to eq url
      end

      it 'redirects to the code' do
        expect(response).to redirect_to url.link
      end
    end

    context 'with an invalid redirect code' do
      before { get :redirector, {hash_code: '00000000'} }

      it 'does not assign @url' do
        expect(assigns(:url)).to be_nil
      end

      it 'renders #error' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET preview' do
    context 'with a valid code' do
      before { get :preview, {hash_code: url.hash_code} }

      it 'assigns the @url from the code' do
        expect(assigns(:url)).to eq url
      end
    end

    context 'with an invalid code' do
      before { get :preview, {hash_code: '00000000'} }

      it 'does not assign @url' do
        expect(assigns(:url)).to be_nil
      end

      it 'renders #error' do
        expect(response).to redirect_to root_path
      end
    end
  end
end
