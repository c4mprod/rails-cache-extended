require 'spec_helper'
require 'rails/cache/extended'

describe Cache::ActiveRecord::Base do
  it 'generates valid cache key' do
    scope = double(maximum: '2', count: 1)
    Cache::ActiveRecord::Base.stub(:scoped).and_return(scope)
    expected_result = Digest::MD5.hexdigest '2-1'
    expect(Cache::ActiveRecord::Base::cache_key).to eq(expected_result)
  end
end