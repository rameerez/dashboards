# 🍱 `dashboards` - Ruby gem to create admin dashboards in your Rails app

`dashboards` is a Ruby gem that allows you to create beautiful admin dashboards in your Rails application with a very simple and straightforward DSL.

Creating a dashboard looks something like this:
```ruby
dashboard "Admin Dashboard" do
  box "#{User.count} Total Users" do
    chart "User Signups", type: :line, data: -> { User.group_by_day(:created_at).count }
  end

  box "#{Post.count} Total Posts" do
    chart "Posts by Category", type: :pie, data: -> { Post.group(:category).count }
    table "Recent Posts", data: -> { Post.order(created_at: :desc).limit(5) }
  end
end
```

Which automatically creates a beautiful bento-style dashboard like this:

![Dashboard](https://via.placeholder.com/150)

`dashboards` has a minimal setup so you can quickly build dashboards with metrics, charts, and tables.

## Installation

Add this line to your application's Gemfile:
```ruby
gem 'dashboards'
```

And then execute:
```bash
bundle install
```

## Usage

1. Create a file `config/dashboards.rb` in your Rails application, and define your dashboard using the Dashboards DSL:
```ruby
dashboard "Admin Dashboard" do
  box "#{User.count} Total Users" do
    chart "User Signups", type: :line, data: -> { User.group_by_day(:created_at).count }
  end

  box "#{Post.count} Total Posts" do
    chart "Posts by Category", type: :pie, data: -> { Post.group(:category).count }
    table "Recent Posts", data: -> { Post.order(created_at: :desc).limit(5) }
  end
end
```

2. Mount the Dashboards engine in your `config/routes.rb`:
```ruby
mount Dashboards::Engine, at: "/admin/dashboard"
```

It's a good idea to make sure you're adding some authentication to the `dashboards` route to avoid exposing sensitive information:
```ruby
authenticate :user, ->(user) { user.admin? } do
    mount Dashboards::Engine, at: "/admin/dashboard"
end
```

3. Visit `/admin/dashboard` in your browser to see your new dashboard!

## Available Components

### Metrics

```ruby
metric "Name", value: -> { ... }
```

### Charts

```ruby
chart "Name", type: :line, data: -> { ... }
```

Supported chart types: `:line`, `:bar`, `:column`, `:area`, `:pie`

### Tables

```ruby
table "Name", data: -> { ... }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rameerez/dashboards. Our code of conduct is: just be nice and make your mom proud of what you do and post online.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
