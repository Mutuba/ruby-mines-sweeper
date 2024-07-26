// import { Controller } from "stimulus";
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["levelSelect", "customSettings"];

  connect() {
    this.toggleCustomSettings();
  }

  toggleCustomSettings() {
    const isCustomLevel = this.levelSelectTarget.value === "";
    this.customSettingsTarget.classList.toggle("d-none", !isCustomLevel);
  }

  change(event) {
    this.toggleCustomSettings();
  }
}
