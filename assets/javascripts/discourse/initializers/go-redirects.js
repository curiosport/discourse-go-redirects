import { withPluginApi } from "discourse/lib/plugin-api";

export default {
  name: "go-redirects",

  initialize() {
    withPluginApi("1.2.0", (api) => {
      if (api.addAdminPluginRoute) {
        api.addAdminPluginRoute({
          name: "go-redirects",
          path: "/go-redirects",
        });
      }
    });
  },
};
