import axios from 'axios';
import router from '@/router';
const api_url = "http://localhost:3000/api/v1/posts";
const api_url_admin = "http://localhost:3000/api/v1/admin/posts";

const state = {
    posts: [],
    comments: [],
    postErrors: [],
    postSuccess: []
};

const getters = {
    allPosts: (state) => state.posts,
    allComments: (state) => state.comments,
    allPostErrors: (state) => state.postErrors,
    allPostSuccess: (state) => state.postSuccess
};

const actions = {
    async fetchPosts({ commit }) {
        const response = await axios.get(api_url);
        commit('setPosts', response.data)
    },
    async fetchComments({ commit }, id) {
        const response = await axios.get(api_url + `/${id}/comments`);
        commit('setComments', response.data)
    },
    addPost({ commit }, post) {
        axios.post(api_url_admin,{
                post: {
                    title: post.title,
                    body: post.body,
                }
            }, { withCredentials: true })
        .then((response) => {
            console.log(response)       
            commit('newPost', response.data);
            commit('setSuccessPost', "Post successfully created");
            router.push("/")
        })
        .catch((error) => {
            console.log(error.response)
            if(error.response.status == 422)
                commit('setErrorPost', error.response.data.errors)
            else if(error.response.status == 401)
                router.push("/sign_in")
        });
    },
    addComment({ commit }, post) {
        axios.post(api_url + `/${post.id}/comments`,{
                comment: {
                    body: post.body
                }
            }, { withCredentials: true })
        .then((response) => {
            commit('newPost', response.data);
        })
        .catch((error) => {
            console.log(error.response)
            if(error.response.status == 422)
                commit('setErrorPost', error.response.data.errors)
            else if(error.response.status == 401)
                router.push("/sign_in")
        });
    },
    deleteComment({ commit }, post) {
        axios.delete(api_url + `/${post.postId}/comments/${post.commentId}`, { withCredentials: true })
        .then((response) => {
            console.log(response)
            commit('deleteComment', post.commentId);
        })
        .catch((error) => {
            console.log(error.response)
            if(error.response.status == 422)
                commit('setErrorPost', error.response.data.errors)
            else if(error.response.status == 401)
                router.push("/sign_in")
        });
    },
    deletePost({ commit }, post) {
        axios.delete(api_url_admin + `/${post.id}`, { withCredentials: true })
        .then((response) => {
            console.log(response)
            commit('removePost', post.id);
            commit('setSuccessPost', "Post successfully deleted");
            router.push("/")
        })
        .catch((error) => {
            console.log(error.response)
            if(error.response.status == 422)
                commit('setErrorPost', error.response.data.errors)
            else if(error.response.status == 401)
                router.push("/sign_in")
        });
    },
    updatePost({ commit }, post) {
        axios.put(api_url_admin + `/${post.id}`,{
            post: {
                title: post.title,
                body: post.body
            }
        }, { withCredentials: true })
        .then((response) => {
            console.log(response)       
            commit('setUpdatedPost', response.data);
            commit('setSuccessPost', "Post successfully updated");
            router.push("/posts/" + `${post.id}`)
        })
        .catch((error) => {
            console.log(error.response)
            if(error.response.status == 422)
                commit('setErrorPost', error.response.data.errors)
            else if(error.response.status == 401)
                router.push("/sign_in")
        });
    }
};

const mutations = {
    setPosts: (state, posts) => (state.posts = posts),
    setComments: (state, comments) => (state.comments = comments),
    newPost: (state, post) => (state.posts.unshift(post)),
    removePost: (state, id) => 
        (state.posts = state.posts.filter(post => post.id != id)),
    deleteComment: (state, id) => 
        (state.comments = state.comments.filter(comment => comment.id != id)),
    setErrorPost: (state, error) => (state.postErrors.push(error)),
    setSuccessPost: (state, msg) => (state.postSuccess.push(msg)),
    setUpdatedPost: (state, updatedPost) => {
        const index = state.posts.findIndex(post => post.id === updatedPost.id);
        if(index !== -1)
            state.posts.splice(index, 1, updatedPost);
    },
}

export default {
    state,
    getters,
    actions,
    mutations
}