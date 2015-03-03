module EncryptorHelper
  class << self
    def encryptor
      @encryptor ||= ActiveSupport::MessageEncryptor.new(Rails.configuration.secret_key_base)
    end

    def crypt str
      Base64.urlsafe_encode64 self.encryptor.encrypt_and_sign(str.to_s)
    end

    def decrypt str
      self.encryptor.decrypt_and_verify Base64.urlsafe_decode64(str.to_s)
    end
  end
end
