shared_examples_for 'a json sanitizer' do |keys|
  keys.each do |key|
    it "doesn't include '#{key}' when serializing to json" do
      instance = described_class.new
      instance[key] = 10
      instance.as_json[instance.class.json_root].keys.should_not include(key)
    end
  end
end

# it_behaves_like 'a json sanitizer', %w(cache_version)