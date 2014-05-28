
unless Rails.env.production?
  ActiveSupport::Cache::Store.instrument = true

  module ActiveSupport
    class CacheLogSubscriber < LogSubscriber
      def cache_read(event)
        return if event.payload[:super_operation] == :fetch

        message_string = event.payload[:hit] ? "hit" : "miss"
        message = "  cache #{message_string}: #{event.payload[:key]}"
        message << " (%.1fms)" % event.duration

        event.payload[:hit] ? logger.debug(message) : logger.info(message)
      end

      def cache_fetch_hit(event)
        message = "  cache hit: #{event.payload[:key]}"
        message << " (%.1fms)" % event.duration

        logger.debug message
      end

      def cache_write(event)
        message = "  cache write: #{event.payload[:key]}"
        message << " (%.1fms)" % event.duration

        logger.info message
      end
    end
  end

  ActiveSupport::CacheLogSubscriber.attach_to :active_support
end