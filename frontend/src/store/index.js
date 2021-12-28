import { createStore } from "vuex";
import posts from "@/store/modules/posts"
import auth from "@/store/modules/auth"

export default createStore({
  modules: {
    posts,
    auth
  },
});
