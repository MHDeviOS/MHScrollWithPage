
Pod::Spec.new do |s|
  s.name         = "MHScrollLoop"
  s.version      = "1.0.3"
  s.summary      = "ScrollView and PageControl RunLoop"
  s.description  = <<-DESC
                    Testing private Podspec.
                    ScrollView and PageControl RunLoop
                   DESC
  s.homepage     = "https://github.com/MHDeviOS/MHScrollWithPage.git"
  s.license = 'MIT'
  s.author             = { "MHDeviOS" => "minghaoo@foxmail.com" }
  s.platform     = :ios, "7.0"
  s.ios.deployment_target = "7.0"
  s.source       = { :git => "https://github.com/MHDeviOS/MHScrollWithPage.git", :tag => "1.0.3" }
  s.source_files  = "Pod/*.{h,m}"
  s.requires_arc = true
end
