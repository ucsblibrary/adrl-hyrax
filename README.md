# [Geniza](https://en.wikipedia.org/wiki/Cairo_Geniza)

## Development

See <https://github.com/samvera/hyrax#prerequisites>

```shell
brew install redis sqlite fits imagemagick ffmpeg
bundle install
bin/rake db:setup
bin/wrap
bin/rails hyrax:default_admin_set:create
bin/rails s
```

### creating the initial admin user

<https://github.com/samvera/hyrax/wiki/Making-Admin-Users-in-Hyrax#add-an-initial-admin-user-via-command-line>

In the Rails console:
```
admin = Role.create(name: "admin")
admin.users << User.find_by_user_key( "your_admin_users_email@fake.email.org" )
admin.save
```
