import axios from 'axios';
import router from '@/router'

const state = {
    admin: false,
    signedIn: false,
    userId: null,
    errors: [],
    success: [],
};

const getters = {
    admin: (state) => state.admin,
    signedIn: (state) => state.signedIn,
    userId: (state) => state.userId,
    errorsAuth: (state) => state.errors,
    successAuth: (state) => state.success,
};

const actions = {
    signin({ commit }, authData) {
        axios.post(process.env.VUE_APP_API_USERS_URL + '/sign_in', {
            user: {
                email: authData.email,
                password: authData.password,
            }
        }, { withCredentials: true })
        .then((response) => {
            commit('updateAdmin', response.data.admin)
            commit('updateSignedIn', response.data.signedIn)
            commit('updateUserId', response.data.userId)
            commit('updateSuccess', "Successfully Signed In")
            router.push("/");
        })
        .catch((error) => {
            commit('updateErrors', error.response.data.errors['err'])
        });
    },
    signup({ commit }, authData) {
        axios.post(process.env.VUE_APP_API_USERS_URL,
            {
                user: {
                    email: authData.email,
                    password: authData.password,
                    password_confirmation: authData.password_confirmation,
                }
            }, { withCredentials: true })
        .then((response) => {
            commit('updateAdmin', response.data.admin)
            commit('updateSignedIn', response.data.signedIn)
            commit('updateUserId', response.data.userId)
            commit('updateSuccess', "Successfully Signed Up")
            router.push('/')
        })
        .catch((error) => {
            for(const err in error.response.data.errors)
                commit('updateErrors', err +" "+ error.response.data.errors[err])
        });
    },
    editProfile({ commit }, authData) {
        axios.put(process.env.VUE_APP_API_USERS_URL,
            {
                user: {
                    current_password: authData.current_password,
                    password: authData.password,
                    password_confirmation: authData.password_confirmation,
                    user_id: authData.userId
                }
            }, { withCredentials: true })
        .then(() => {
            commit('updateSuccess', "Successfully changed password")
            router.push('/')
        });
    },
    cancelProfile({ commit }) {
        axios.delete(process.env.VUE_APP_API_USERS_URL, { withCredentials: true })
        .then(() => {
            commit('updateSuccess', "Successfully canceled account")
            commit('updateAdmin', false)
            commit('updateSignedIn', false)
            commit('updateUserId', null)
            router.push('/')
        })
        .catch((error) => {
            commit('updateErrors', error.response.data.errors)
        });
    },
    signout({ commit }){
        axios.delete(process.env.VUE_APP_API_USERS_URL + '/sign_out', { withCredentials: true })
        commit('updateAdmin', false)
        commit('updateSignedIn', false)
        commit('updateUserId', null)
        router.push('/')
    },
    reload({ commit }) {
        commit('updateAdmin', localStorage.getItem("admin"))
        commit('updateSignedIn', localStorage.getItem("signedIn"))
        commit('updateUserId', localStorage.getItem("userId"))
        commit('updateErrorsReload')
        commit('updateSuccessReload')
    },
};

const mutations = {
    updateAdmin(state, admin) {
        localStorage.setItem("admin", admin);
        state.admin = admin
    },
    updateSignedIn(state, signedIn) {
        localStorage.setItem("signedIn", signedIn);
        state.signedIn = signedIn
    },
    updateUserId(state, userId) {
        localStorage.setItem("userId", userId);
        state.userId = userId
    },
    updateErrors(state, error)
    {
        state.errors.push(error);
    },
    updateErrorsReload(state)
    {
        state.errors = [];
    },
    updateSuccess(state, msg)
    {
        state.success.push(msg);
    },
    updateSuccessReload(state)
    {
        state.success = [];
    }
}

export default {
    state,
    getters,
    actions,
    mutations
}