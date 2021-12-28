<template>
    <h1>Update Post</h1>
    <form @submit="onSubmit">
        <div class="field mb-3">
            <input type="text" v-model="title" class="form-control"/>
        </div>

        <div class="field mb-3">
            <input type="text" v-model="body" class="form-control"/>
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
    name: "UpdatePost",
    props: ['id', 'title2', 'body2'],
    data() {
        return {
            title: this.title2,
            body: this.body2
        }
    },
    computed: {
        ...mapGetters(['admin'])
    },
    methods: {
        ...mapActions(['updatePost']),
        onSubmit(event) {
            event.preventDefault();
            const post = {  
                id: this.id,
                title: this.title,
                body: this.body  
            }
            this.updatePost(post);     
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