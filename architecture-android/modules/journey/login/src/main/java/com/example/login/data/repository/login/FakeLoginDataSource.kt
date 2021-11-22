package com.example.login.data.repository.login


class FakeLoginDataSource : LoginDataSource {
    override fun signUp(email: String?, password: String?): Boolean {
        return false
    }

    override fun signIn(email: String?, password: String?): Boolean {
        return true
    }

    override fun checkAlreadyAuthenticated(): Boolean {
        return false
    }

    override fun signOut(email: String?): Boolean {
        return false
    }

    companion object {
        private const val FAKE_NICKNAME_1 = "Jeanette Allen"
        private const val FAKE_NICKNAME_2 = "Alex Willis"
        private const val FAKE_NICKNAME_3 = "Beth Berry"
        private const val FAKE_AVATAR_URL_1 = "https://randomuser.me/api/portraits/women/2.jpg"
        private const val FAKE_AVATAR_URL_2 = "https://randomuser.me/api/portraits/men/37.jpg"
        private const val FAKE_AVATAR_URL_3 = "https://randomuser.me/api/portraits/women/68.jpg"
    }
}