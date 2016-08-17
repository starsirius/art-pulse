defmodule Pulse.TweetReceiver do
  require Logger

  alias Pulse.Endpoint

  def start_link(channel) do
    {name, keywords} = channel

    track = keywords |> process_keywords
    stream = ExTwitter.stream_filter(track: track, language: "en", timeout: :infinity)

    for tweet <- stream |> process_stream(name) do
      Endpoint.broadcast("tweet:#{name}", "new_tweet", tweet)
    end
  end

  defp process_keywords(keywords) do
    keywords
      |> Enum.map(fn k -> k |> String.replace(",", "") |> String.trim end)
      |> Enum.join(",")
  end

  defp process_stream(stream, channel_name) do
    stream
      |> Stream.map(fn t -> Map.from_struct(t) end)
      |> Stream.map(fn t -> Map.take(t, [:coordinates, :created_at, :place, :text, :user]) end)
      |> Stream.map(fn t -> Map.put(t, :topic, channel_name) end)
  end
end
