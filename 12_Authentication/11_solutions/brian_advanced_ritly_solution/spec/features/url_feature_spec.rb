require 'rails_helper'

feature 'Generating short urls' do
  let(:long_path) { 'https://www.google.com/search?site=&tbm=isch&source=hp&biw=1920&bih=1008&q=photo&oq=photo&gs_l=img.3..0l10.1918.2819.0.3009.5.5.0.0.0.0.106.371.2j2.4.0....0...1ac.1.53.img..1.4.369.WZ9Zn9gqSl0&gws_rd=ssl' }
  let(:url) { Url.create(link: long_path) }

  context 'when filling out a new form' do
    before { visit new_url_path }

    context 'with valid data' do
      it 'creates a new Url record' do
        fill_in 'url_link', with: long_path.to_s
        click_on 'Create short URL'

        expect(Url.count).to eq 1
        expect(Url.first.link).to eq long_path
      end
    end

    context 'with invalid data' do
      it 'shows an error message' do
        fill_in 'url_link', with: ''
        click_on 'Create short URL'

        expect(Url.count).to eq 0
        expect(page).to have_content "Link can't be blank"
      end
    end
  end

  context 'when visiting show' do
    before { visit url_path(url) }

    it 'shows the code link' do
      expect(page).to have_link url.hash_code, url_redirector_path(url.hash_code)
    end

    it 'shows the link destination' do
      expect(page).to have_link url.link, url.link
    end
  end

  context 'when visiting preview' do
    before { visit url_preview_path(url.hash_code) }

    it 'shows the code' do
      expect(page).to have_content url.hash_code
    end

    it 'shows a preview of the link' do
      expect(page).to have_content url.link
    end
  end
end
