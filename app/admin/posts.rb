ActiveAdmin.register Post do
  permit_params :title, :body, :published_at, :user_id

  scope :all
  scope :published
  scope :unpublished

  form do |f|
    inputs do
      input :user
      input :title
      input :body
    end
    actions
  end

  batch_action :Unpublish do |ids|
    batch_action_collection.find(ids).each do |post|
      post.update(published_at: nil) if post.published_at?
    end
    redirect_to collection_path, alert: "The posts have been UnPublished."
  end
  batch_action :Publish do |ids|
    batch_action_collection.find(ids).each do |post|
      post.update(published_at: Time.zone.now) if !post.published_at?
    end
    redirect_to collection_path, alert: "The posts have been Published."
  end
  

  action_item :publish, only: :show do
    link_to "Publish", publish_admin_post_path(post), method: :put if !post.published_at?
  end
  action_item :publish, only: :show do
    link_to "UnPublish", unpublish_admin_post_path(post), method: :put if post.published_at?
  end

  member_action :publish, method: :put do
    post = Post.find(params[:id])
    post.update(published_at: Time.zone.now)
    redirect_to admin_post_path(post)
  end
  member_action :unpublish, method: :put do
    post = Post.find(params[:id])
    post.update(published_at: nil)
    redirect_to admin_post_path(post)
  end
end