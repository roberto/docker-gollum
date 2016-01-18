FROM ruby

ARG repo
ARG repodomain
ARG sshkey
ARG sshconfig

MAINTAINER Roberto Soares <roberto.tech@gmail.com>

# Dependencies
RUN apt-get -y update
RUN apt-get -y install build-essential libicu-dev cron git zlib1g-dev ruby-dev libgit2-dev cmake

# SSH Keys
RUN /bin/mkdir -p /root/.ssh
RUN /usr/bin/ssh-keyscan -H ${repodomain} >> /root/.ssh/known_hosts

ADD ${sshkey} /root/.ssh/id_rsa
ADD ${sshconfig} /root/.ssh/config

RUN /bin/chown -R root:root /root/.ssh
RUN /bin/chmod 0400 /root/.ssh/id_rsa
RUN /bin/chmod 0400 /root/.ssh/config

# Gems
RUN gem install gollum github-markdown gollum-rugged_adapter

# Sync
ADD files/update_repo.sh /usr/bin/update_repo.sh
ADD files/start-cron.sh /usr/bin/start-cron.sh
ADD files/crontab /etc/crontab
ADD files/gitconfig /root/.gitconfig

RUN chmod +x /usr/bin/update_repo.sh
RUN chmod +x /usr/bin/start-cron.sh
RUN touch /var/log/cron.log

RUN /usr/bin/git clone ${repo} /var/wiki

# Start
ADD files/start.sh /usr/bin/start.sh
RUN chmod +x /usr/bin/start.sh

CMD /usr/bin/start.sh

EXPOSE 80
