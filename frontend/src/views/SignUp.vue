<template>
    <div v-for="error in errorsAuth" :key="error" class="alert alert-danger alert-dismissible fade show" role="alert">
      {{ error }}
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <h2>Sign Up</h2>

    <div class="field mb-3">
        <label for="email" class="form-label">Email</label>
        <input type="email" v-model="email" class="form-control">
    </div>

    <div class="field mb-3">
        <label for="password" class="form-label">Password</label>
        <input type="password" v-model="password" class="form-control">
    </div>

    <div class="field mb-3">
        <label for="password-confirmation" class="form-label">Password confirmation</label>
        <input type="password" v-model="password_confirmation" class="form-control">
    </div>

    <div class="actions mb-2">
        <button @click="signup" class="btn btn-primary">Sign Up</button>
    </div>

</template>

<script>
import {mapActions, mapGetters} from 'vuex';
// import axios from 'axios';
// import router from '../router';

export default {
    data() {
        return {
            name: "",
            email: "",
            password: "",
            password_confirmation: "",
        };
    },
    methods: {
        ...mapActions(['signup']),
        signup(){
            const authData = {
                email: this.email,
                password: this.password,
                password_confirmation: this.password_confirmation
            }
            this.$store.dispatch('signup', authData)
            this.email = ''
            this.password = ''
            this.password_confirmation = ''
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