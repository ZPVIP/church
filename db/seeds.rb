if User.first.nil?
  user = User.new
else
  user = User.first
end
user.email = 'adminzp@gmail.com'
user.password = 'aaaaaaaa'
user.password_confirmation = 'aaaaaaaa'
user.name = 'Peter'
user.blocked = false
user.save!

permission=Permission.all
permission.each{|p|
  p.destroy
}
Permission.create!([
  {action: "manage", subject: "contact", description: "Admin 联系人"},
  {action: "read", subject: "contact", description: "查看联系人"},
  {action: "manage", subject: "group", description: "Admin 小组定义"},
  {action: "manage", subject: "user", description: "Admin 网站用户"},
  {action: "manage", subject: "service", description: "Admin 服事定义"},
  {action: "manage", subject: "calendar", description: "Admin 值日表"},
  {action: "modify_service", subject: "calendar", description: "填写值日表"},
  {action: "update", subject: "contact", description: "更新联系人"},
  {action: "create", subject: "contact", description: "创建联系人"}
])