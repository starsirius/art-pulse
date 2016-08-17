defmodule Pulse.TweetChannel do
  use Phoenix.Channel

  def join("tweet:" <> _rest, _message, socket) do
    {:ok, socket}
  end
end
