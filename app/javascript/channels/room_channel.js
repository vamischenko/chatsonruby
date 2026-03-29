import consumer from "./consumer"

const messagesContainer = document.querySelector(".messages")

if (messagesContainer) {
  const roomId = messagesContainer.dataset.roomId

  consumer.subscriptions.create({ channel: "RoomChannel", room_id: roomId }, {
    received(data) {
      const messageHtml = buildMessage(data)
      messagesContainer.insertAdjacentHTML("beforeend", messageHtml)
      messagesContainer.scrollTop = messagesContainer.scrollHeight
    }
  })
}

function buildMessage(data) {
  const content = data.content ? escapeHtml(data.content) : ""
  return `
    <div class="message">
      <div class="upper-message">
        <div class="message-user">${escapeHtml(data.user_name)}</div>
        <div class="message-date">${escapeHtml(data.created_at)}</div>
      </div>
      <div class="lower-message">
        <div class="message-content">${content}</div>
      </div>
    </div>
  `
}

function escapeHtml(str) {
  if (!str) return ""
  return String(str)
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#39;")
}
