module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins : [
    require('daisyui'),
  ],
  daisyui: {
    themes: [
      {
        mytheme: {
          "primary": "#34D399",   // やや明るめの緑
          "secondary": "#60A5FA", // 明るい青
          "accent": "#93329E",    // ワインカラーの紫
          "neutral": "#9CA3AF",   // 中間のグレイ
          "base-100": "#F3F4F6",  // 軽やかな背景色
          "info": "#3B82F6",      // インフォメーション用の青
          "success": "#10B981",   // 成功の緑
          "warning": "#F59E0B",   // 警告のオレンジ
          "error": "#EF4444",     // エラーの赤
        },
      },
    ],
  },
}
