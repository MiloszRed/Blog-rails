<template>
  <Header />
  <div class="container">
    <div v-for="error in errorsAuth" :key="error" class="alert alert-danger alert-dismissible fade show" role="alert">
      {{ error["err"] }}
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <div v-for="error in allPostErrors" :key="error" class="alert alert-danger alert-dismissible fade show" role="alert">
      {{ error["err"] }}
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <div v-for="success in successAuth" :key="success" class="alert alert-success alert-dismissible fade show" role="alert">
      {{ success }}
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <div v-for="success in allPostSuccess" :key="success" class="alert alert-success alert-dismissible fade show" role="alert">
      {{ success }}
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <router-view></router-view>
  </div>
</template>

<script>
import Header from '@/components/Header'
import {mapGetters} from 'vuex';

export default {
  name: "App",
  computed: {
    ...mapGetters(['errorsAuth', 'successAuth', 'allPostErrors', 'allPostSuccess']),
  },
  components: {
    Header,
  },
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
}
</style>
