# linda-worker-obmac

generated with [generator-linda](https://npmjs.org/package/generator-linda) v0.2.6

## SETUP

edit `config.json`

### Scripts

put into `scritps` directory.


## RUN

### Run All Scripts

    % npm start

### Run Specific Script

    % SCRIPT=mac_say npm start
    % SCRIPT=mac* npm start


### set HTTP Port

    % PORT=3000 npm start  # port:3000


### Logs

configure with env variable `DEBUG`

    % DEBUG=linda* npm start                # print linda's read/write/take/watch operation
    % DEBUG=linda:worker* npm start         # print this app's status
    % DEBUG=linda:worker:mac_say npm start  # print from `scripts/mac_say.coffee`
    % DEBUG=* npm start                     # print socket.io/engine.io/linda status



## DEPLOY

### for Heroku

install [heroku toolbelt](https://toolbelt.heroku.com/) then

    % heroku create --app my-great-linda-worker-name
    % git push heroku master
    % heroku config:set 'DEBUG=linda:worker*'

    % heroku logs --tail
    % heorku open

edit `config.json`, set 'http://my-great-linda-worker-name.herokuapp.com' in `app.url`


### for launchd (Mac OSX)

    % gem install foreman
    % sudo foreman export launchd /Library/LaunchDaemons/ --app linda-worer -u `whoami`

edit `/Library/LaunchDaemons/linda-worker-main-1.plist` then

    % sudo launchctl load -w /Library/LaunchDaemons/linda-worker-main-1.plist


### for upstart (Ubuntu/Debian)

    % gem install foreman
    % sudo foreman export upstart /etc/init/ --app linda-worker -d `pwd` -u `whoami`

edit `/etc/init/linda-worker-web-1.conf` then

    % sudo service linda-worker start


## TEST

    % npm install grunt-cli -g

    % npm test
    # or
    % grunt
