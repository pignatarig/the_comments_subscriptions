module TheCommentsSubscription
  # TheCommentsSubscription::Routes.mixin(self)

  class Routes
    def self.mixin mapper
      mapper.get "/unsubscribe_comment/:type/:comment_id/:id"     => "comment_subscriptions#unsubscribe_comment",     as: :unsubscribe_comment
      mapper.get "/unsubscribe_commentable/:type/:comment_id/:id" => "comment_subscriptions#unsubscribe_commentable", as: :unsubscribe_commentable
      mapper.get "/unsubscribe_all/:type/:id"                     => "comment_subscriptions#unsubscribe_all",         as: :unsubscribe_all
    end
  end
end
