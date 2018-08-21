module Util
  module Hasher
    class << self
      def generate_sha(content)
        Digest::SHA1.hexdigest(content)
      end
    end
  end
end
