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

Service.create!([
  {title: "查经班", parent_id: nil, lft: 15, rgt: 20, depth: 0},
  {title: "带领", parent_id: 2, lft: 16, rgt: 17, depth: 1},
  {title: "主题", parent_id: 2, lft: 18, rgt: 19, depth: 1},
  {title: "福音班", parent_id: nil, lft: 21, rgt: 26, depth: 0},
  {title: "带领", parent_id: 5, lft: 22, rgt: 23, depth: 1},
  {title: "主题", parent_id: 5, lft: 24, rgt: 25, depth: 1},
  {title: "真理班", parent_id: nil, lft: 27, rgt: 32, depth: 0},
  {title: "带领", parent_id: 8, lft: 28, rgt: 29, depth: 1},
  {title: "主题", parent_id: 8, lft: 30, rgt: 31, depth: 1},
  {title: "敬拜组", parent_id: nil, lft: 7, rgt: 14, depth: 0},
  {title: "领诗", parent_id: 11, lft: 8, rgt: 9, depth: 1},
  {title: "司琴", parent_id: 11, lft: 10, rgt: 11, depth: 1},
  {title: "伴唱", parent_id: 11, lft: 12, rgt: 13, depth: 1},
  {title: "弟兄会", parent_id: nil, lft: 33, rgt: 42, depth: 0},
  {title: "诗歌", parent_id: 15, lft: 34, rgt: 35, depth: 1},
  {title: "带领", parent_id: 15, lft: 36, rgt: 37, depth: 1},
  {title: "地点", parent_id: 15, lft: 40, rgt: 41, depth: 1},
  {title: "姊妹会", parent_id: nil, lft: 43, rgt: 52, depth: 0},
  {title: "诗歌", parent_id: 20, lft: 44, rgt: 45, depth: 1},
  {title: "带领", parent_id: 20, lft: 46, rgt: 47, depth: 1},
  {title: "地点", parent_id: 20, lft: 50, rgt: 51, depth: 1},
  {title: "内容", parent_id: 20, lft: 48, rgt: 49, depth: 1},
  {title: "内容", parent_id: 15, lft: 38, rgt: 39, depth: 1},
  {title: "祷告会", parent_id: nil, lft: 1, rgt: 6, depth: 0},
  {title: "诗歌", parent_id: 26, lft: 2, rgt: 3, depth: 1},
  {title: "带领", parent_id: 26, lft: 4, rgt: 5, depth: 1}
])
