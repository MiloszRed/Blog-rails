<template>
    <h1>Create Post</h1>
    <form @submit="onSubmit">
        <div class="field mb-3">
            <input type="text" v-model="title" placeholder="Add Title..." class="form-control"/>
        </div>

        <div class="field mb-3">
            <input type="text" v-model="body" placeholder="Content..." class="form-control"/>
        </div>

        <input type="file" name="images" id="images" placeholder="images" multiple/>

        <div class="actions">
            <input type="submit" value="Submit" class="btn btn-secondary mt-3"/>
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
            const form = event.target
            const formData = new FormData()
            formData.append('post[title]', this.title)
            formData.append('post[body]', this.body)
            for (let i = 0; i < form.images.files.length; i++) {
                formData.append('post[images][]', form.images.files[i], form.images.files[i].name)
            }

            this.addPost(formData)
    
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