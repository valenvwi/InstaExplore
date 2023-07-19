import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable";

export default class extends Controller {
  static values = { chatroomId: Number };
  static targets = ["messages"];

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      {
        received: (data) =>
          this.messagesTarget.insertAdjacentHTML("beforeend", data),
      }
    );
    console.log(
      `This is chatroom ${this.chatroomIdValue}.`
    );
    this.input = document.querySelector("#message_content");
  }

  insertMessageAndScrollDown(data) {
    console.log(data, this.input);
    this.messagesTarget.insertAdjacentHTML("beforeend", data);
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight);
    this.resetForm();
  }

  resetForm(event) {
    console.log("reset form", this.input, event);
    this.input.value = "";
  }

  disconnect() {
    console.log("Unsubscribed from the chatroom");
    this.channel.unsubscribe();
  }
}
