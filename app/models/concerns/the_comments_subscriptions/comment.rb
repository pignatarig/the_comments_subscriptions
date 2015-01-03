module TheCommentsSubscriptions
  module Comment
    extend ActiveSupport::Concern

    included { include ::TheCommentsSubscriptions::Relations }

    def add_subscriber(current_user)
      return unless subscribe_to_thread_flag
      comment = self

      if current_user
        comment.comment_subscriptions.create(user_id: current_user.id)
      else
        _email = ::TheCommentsBase.normalize_email(contacts)
        if _email.match ::TheCommentsBase::EMAIL_REGEXP
          comment.comment_subscriptions.create(email: _email)
        end
      end
    end

    def send_notifications_to_subscribers
      comment = self

      subscribers_emails.each do |email|
        if ::TheCommentsBase.config.async_processing
          TheCommentsNotificationsJob.perform_later(email, comment.id)
        else
          CommentSubscriberMailer.notificate(email, comment).deliver_now
        end
      end
    end

    private

    def subscribers_emails
      comment = self
      parents = comment.ancestors.includes(:comment_subscriptions)

      subscriptions = parents.map(&:active_subscriptions).compact.flatten
      users = ::User.where(id: subscriptions.map(&:user_id).compact)

      u_emails = users.map(&:email).compact
      g_emails = subscriptions.map(&:email).compact

      (u_emails | g_emails).uniq
    end
  end # module Comment
end
