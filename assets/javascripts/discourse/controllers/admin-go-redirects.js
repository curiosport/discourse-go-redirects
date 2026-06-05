import Controller from "@ember/controller";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import { ajax } from "discourse/lib/ajax";
import { popupAjaxError } from "discourse/lib/ajax-error";

export default class AdminGoRedirectsController extends Controller {
  @tracked redirects = [];
  @tracked slug = "";
  @tracked destination = "";
  @tracked selectedId = null;

  get canAdd() {
    return this.slug.trim().length > 0 && this.destination.trim().length > 0;
  }

  get canRemove() {
    return this.selectedId !== null;
  }

  setupModel(model) {
    this.redirects = model.redirects || [];
  }

  @action
  selectRow(id) {
    this.selectedId = this.selectedId === id ? null : id;
  }

  @action
  async addRedirect() {
    if (!this.canAdd) return;
    try {
      const result = await ajax("/admin/go-redirects.json", {
        method: "POST",
        data: { slug: this.slug.trim(), destination: this.destination.trim() },
      });
      this.redirects = [...this.redirects, result.redirect].sort((a, b) =>
        a.slug.localeCompare(b.slug)
      );
      this.slug = "";
      this.destination = "";
    } catch (e) {
      popupAjaxError(e);
    }
  }

  @action
  async removeRedirect() {
    if (!this.canRemove) return;
    try {
      await ajax(`/admin/go-redirects/${this.selectedId}.json`, {
        method: "DELETE",
      });
      this.redirects = this.redirects.filter((r) => r.id !== this.selectedId);
      this.selectedId = null;
    } catch (e) {
      popupAjaxError(e);
    }
  }
}
