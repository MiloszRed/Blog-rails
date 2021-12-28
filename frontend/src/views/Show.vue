<template>
<div ref="document">
    <div class="card w-75">
        <div class="card-body">
            <h5 class="card-title fw-bold" v-if="allPosts != undefined && allPosts.length != 0"> {{ allPosts.find(post => post.id == id).title }} </h5>
            <p class="card-text" v-if="allPosts != undefined && allPosts.length != 0"> {{ allPosts.find(post => post.id == id).body }}  </p>
            
            <router-link to="/" class="btn btn-dark me-1" >Back</router-link>
            <button @click="createPDF" class="btn btn-dark me-1" >Create PDF</button>
            <router-link :to="{ name: 'UpdatePost', params: { 
                    id: id,
                    title2: allPosts.find(post => post.id == id).title,
                    body2: allPosts.find(post => post.id == id).body  
                }}" v-if="admin != 'false' && admin" class="btn btn-primary me-1" >Update</router-link>
            <button v-if="admin != 'false' && admin" @click="removePost()" class="btn btn-danger" >Delete</button>
        </div>
    </div>

    <br />
    <h3>Comments</h3>
    <div v-for="comment in allComments" :key="comment.id" class="card w-75 mb-3 bg-light">
        <div class="card-body">         
            <h5 class="card-title fw-bold"> {{ comment.username }} </h5>
            <p class="card-text"> {{ comment.body }} </p>

            <span v-if="userId == comment.user_id" @click="removeComment(comment.id)" class="text-danger text-decoration-none" >Delete</span>
        </div>
    </div>
    <br />
    <h4 class="fw-bold ">Add comment</h4>
    <form @submit="onSubmit" class="w-75 mb-3">
        <div class="field mb-3">
            <textarea type="text" v-model="comment" placeholder="Conmment..." class="form-control"/>
        </div>

        <div class="actions">
            <input type="submit" value="Submit" class="btn btn-secondary"/>
        </div>
    </form>
</div>
</template>

<script>
import {mapGetters, mapActions} from 'vuex';
import html2pdf from 'html2pdf.js';

export default {
    name: 'Show',
    props: ['id'],
    data() {
        return {
            comment: ""
        }
    },
    methods: {
        ...mapActions(['fetchPosts', 'deletePost', 'fetchComments', 'addComment', 'deleteComment']),
        removePost() {
            const post = {
                id: this.id,
            }
            this.deletePost(post);
        },
        removeComment(commentId) {
            const post = {
                postId: this.id,
                commentId: commentId,
            }
            this.deleteComment(post);
        },
        onSubmit(){
            const post = {
                body: this.comment,
                token: this.token,
                id: this.id
            }
            this.addComment(post);
        },
        createPDF(){
           html2pdf(this.$refs.document, {
                    margin: 1,
                    filename: 'document.pdf',
                    image: { type: 'jpeg', quality: 0.98 },
                    html2canvas: { dpi: 192, letterRendering: true },
                    jsPDF: { unit: 'in', format: 'letter', orientation: 'landscape' 
                }
			})
        }
    },
    computed: {
        ...mapGetters(['allPosts', 'allComments', 'admin', 'userId']),
    },
    created() {
        this.fetchPosts();
        this.fetchComments(this.id);
    }
}
</script>

<style scoped>
span {
    cursor: pointer;
}
</style>