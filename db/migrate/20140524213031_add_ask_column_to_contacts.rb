class AddAskColumnToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :job, :string

    # 0: Search Engine
    # 1: 网站或论坛
    # 2: 活动宣传
    # 3: 团契朋友介绍
    # 4: 其它
    add_column :contacts, :find_us, :integer
    add_column :contacts, :find_us_additional, :string
    add_column :contacts, :friend_id, :integer

    # 0: 周六聚会 1: 周五晚7点弟兄会或姐妹会 2: 特别聚会
    add_column :contacts, :meet_us, :integer
    add_column :contacts, :pray, :text
  end
end
