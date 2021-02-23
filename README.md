# テーブル設計

## users テーブル

| Column     | Type   | Options     |
| ---------- | ------ | ----------- |
| name       | string | null: false |
| email      | string | null: false |
| password   | string | null: false |
| profile    | text   |             |

### Association

- has_many :posts
- has_many :likes
- has_many :groups through: :user_groups
- has_many :user-groups
- has_many :chats
- has_many :relationships

## posts テーブル

| Column     | Type       | Options           |
| ---------- | ---------- | ------------------|
| text       | text       | null: false       |
| created_at | datetime   | null: false       |
| user       | references | foreign_key: true |

### Association

- belongs_to :user
- has_many :likes
- has_many :tags through: :post_tags
- has_many :post_tags

## tags テーブル

| Column     | Type       | Options           |
| ---------- | ---------- | ------------------|
| tag_name   | string     | null: false       |

### Association

- has_many :posts through: :post_tags
- has_many :post_tags


## post_tags テーブル

| Column     | Type       | Options           |
| ---------- | ---------- | ------------------|
| post       | references | foreign_key: true |
| tag        | references | foreign_key: true |

### Association

- belongs_to :post
- belongs_to :tag

## likes テーブル

| Column     | Type       | Options           |
| ---------- | ---------- | ------------------|
| post       | references | foreign_key: true |
| user       | references | foreign_key: true |

### Association

- belongs_to :post
- belongs_to :user

## relationships テーブル

| Column     | Type       | Options           |
| ---------- | ---------- | ------------------|
| follow_id  | references | foreign_key: true |
| user       | references | foreign_key: true |

### Association

- belongs_to :user

## groups テーブル

| Column     | Type       | Options           |
| ---------- | ---------- | ------------------|
| group_name | string     | null false        |

### Association

- has_many :users

## user_groups テーブル

| Column     | Type       | Options           |
| ---------- | ---------- | ------------------|
| group      | references | foreign_key: true |
| user       | references | foreign_key: true |

### Association

- belongs_to :group
- belongs_to :user

## chats テーブル

| Column     | Type       | Options           |
| ---------- | ---------- | ------------------|
| group      | references | foreign_key: true |
| user       | references | foreign_key: true |

### Association

- belongs_to :group
- belongs_to :user