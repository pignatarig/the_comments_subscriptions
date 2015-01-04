class TheCommentsSubscriptionsGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  # argument :xname, type: :string, default: :xname

  # > rails g the_comments_subscriptions OPTION_NAME
  def generate_controllers
    case gen_name
      when 'install'
        # > rails g the_comments_subscriptions install
        cp_models
        cp_controllers
      when 'models'
        # > rails g the_comments_subscriptions models
        cp_models
      when 'controllers'
        # > rails g the_comments_subscriptions controllers
        cp_controllers
      when 'mailers'
        # > rails g the_comments_subscriptions mailers
        cp_mailers
      when 'jobs'
        # > rails g the_comments_subscriptions jobs
        cp_jobs
      when 'locales'
        # > rails g the_comments_subscriptions locales
        cp_locales
      when 'all'
        # > rails g the_comments_subscriptions all
        cp_models
        cp_controllers
        cp_mailers
        cp_jobs
        cp_locales
      else
        puts 'TheCommentsSubscriptions Generator - wrong Name'
        puts 'Try to use [ install | models | controllers | locales | all ]'
    end
  end

  private

  def root_path; TheCommentsSubscriptions::Engine.root; end

  def gen_name
    name.to_s.downcase
  end

  def cp_models
    _path = "#{ root_path }/app/models/_templates_"

    %w[
      comment_subscription.rb
    ].each do |file_name|
      copy_file "#{ _path }/#{ file_name }", "app/models/#{ file_name }"
    end
  end

  def cp_controllers
    _path = "#{ root_path }/app/controllers/_templates_"

    %w[
      comment_subscriptions_controller.rb
    ].each do |file_name|
      copy_file "#{ _path }/#{ file_name }", "app/controllers/#{ file_name }"
    end
  end

  def cp_mailers
    _path = "#{ root_path }/app/mailers"

    %w[
      comment_subscriber_mailer.rb
    ].each do |file_name|
      copy_file "#{ _path }/#{ file_name }", "app/mailers/#{ file_name }"
    end
  end

  def cp_jobs
    _path = "#{ root_path }/app/jobs"

    %w[
      the_comments_subscriptions_job.rb
    ].each do |file_name|
      copy_file "#{ _path }/#{ file_name }", "app/jobs/#{ file_name }"
    end
  end

  def cp_locales
    _path = "#{ root_path }/config/locales"

    %w[
      en.the_comments_subscriptions.yml
      ru.the_comments_subscriptions.yml
    ].each do |file_name|
      copy_file "#{ _path }/#{ file_name }", "config/locales/#{ file_name }"
    end
  end
end
