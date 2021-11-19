package com.example.core

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding

/**
 * Base activity
 *
 * Only need to provide layout resource id and inject the viewmodel.
 *
 * */
abstract class NextBaseActivity<DataBindingType : ViewDataBinding, out ViewModelType : NextBaseViewModel, out NavigationType : NextBaseNavigation>
    : AppCompatActivity() {

    lateinit var mViewDataBinding: DataBindingType

    protected abstract val mViewModel: ViewModelType
    protected abstract val mNavigation: NavigationType

    abstract val mLayoutId: Int

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        mViewDataBinding = DataBindingUtil.setContentView(this, mLayoutId)
        mViewDataBinding.lifecycleOwner = this
        mViewDataBinding.executePendingBindings()
    }

}