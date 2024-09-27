// eslint-disable-next-line no-undef

// eslint-disable-next-line no-undef
const socket = io();

const urlSearch = new URLSearchParams(window.location.search);
const username = urlSearch.get("username");
const room = urlSearch.get("select_room");

socket.emit("select_room", { username, room });

const roomName = document.getElementById("room-name");

roomName.innerText += " " + room;
document
  .getElementById("message_input")
  .addEventListener("keypress", (event) => {
    if (event.key === "Enter") {
      const message = event.target.value;

      const data = {
        message,
        room,
        username,
      };

      socket.emit("message", data);

      event.target.value = "";
    }
  });

socket.on("message", (data) => {
  const messageDiv = document.getElementById("messageContainer");
  const messageParagraph = document.createElement("p");
  messageParagraph.classList.add("message");
  messageParagraph.textContent = `${data.username}: ${data.message}`;
  messageDiv.appendChild(messageParagraph);
});
