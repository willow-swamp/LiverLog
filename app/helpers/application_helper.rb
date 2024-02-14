module ApplicationHelper
  def default_meta_tags
    {
      site: '肝ログ 〜LiverLog〜',
      reverse: true,
      separator: '|',
      og: default_og,
      twitter: default_twitter
    }
  end

  private

  def default_og
    {
      title: :title,
      description: '『肝ログ』は、休肝日と飲酒日を記録することで、飲酒管理ができるサービスです。
      ついつい飲み過ぎてしまう方、適度に飲酒したい方などご自分の飲酒について見直すきっかけになるアプリです！ぜひご活用ください🍻',
      url: request.url,
      image: image_url('app_logo.png')
    }
  end

  def default_twitter
    {
      card: 'summary',
      site: '@liverlog'
    }
  end
end
