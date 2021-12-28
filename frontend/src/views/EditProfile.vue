<template>
    <h2>Edit Profile</h2>

    <div class="field mb-3">
        <label for="password" class="form-label">New Password</label>
        <input type="password" v-model="password" class="form-control">
    </div>

    <div class="field mb-3">
        <label for="password-confirmation" class="form-label">New Password confirmation</label>
        <input type="password" v-model="password_confirmation" class="form-control">
    </div>

    <div class="field mb-3">
        <label for="password-confirmation" class="form-label">Current Password</label>
        <input type="password" v-model="currentPassword" class="form-control">
    </div>

    <div class="actions mb-2">
        <button @click="change" class="btn btn-primary">Submit</button>
    </div>

    <h1> Cancel my account </h1>
    <button @click="cancel" class="btn btn-danger">Cancel</button>


</template>

<script>
import {mapActions, mapGetters} from 'vuex';
// import axios from 'axios';
// import router from '../router';

export default {
    name: "EditProfile",
    data() {
        return {
            name: "",
            email: "",
            password: "",
            password_confirmation: "",
            currentPassword: ""
        };
    },
    computed: {
        ...mapGetters(['userId'])
    },
    methods: {
        ...mapActions(['signup']),
        change(){
            const authData = {
                current_password: this.currentPassword,
                password: this.password,
                password_confirmation: this.password_confirmation,
                userId: this.userId
            }
            this.$store.dispatch('editProfile', authData)
            this.currentPassword = ''
            this.password = ''
            this.password_confirmation = ''
        },
        cancel() {
            this.$store.dispatch('cancelProfile')
        }
    }
}
</script>

<style>

</style>