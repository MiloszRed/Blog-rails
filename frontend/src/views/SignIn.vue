<template>
    <div v-for="error in errorsAuth" :key="error" class="alert alert-danger alert-dismissible fade show" role="alert">
      {{ error }}
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>

    <h2>Sign In</h2>

    <div class="field mb-3">
        <label for="email" class="form-label">Email</label>
        <input type="email" v-model="email" class="form-control">
    </div>

    <div class="field mb-3">
        <label for="password" class="form-label">Password</label>
        <input type="password" v-model="password" class="form-control">
    </div>

    <div class="actions mb-2">
        <button @click="signin" class="btn btn-primary">Sign In</button>
    </div>

</template>

<script>
import {mapActions, mapGetters} from 'vuex';

export default {
    data() {
        return {
            name: "",
            email: "",
            password: "",
        };
    },
    methods: {
        ...mapActions(['signin']),
        signin(){
            const authData = {
                email: this.email,
                password: this.password,
            }
            this.$store.dispatch('signin', authData)
            this.email = '';
            this.password = '';
        }
    },
    computed: {
    ...mapGetters(['errorsAuth']),
    },
    mounted() {
        this.$store.dispatch('reload')
    }
}
</script>

<style>

</style>