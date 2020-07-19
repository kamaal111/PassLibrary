package kamaal111.reactnativepasslibrary.passlibrary

import android.graphics.Color
import com.facebook.react.common.MapBuilder
import com.facebook.react.module.annotations.ReactModule
import com.facebook.react.uimanager.SimpleViewManager
import com.facebook.react.uimanager.ThemedReactContext
import com.facebook.react.uimanager.annotations.ReactProp

@ReactModule(name = PassLibraryManager.reactClass)
class PassLibraryManager : SimpleViewManager<PassLibrary>() {

  companion object {
    const val reactClass = "RNPLPassLibrary"
  }

  override fun getName(): String {
    return reactClass
  }

}
