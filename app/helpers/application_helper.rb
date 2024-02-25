module ApplicationHelper
  def default_meta_tags
    {
      site: '肝ログ 〜LiverLog〜',
      title: :title,
      reverse: true,
      description: '『肝ログ』は、休肝日と飲酒日を記録することで、飲酒管理ができるサービスです。ついつい飲み過ぎてしまう方、適度に飲酒したい方などご自分の飲酒について見直すきっかけになるアプリです！ぜひご活用ください🍻',
      keywords: '肝ログ,休肝日,飲酒日,飲酒管理,飲酒記録,飲酒量,飲酒量管理,飲酒量記録,健康に配慮した飲酒に関するガイドライン',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        url: request.original_url,
        image: image_url('apple-touch-icon.png'),
        type: 'website',
        description: :description
      },
      twitter: {
        card: 'summary_large_image',
        site: '@liverlog'
      }
    }
  end
end
