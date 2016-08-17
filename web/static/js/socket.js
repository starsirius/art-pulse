// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/2" function
// in "web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, pass the token on connect as below. Or remove it
// from connect if you don't care about authentication.

socket.connect()

const tweetsContainer = $("#tweets")
const channels = {
  artists: { enabled: true, channel: null },
  partners: { enabled: true, channel: null }
}
let isPlaying = true

for (let cid in channels) {
  if (channels[cid].enabled) { joinChannel(cid, channels) }
}
setupChannelToggles(channels)
setupPlayControl()

function joinChannel(cid, channels) {
  const channel = socket.channel(`tweet:${cid}`, {})
  let c = channels[cid]

  channel.on("new_tweet", onNewTweet)
  channel.join()
    .receive("ok", resp => {
      $(`.channel-toggle[data-channel-id="${cid}"]`).attr("data-joined", true)
      $.extend(c, {enabled: true, channel: channel})
      console.log(`Joined channel ${cid} successfully`, resp)
    })
    .receive("error", resp => {
      console.log(`Unable to join channel ${cid}`, resp)
    })
}

function leaveChannel(cid, channeld) {
  let c = channels[cid]

  c.channel.leave()
    .receive("ok", resp => {
      $(`.channel-toggle[data-channel-id="${cid}"]`).removeAttr("data-joined")
      $.extend(c, {enabled: false, channel: null})
      console.log(`Left channel ${cid} successfully`, resp)
    })
    .receive("error", resp => {
      console.log(`Unable to leave channel ${cid}`, resp)
    })
}

function setupChannelToggles(channels) {
  $(".channel-toggle").on("click", function() {
    const cid = $(this).attr("data-channel-id")
    let c = channels[cid]

    if (!c.enabled) joinChannel(cid, channels)
    else leaveChannel(cid, channels)
  })
}

function onNewTweet(tweet) {
  if (!isPlaying) { return }

  // Ignore retweets.
  //if (tweet.text.startsWith("RT")) { return }

  tweetsContainer.prepend(renderCard(tweet))
  updateTimestamps()
}

function renderCard(tweet) {
  return `
    <div class="card-container animated flipInX">
      <div class="row">
        <div class="col-sm-3">
          <div class="created-at" data-timestamp="${tweet.created_at}"></div>
        </div>
        <div class="col-sm-9">
          <div class="card ${tweet.topic}">
            <a class="github-fork-ribbon" title=""></a>
            <div class="user">
              <div class="user-profile-image">
                <img src="${tweet.user.profile_image_url_https}" />
              </div>
              <div class="user-info">
                <div class="user-name">${tweet.user.name}</div>
                <div class="user-screen-name">@${tweet.user.screen_name}</div>
              </div>
            </div>
            <div class="tweet">${tweet.text}</div>
            <div class="location">from ${tweetLocation(tweet)}</div>
          </div>
        </div>
      </div>
    </div>
  `
}

/*
 * Convert timestamps to "time from now" format.
 */
function updateTimestamps() {
  $("[data-timestamp]").each(function() {
    $(this).text(moment($(this).attr("data-timestamp")).fromNow())
  })
}

function tweetLocation(tweet) {
  if (tweet.place && tweet.place.name) return tweet.place.name
  else return "somewhere"
}

function setupPlayControl() {
  $(".play-control").on("mousedown", function() {
    isPlaying = !isPlaying
    $(this).toggleClass("pause play");
  });

  $(document).on("keyup", function(e) {
    if (e.which == 32) {
      isPlaying = !isPlaying
      $(".play-control").toggleClass("pause play");
    }
  });
}

export default socket
