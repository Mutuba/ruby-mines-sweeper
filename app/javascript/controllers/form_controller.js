import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["levelSelect", "customSettings"];

  connect() {
    this.toggleCustomSettings();
  }

  toggleCustomSettings() {
    const selectedLevel = this.levelSelectTarget.value;
    const isCustomLevel = selectedLevel === "Custom";
    this.customSettingsTarget.classList.toggle("d-none", !isCustomLevel);
  }

  change() {
    this.toggleCustomSettings();
  }
}
