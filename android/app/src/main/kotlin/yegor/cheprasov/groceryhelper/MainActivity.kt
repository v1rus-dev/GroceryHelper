package yegor.cheprasov.groceryhelper

import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle
import android.view.WindowManager
import androidx.core.view.WindowCompat

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Настройка системных цветов
        WindowCompat.setDecorFitsSystemWindows(window, false)
        
        // Установка прозрачного статус бара
        window.statusBarColor = android.graphics.Color.TRANSPARENT
        window.navigationBarColor = android.graphics.Color.TRANSPARENT
        
        // Настройка флагов для правильного отображения
        window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
    }
} 