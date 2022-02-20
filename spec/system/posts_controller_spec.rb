require 'rails_helper'

describe 'postsコントローラーのテスト' do
  let(:user) { create(:user) }
  let!(:post_image) { create(:post_image) }
  let!(:post) { create(:post) }
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

    context '投稿処理のテスト' do
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
  end

  describe '自分の投稿詳細画面のテスト' do
    before do
      visit post_path(post)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq  '/posts/' + post.id.to_s
      end
      it 'ユーザー名が表示されている' do
        expect(page).to have_content post.user.name
      end
      it 'ユーザーIDが表示されている' do
        expect(page).to have_content post.user.username
      end
      # it 'ユーザーリンクが正しい' do
      #   expect(page).to have_link("img[src$='test_avatar.png']"), href: user_path(post.user)
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
      # it 'item_imageフォームが表示されている' do
      #   expect(page).to have_field 'item[image]'
      # end
      # it 'item_nameフォームが空である' do
      #   expect(find_field('item[name]').text).to be_blank
      # end
      # it 'item_categoryフォームが表示されている ' do
      #   expect(page).to have_field 'item[category_id]'
      # end
      # it 'item_manufacurerフォームが空である' do
      #   expect(find_field('item[manufacturer]').text).to be_blank
      # end
      # it '投稿の編集リンクが表示されている' do
      #   expect(page).to have_link edit_post_path(post)
      # end
      # it '投稿の削除リンクが表示されている' do
      #   expect(page).to have_link post_path(post)
      # end
    end

    # context '編集リンクのテスト' do
    #   it '編集画面に遷移できる' do
    #     find('#post_edit').click
    #     expect(current_path).to eq '/posts/' + post.id.to_s + '/edit'
    #   end
    # end

    # context '削除リンクのテスト' do
    #   before do
    #     find('#post_delete').click
    #     page.driver.browser.switch_to.alert.accept
    #   end

    #   it '正しく削除できる ' do
    #     expect(Post,where(id: post.id).count).to eq 0
    #   end
    #   it 'リダイレクト先が投稿一覧画面である' do
    #     expect(current_path).to eq '/posts'
    #   end
    # end
  end
end