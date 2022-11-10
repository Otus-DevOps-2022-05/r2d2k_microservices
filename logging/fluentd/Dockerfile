FROM fluent/fluentd:v0.12
RUN gem install --no-rdoc --no-ri --version 2.1.0 faraday-net_http
RUN gem install --no-rdoc --no-ri --version 1.10.2 faraday
RUN gem install --no-rdoc --no-ri --version 1.9.5 fluent-plugin-elasticsearch
RUN gem install --no-rdoc --no-ri --version 1.0.0 fluent-plugin-grok-parser
ADD fluent.conf /fluentd/etc
