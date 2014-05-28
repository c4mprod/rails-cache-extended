require 'spec_helper'
require 'rails/cache/logging'

describe ActiveSupport::CacheLogSubscriber do
  let!(:log_subscriber) { ActiveSupport::CacheLogSubscriber.new }

  describe '.cache_read' do
    it 'returns a valid response' do
      event = double(payload: {super_operation: :test, hit: true}, duration: 2)
      logger = double(debug: 1, info: 2)

      ActiveSupport::CacheLogSubscriber.stub(:logger).and_return(logger)

      expect(log_subscriber.cache_read(event)).to eq(1)
    end

    it 'returns nil when super_operation == fetch' do
      event = double(payload: {super_operation: :fetch})

      expect(log_subscriber.cache_read(event)).to be_nil
    end

    describe 'logger method call' do
      let!(:logger) { double(debug: 1, info: 2) }

      before do
        ActiveSupport::CacheLogSubscriber.stub(:logger).and_return(logger)
      end

      it 'should call debug on logger' do
        event = double(payload: {super_operation: :test, hit: true, key: 'key'}, duration: 2)

        logger.should_receive(:debug).with('  cache hit: key (2.0ms)')
        log_subscriber.cache_read(event)
      end

      it 'should call debug on logger' do
        event = double(payload: {super_operation: :test, hit: false, key: 'key2'}, duration: 2)

        logger.should_receive(:info).with('  cache miss: key2 (2.0ms)')
        log_subscriber.cache_read(event)
      end
    end
  end

  describe '.cache_fetch_hit' do
    let!(:logger) { double(debug: 1) }
    let!(:event) { double(payload: {key: 'test'}, duration: 2) }

    before do
      ActiveSupport::CacheLogSubscriber.stub(:logger).and_return(logger)
    end

    it 'returns a valid response' do
      expect(log_subscriber.cache_fetch_hit(event)).to eq(1)
    end

    it 'should call debug on logger' do
      logger.should_receive(:debug).with('  cache hit: test (2.0ms)')
      log_subscriber.cache_fetch_hit(event)
    end
  end

  describe '.cache_write' do
    let!(:logger) { double(info: 1) }
    let!(:event) { double(payload: {key: 'test'}, duration: 2) }

    before do
      ActiveSupport::CacheLogSubscriber.stub(:logger).and_return(logger)
    end

    it 'returns a valid response' do
      expect(log_subscriber.cache_write(event)).to eq(1)
    end

    it 'should call info on logger' do
      logger.should_receive(:info).with('  cache write: test (2.0ms)')
      log_subscriber.cache_write(event)
    end
  end
end


