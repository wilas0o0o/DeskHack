require 'rails_helper'

describe 'postsコントローラーのテスト' do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:post_images) { create(:post_images) }
  let(:post) { create(:post, user: user) }
  let(:other_post) { create(:post, user: other_user) }

  before do
    visit new_user_session_path
    fill_in 'user[login]', with: user.username
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe '新規投稿のテスト' do
    before do
      visit new_post_path
    end

    context '表示内容の確認' do
      it 'new_post_pathが"/posts/new"である' do
        expect(current_path).to eq('/posts/new')
      end
      it '"新規投稿"と表示されている' do
        expect(page).to have_content '新規投稿'
      end
      it 'post_imagesフォームが表示されている' do
        expect(page).to have_field 'post[post_images_attributes][0][image]'
      end
      it 'textフォームが空である' do
        expect(find_field('post[text]').text).to be_blank
      end
      it 'situationフォームが表示されている' do
        expect(page).to have_field 'post[situation]'
      end
      it 'tagフォームが空である' do
        expect(find_field('post[caption]').text).to be_blank
      end
      it 'アイテムを追加ボタンが表示されている' do
        expect(page).to have_link 'アイテムを追加'
      end
      it '投稿ボタンが表示されている' do
        expect(page).to have_button '投稿する'
      end
    end

    # context '"アイテムを追加"のテスト' do
    #   before do
    #     click_link 'アイテムを追加'
    #   end
    #   it 'item_imageフォームが表示されている' do
    #     expect(page).to have_field 'post[items_attributes][new_items][image]'
    #   end
    #   it 'item_nameフォームが空である' do
    #     expect(find_field('post[items_attributes][new_items][name]').text).to be_blank
    #   end
    #   it 'item_categoryフォームが表示されている ' do
    #     expect(page).to have_field 'post[items_attributes][new_items][category_id]'
    #   end
    #   it 'item_manufacurerフォームが空である' do
    #     expect(find_field('post[items_attributes][new_items][manufacturer]').text).to be_blank
    #   end
    # end

    context '投稿成功のテスト' do
      image_path = Rails.root.join('spec/fixtures/test.jpg')
      before do
        fill_in 'post[text]', with: Faker::Lorem.characters(number: 10)
        choose 'post_situation_working'
        attach_file('post[post_images_attributes][0][image]', image_path, make_visible: true)
      end

      it '投稿が正しく保存される' do
        expect { click_button '投稿する' }.to change(user.posts, :count).by(1)
      end
      it 'リダイレクト先が保存した投稿の詳細画面である' do
        click_button '投稿する'
        expect(page).to have_current_path post_path(Post.last)
      end
    end

    context '投稿失敗のテスト' do
      before do
        fill_in 'post[text]', with: ''
        click_button '投稿する'
      end

      it '投稿に失敗し新規投稿画面に戻る' do
        expect(page).to have_content '新規投稿'
      end
    end
  end
  
  describe '投稿一覧画面のテスト' do
    before do
      visit posts_path
    end
    
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts'
      end
      # it '自分の投稿が表示されている' do
      #   expect(page).to have_link post.post_image.image, href: post_path(post)
      # end
      # it '他人の投稿が表示されている' do
      #   expect(page).to have_link post.post_image.image, href: post_path(other_post)
      # end
    end
  end

  describe '自分の投稿詳細画面のテスト' do
    before do
      visit post_path(post)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts/' + post.id.to_s
      end
      it 'ユーザー名が表示されている' do
        expect(page).to have_content post.user.name
      end
      it 'ユーザーIDが表示されている' do
        expect(page).to have_content post.user.username
      end
      # it 'ユーザーリンクが正しい' do
      #   user_link = find('.post-user-avatar')
      #   expect(user_link[:href]).to eq user_path(post.user)
      # end
      it '投稿画像が表示されている' do
        expect(page).to have_selector("img[src$='test.jpg']")
      end
      it '投稿のtextが表示されている' do
        expect(page).to have_content post.text
      end
      it '投稿のcaptionがリンクで表示されている' do
        expect(page).to have_link post.caption
      end
      it '投稿のsituationが表示されている' do
        expect(page).to have_content post.situation
      end
      it 'item_imageフォームが表示されている' do
        expect(page).to have_field 'item[image]'
      end
      it 'item_nameフォームが空である' do
        expect(find_field('item[name]').text).to be_blank
      end
      it 'item_categoryフォームが表示されている ' do
        expect(page).to have_field 'item[category_id]'
      end
      it 'item_manufacurerフォームが空である' do
        expect(find_field('item[manufacturer]').text).to be_blank
      end
      it 'itemの"追加する"ボタンが表示されている' do
        expect(page).to have_button '追加する'
      end
      it '投稿の編集リンクが表示されている' do
        expect(page).to have_link '', href: edit_post_path(post)
      end
      it '投稿の削除リンクが表示されている' do
        expect(page).to have_link '', href: post_path(post)
      end
    end

    context '編集リンクのテスト' do
      it '編集画面に遷移できる' do
        find('.post-edit').click
        expect(current_path).to eq '/posts/' + post.id.to_s + '/edit'
      end
    end

    context '削除リンクのテスト' do
      before do
        find('.post-delete').click
        # page.driver.browser.switch_to.alert.accept
      end

      it '正しく削除できる ' do
        expect(Post.where(id: post.id).count).to eq 0
      end
      it 'リダイレクト先がユーザー詳細画面である' do
        expect(current_path).to eq '/users/' + post.user_id.to_s
      end
    end
  end

  describe '他人の投稿詳細画面のテスト' do
    before do
      visit post_path(other_post)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts/' + other_post.id.to_s
      end
      it '他人のユーザー名が表示されている' do
        expect(page).to have_content other_post.user.name
      end
      it '他人のユーザーIDが表示されている' do
        expect(page).to have_content other_post.user.username
      end 
      # it 'ユーザーリンクが正しい' do
      #   user_link = find('.post-user-avatar')
      #   expect(user_link[:href]).to eq user_path(other_post.user)
      # end
      it 'itemの"追加する"ボタンが表示されていない' do
        expect(page).not_to have_button '追加する'
      end
      it '編集リンクが表示されていない' do
        expect(page).not_to have_link '', href: edit_post_path(other_post)
      end
      it '削除リンクが表示されていない' do
        expect(page).not_to have_link '', href: post_path(other_post)
      end
      it 'フォローボタンが表示されている' do
        expect(page).to have_link 'フォローする', href: user_relationships_path(other_user)
      end
    end
  end

  describe '投稿編集画面のテスト' do
    before do
      visit edit_post_path(post)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts/' + post.id.to_s + '/edit'
      end
      it '"投稿を編集"と表示されている' do
        expect(page).to have_content '投稿を編集'
      end
      it '変更ボタンが表示されている' do
        expect(page).to have_button '変更する'
      end
      it 'post_imagesフォームが表示されている' do
        expect(page).to have_field 'post[post_images_attributes][0][image]'
      end
      it 'text編集フォームが表示されている' do
        expect(page).to have_field 'post[text]', with: post.text
      end
      it 'situation編集フォームが表示されている' do
        expect(page).to have_field 'post[situation]', with: post.situation
      end
      it 'tag編集フォームが表示されている' do
        expect(page).to have_field 'post[caption]', with: post.caption
      end
    end

    context '編集成功のテスト' do
      before do
        @ex_post_text = post.text
        fill_in 'post[text]', with: Faker::Lorem.characters(number: 10)
        click_button '変更する'
      end

      it 'textが正しく更新される' do
        expect(post.reload.text).not_to eq @ex_post_text
      end
      it 'リダイレクト先が投稿詳細画面である' do
        expect(current_path).to eq '/posts/' + post.id.to_s
      end
    end

    context '編集失敗のテスト' do
      before do
        fill_in 'post[text]', with: ''
      end

      it '編集に失敗し編集画面に戻る' do
        expect(page).to have_content '投稿を編集'
      end
    end
  end
end
