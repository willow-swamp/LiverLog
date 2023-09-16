# LiverLog

## サービス概要
肝ログ（LiverLog）は、休肝日と飲酒日を記録することで、飲酒管理ができるサービスです。

##　想定されるユーザー層
飲酒の習慣があるが、健康を意識して適度に飲酒したい人
休肝日を設けて、その日を守りたいと考える人

## サービスコンセプト
自分はお酒を飲むのが好きなのですが、年齢を重ねるにつれて健康診断で肝臓の数値が悪くなってきていることに気づきました。
しかし、大好きなお酒を控えることができず、なかなか休肝日を作ることができませんでした。
そこで、休肝日などの自分の飲酒を記録することで、飲酒管理をすることができるサービスを作ろうと思いました。
肝ログでは、ユーザが日常の飲酒習慣を管理し、健康的な飲酒生活をサポートするできるようなサービスにしていきたいと考えています。

## 実装を予定している機能
### MVP
* LINEアカウントでログイン
  * 初回ログイン時に休肝日をあらかじめ登録する
* 休肝日&飲酒履歴の表示
  * カレンダー形式でユーザの休肝日と飲酒日を表示する
  * 月曜日から日曜日までを1週間として、1週間の休肝日と飲酒日の数を表示する。詳細な飲酒記録をしているユーザは総アルコール摂取量を表示する（前週との差も表示）
  * 1ヶ月間の休肝日達成率を表示する。詳細な飲酒記録をしているユーザについては1ヶ月間の総アルコール摂取量を表示する（前月との差も表示）
* 休肝日&飲酒記録の登録
  * ワンタップで簡単に休肝日または飲酒日を記録できる
  * 飲酒日については、より詳しい飲酒の情報（飲んだお酒の種類や量）を、必要なユーザだけがオプションとして入力できるようにする
  * 詳細な飲酒の情報として、お酒の量（ml）、アルコール度数（%）を入力できる。入力した情報から、アルコール摂取量を自動で計算する。（計算式についてはhttps://www.e-healthnet.mhlw.go.jp/information/alcohol/a-02-001.htmlを参考）
* 休肝日&飲酒記録の詳細を表示
* 休肝日のリマインダー機能
  * LINE Messaging API及びLINE Messaging API SDK for Rubyを用いて、あらかじめ登録された休肝日にLINEでリマインダーを送る
* 休肝日&飲酒記録の振り返り機能
  * LINE Messaging API及びLINE Messaging API SDK for Rubyを用いて、1週間の休肝日の数や総アルコール摂取量をまとめた通知を送る
* 友人や家族と休肝日&飲酒記録の共有
  * 友人や家族をアプリに招待し、グループを作成して休肝日と飲酒記録の共有し、友人・家族がユーザの飲酒状況を確認できる
  * グループのユーザは利用ユーザに対して励ましなどのコメントができる

### その後の機能
* 飲酒状況のグラフ化
* 休肝日のモチベーション向上機能
  * 休肝日を記録すると、励ましのメッセージを表示
  * 連続で休肝日または飲酒記録を登録すると、連続記録日数を表示
* コミュニティ機能
  * 他のユーザーと休肝日の経過や成功体験を投稿する
    * 投稿一覧を表示
    * 投稿詳細を表示
    * 投稿に対してコメントをする
    * 投稿に対していいねをする

### 機能の実装方針予定
* Ruby: 3.0系
* Rails: 7.0系
* CSSフレームワーク: Tailwind CSS, daisyUI
* ユーザ登録及び認証機能: devise
* ユーザ招待機能: devise_invitable
* 画像アップロード: Active Storage
* カレンダー表示: simple_calendar
* グラフ表示: chartkick
* LINE通知: LINE Messaging API及びLINE Messaging API SDK for Ruby

### 画面遷移図
Figma：https://www.figma.com/file/U2WJ5uU9adWanRfoHdO6BJ/%E8%82%9D%E3%83%AD%E3%82%B0%EF%BC%88LiverLog%EF%BC%89?type=design&node-id=14%3A38&mode=design&t=HXMrChrXeIq5pcmc-1

### ER図
![Alt text](LiverLog.drawio.png)