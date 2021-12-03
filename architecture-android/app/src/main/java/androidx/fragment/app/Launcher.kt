package androidx.fragment.app

import androidx.annotation.LayoutRes

open class Launcher(@LayoutRes contentLayoutId: Int) : DialogFragment(contentLayoutId){
    var params: LauncherParams? = null

    data class LauncherParams(
        var graph: Int? = null
    )
}

