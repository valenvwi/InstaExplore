import { Controller } from "@hotwired/stimulus";
import { createConsumer } from "@rails/actioncable";

export default class extends Controller {
  static values = { chatroomId: Number };
  static targets = ["messages"];

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      {
        received: (data) =>
          this.insertMessageAndScrollDown(data),
      }
    );
    console.log(`This is chatroom ZZZ2 ${this.chatroomIdValue}.`);
    this.messagesTarget.lastElementChild.scrollIntoView();
    this.input = document.querySelector("#message_content");
  }

  insertMessageAndScrollDown(data) {
    this.messagesTarget.insertAdjacentHTML("beforeend", data);
    console.log(this.messagesTarget)
    this.messagesTarget.lastElementChild.scrollIntoView();
    this.resetForm();
  }

  resetForm() {
    this.input.value = "";
  }

  disconnect() {
    console.log("Unsubscribed from the chatroom");
    this.channel.unsubscribe();
  }
}
