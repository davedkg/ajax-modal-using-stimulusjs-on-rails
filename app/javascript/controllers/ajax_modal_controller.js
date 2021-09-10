import { Controller } from "stimulus"

export default class extends Controller {
  success(event) {
    const [data, status, xhr] = event.detail

    // append modal html to body
    const $modal = $(xhr.response).appendTo('body')

    // open modal with animation
    $modal.modal()

    // remove modal html from body after modal closes
    $modal.on("hidden.bs.modal", () => $modal.remove())
  }

  error(event) {
    console.log("modal:error", event)
  }
}