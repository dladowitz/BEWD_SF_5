class UrlsController < ApplicationController
  def new
    @url = Url.new
  end

  def create
    # Why "find_or_initialize_by"?
    # If the user enters a link that already exists, it will find the Url
    # by that link OR do "new" it if it doesn't exist. This will prevent
    # multiple records in the database with the same link but different codes.
    @url = Url.find_or_initialize_by(url_params)

    if @url.save
      redirect_to @url
    else
      render 'new'
    end
  end

  def show
    @url = Url.find(params[:id])
    @full_path = url_redirector_url(@url.hash_code)
  end

  def redirector
    @url = Url.find_by(hash_code: params[:hash_code])

    if @url
      redirect_to @url.link
    else
      redirect_with_error
    end
  end

  def preview
    @url = Url.find_by(hash_code: params[:hash_code])

    unless @url
      redirect_with_error
    end
  end

  private
  def url_params
    params.require(:url).permit(:link)
  end

  # If the url hash_code is invalid, redirect to the root path.
  # The "alert" key is used in application.html.erb to output an error
  # message for the user to see what went wrong. This is called "the flash".
  # Check out application.html.erb to see it used.
  def redirect_with_error
    redirect_to root_url, alert: "Invalid code specified."
  end
end
