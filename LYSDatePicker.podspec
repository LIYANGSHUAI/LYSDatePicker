Pod::Spec.new do |s|
s.name         = "LYSDatePicker"
s.version      = "0.0.5"
s.summary      = "简单封装一个日期选择器"
s.description  = <<-DESC
简单封装一个日期选择器,简单封装一个日期选择器,简单封装一个日期选择器.
DESC
s.homepage     = "https://github.com/LIYANGSHUAI/LYSDatePicker"

s.platform     = :ios, "8.0"
s.license      = "MIT"
s.author             = { "李阳帅" => "liyangshuai163@163.com" }

s.source       = { :git => "https://github.com/LIYANGSHUAI/LYSDatePicker.git", :tag => s.version }

s.source_files  = "LYSDatePicker", "LYSDatePicker/*.{h,m}"
end

