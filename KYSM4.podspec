#
#  Be sure to run `pod spec lint KYSM4.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "KYSM4"
  s.version      = "1.0.0"
  s.summary      = "KYSM4是一个基于SM4国密算法的Objective-C的国密SM4算法类库。"

  s.homepage     = "https://github.com/kingly09/KYSM4"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "kingly" => "libintm@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/kingly09/KYSM4.git", :tag => s.version.to_s }
  s.social_media_url   = "https://github.com/kingly09"
  s.source_files = 'KYSM4/**/*}'
  s.framework    = "UIKit"
  s.requires_arc = true

 
end
