Pod::Spec.new do |spec|
  spec.name = "AVSTaggedAttributedString"
  spec.version = "0.0.3"
  spec.ios.deployment_target = '8.0'
  spec.summary = "Tag-based formatting for NSAttributedString."
  spec.homepage = "https://github.com/AS7C2/AVSTaggedAttributedString"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Andrei Sherstniuk" => 'sherstnyuk.a@gmail.com' }
  spec.platform = :ios, "8.0"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/AS7C2/AVSTaggedAttributedString.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = "AVSTaggedAttributedString/**/*.{h,swift}"
end