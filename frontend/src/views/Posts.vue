<template>
    <h1>Posts</h1>
    <div v-for="post in allPosts" :key="post.id" class="card w-75 mb-3">
        <div class="card-body">   
            <h5 class="card-title fw-bold">{{ post.title }}</h5>
            <p class="card-text">{{ post.body }}</p>
            <router-link class="btn btn-primary" :to="{ name: 'Show', params: { id: post.id }}">Read More</router-link>
        </div>
    </div>
</template>

<script>
import {mapGetters, mapActions} from 'vuex';

export default {
    name: 'Posts',
    methods: {
        ...mapActions(['fetchPosts', 'reload']),
    },
    computed: {
        ...mapGetters(['allPosts'])
    },
    created() {
        this.fetchPosts();
        this.$store.dispatch('reload')
    }
}
</script>

<style scoped>

</style>