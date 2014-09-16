describe 'Code custom routes' do
  let(:url) { Url.create(link: 'http://google.com') }

  it 'redirects /:hash_code to urls#redirector' do
    expect(get: "/#{url.hash_code}").to route_to(
      controller: 'urls',
      action: 'redirector',
      hash_code: url.hash_code
    )
  end

  it 'redirects /:hash_code/preview to urls#preview' do
    expect(get: "/#{url.hash_code}/preview").to route_to(
      controller: 'urls',
      action: 'preview',
      hash_code: url.hash_code
    )
  end
end
