defmodule revelry-koansWeb.PageController do
  use revelry-koansWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
