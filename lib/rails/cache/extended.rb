require 'rails/cache/version'

  module ActiveRecord
    class Base
      def self.cache_key
        Digest::MD5.hexdigest "#{where(nil).maximum(:updated_at).try(:to_i)}-#{where(nil).count}"
        #scoped.select("md5(COALESCE(date_part('epoch', MAX(updated_at))::char, '') || '-' || COUNT(*)) AS collection_cache_key").first.collection_cache_key
      end
    end
  end
