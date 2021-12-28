<template>
    <h1>Create Post</h1>
    <form @submit="onSubmit">
        <div class="field mb-3">
            <input type="text" v-model="title" placeholder="Add Title..." class="form-control"/>
        </div>

        <div class="field mb-3">
            <input type="text" v-model="body" placeholder="Content..." class="form-control"/>
        </div>

        <div class="actions">
            <input type="submit" value="Submit" class="btn btn-secondary"/>
        </div>
    </form>
</template>

<script>
import { mapActions, mapGetters } from 'vuex';
import router from "@/router"

export default {
    name: "CreatePost",
    data() {
        return {
            title: "",
            body: ""
        }
    },
    computed: {
        ...mapGetters(['admin'])
    },
    methods: {
        ...mapActions(['addPost']),
        onSubmit(event) {
            event.preventDefault();
            const post = {  
                title: this.title,
                body: this.body  
            }
            this.addPost(post);     
            this.title = "";
            this.body = "";
        }
    },
    created() {
        if(this.admin == 'false' || !this.admin)
            router.push("/sign_in")
    }
}
</script>

<style>

</style>