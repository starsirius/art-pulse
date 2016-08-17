defmodule Pulse.PageController do
  use Pulse.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
