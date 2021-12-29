<template>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <router-link class="navbar-brand" to="/">Blog</router-link>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <router-link class="nav-link active" to="/">Home</router-link>
                    </li>
                    <li class="nav-item">
                        <router-link class="nav-link" to="/">Posts</router-link>
                    </li>
                    <template v-if="!lib.userSignedIn(signedIn)">
                        <li class="nav-item">
                            <router-link class="nav-link" to="/sign_in">Sign In</router-link>
                        </li>
                        <li class="nav-item">
                            <router-link class="nav-link" to="/sign_up">Sign Up</router-link>
                        </li>
                    </template>
                    <template v-else>
                        <li class="nav-item">
                            <router-link to="/edit_profile" class="nav-link header-item">Edit Profile</router-link>
                        </li>
                        <li class="nav-item">
                            <span @click="signout" class="nav-link header-item">Sign Out</span>
                        </li>
                    </template>
                </ul>                   

                <router-link v-if="lib.isAdmin(admin)" class="btn btn-outline-success" to="/new_post">Create new Post</router-link>
            </div>
        </div>
    </nav>
</template>

<script>
import {mapGetters, mapActions} from 'vuex';

export default {
    name: 'Header',
    data() {
        return {
            lib: require('@/lib/methods').default
        }
    },
    computed: {
        ...mapGetters(['admin', 'signedIn']),
    },
    methods: {
        // isAdmin(){
        //     return this.admin != "false" && this.admin != null && this.admin != false && this.admin != "null";
        // },
        // userSignedIn(){
        //     return this.signedIn && this.signedIn != "null" && this.signedIn != "false";
        // },
        ...mapActions(['signout']),
        signout(){
            this.$store.dispatch('signout')
        }
    },
    created(){
        this.$store.dispatch('reload')
    },
}
</script>

<style scoped>
.header-item{
    cursor: pointer;
}
.d-flex {
    display: block !important;
}
.navbar {
    margin-bottom: 20px;
}
</style>