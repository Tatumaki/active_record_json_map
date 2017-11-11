# ActiveRecordJsonMap

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_record_json_map'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_record_json_map


## Usage

```ruby
class YourAwesomeModel < ApplicationRecord
  include ActiveRecordJsonMap

  def awesome_json *args, **hash
    # 
    {
      id:         self.id,
      title:      self.title,
      some_flag:  self.some_flag
      created_at: self.created_at.to_i
    }
  end
end
```

```ruby
YourAwesomeModel.where(some_flag: 1).order("created_at desc").limit(3).json_map(:awesome_json)
```

### Generated json
```json
[
  {
    "id": 20,
    "title": "sample 3",
    "some_flag": 1,
    "created_at": 1510377530,
    "format": "YourAwesomeModel_awesome_json"
  },
  {
    "id": 19,
    "title": "sample 2",
    "some_flag": 1,
    "created_at": 1510377500,
    "format": "YourAwesomeModel_awesome_json"
  },
  {
    "id": 18,
    "title": "sample 1",
    "some_flag": 1,
    "created_at": 1510377430,
    "format": "YourAwesomeModel_awesome_json"
  },
]
```

## Best effective use case

```ruby
class Corporation < ApplicationRecord
  include ActiveRecordJsonMap

  has_many :customers

  def corporation_show_json *args, **hash
    {
      id: self.id,
      customers: self.customers.json_map(:corporation_customer_json, corporation: self)
    }
  end
end

class Customer < ApplicationRecord
  include ActiveRecordJsonMap

  belogs_to :corporation

  def corporation_customer_json *args, corporation: , **hash
    {
      id: self.id,
      title: "#{self.fullname} / #{corporation.name}"
    }
  end

  def fullname
    "his or her name"
  end
end
```

```ruby
Corporation.limit(10).offset(0).json_map(:corporation_show_json)
```

### Generated json

```json
[
  {
    "id": 1,
    "customers": [
      {
        "id": 1,
        "title": "his or her name / FooCorporation Inc.",
        "format": "Customer_corporation_customer_json"
      },
      {
        "id": 2,
        "title": "his or her name / FooCorporation Inc.",
        "format": "Customer_corporation_customer_json"
      }
    ],
    "format": "Corporation_corporation_show_json"
  },
  {
    "id": 2,
    "customers": [
      {
        "id": 3,
        "title": "his or her name / BarCorporation Inc.",
        "format": "Customer_corporation_customer_json"
      },
      {
        "id": 4,
        "title": "his or her name / BarCorporation Inc.",
        "format": "Customer_corporation_customer_json"
      }
    ],
    "format": "Corporation_corporation_show_json"
  }
]
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Tatumaki/active_record_json_map.
