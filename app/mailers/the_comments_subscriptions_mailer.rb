class TheCommentsSubscriptionsMailer < ActionMailer::Base
  default from: ::TheCommentsBase.config.default_mailer_email

  include TheCommentsViewHelper

  # TheCommentsSubscriptionsMailer.notificate(email, comment).deliver_now
  # TheCommentsSubscriptionsMailer.notificate(email, comment).deliver_later
  def notificate email, comment
    @email       = email
    @comment     = comment
    @commentable = comment.commentable

    mail(
      to: email,
      subject: "[armatucasino.com] Nuevo Comentario en #{comment.commentable.name}",
      template_path: the_comments_template('mailers'),
      template_name: "new_comment"
    )
  end
end
