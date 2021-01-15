cd /vagrant
#if [ ! -d ".bundle" ]; then
  echo "Bundling API"
  echo "-----> Installing Bundle dependencies"
  bundle config build.nokogiri --use-system-libraries
  bundle install --path .bundle
#fi
echo "-----> Creating/migrating API development and test databases"
if [ ! -d "log" ]; then
  mkdir log
fi
touch log/development.log
touch log/test.log
bundle exec rails db:create
wait
bundle exec rails db:migrate
wait
RACK_ENV=test bundle exec rails db:reset