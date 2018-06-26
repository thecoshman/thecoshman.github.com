FROM ruby:2.5.1

RUN gem install bundler jekyll

RUN gem install pygments.rb

ENTRYPOINT jekyll serve --source /www_source
