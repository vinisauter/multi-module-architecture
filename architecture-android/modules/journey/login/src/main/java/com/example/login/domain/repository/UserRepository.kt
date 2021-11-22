package com.example.login.domain.repository

import com.example.login.domain.models.User

interface UserRepository {
    fun getUser(userId: String?): User?
    fun putUser(user: User?): Boolean?
}