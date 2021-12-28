import {createRouter, createWebHistory} from 'vue-router'

import Posts from '../views/Posts'
import Show from '../views/Show'
import CreatePost from '../views/admin/CreatePost'
import UpdatePost from '../views/admin/UpdatePost'
import SignIn from '../views/SignIn'
import SignUp from '../views/SignUp'
import EditProfile from '../views/EditProfile'

const routes = [
    {
        path: '/',
        name: 'Posts',
        component: Posts
    },
    {
        path: '/posts/:id',
        name: 'Show',
        component: Show,
        props: true
    },
    {
        path: '/new_post',
        name: 'CreatePost',
        component: CreatePost,
    },
    {
        path: '/posts/:id/update',
        name: 'UpdatePost',
        component: UpdatePost,
        props: true
    },
    {
        path: '/sign_in',
        name: 'SignIn',
        component: SignIn,
    },
    {
        path: '/sign_up',
        name: 'SignUp',
        component: SignUp,
    },
    {
        path: '/edit_profile',
        name: 'EditProfile',
        component: EditProfile,
    },
]

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes
})

export default router;