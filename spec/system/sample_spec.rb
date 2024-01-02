require 'rails_helper'

RSpec.describe 'sample', type: :system do
  it 'sample scenario' do
    # 例えばルートパスにアクセスできることを確認
    visit root_path
    expect(current_path).to eq root_path
  end
end
