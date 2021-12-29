const methods = {
    isAdmin(admin) {
        return admin != "false" && admin != null && admin != false && admin != "null";
    },
    userSignedIn(signedIn) {
        return signedIn && signedIn != "null" && signedIn != "false";
    }
}

export default methods