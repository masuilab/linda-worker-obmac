# linda-worker-obmac

## Config

edit `config.json`

## Scripts

put into `scritps` directory.


## Run

### Run All Scripts

    % npm start

### Run Specific Script

    % SCRIPT=mac_say npm start
    % SCRIPT=mac* npm start


## Logs

configure with env variable `DEBUG`

    % DEBUG=linda* npm start                # print linda's read/write/take/watch operation
    % DEBUG=linda:worker* npm start         # print this app's status
    % DEBUG=linda:worker:mac_say npm start  # print from `scripts/mac_say.coffee`
    % DEBUG=* npm start                     # print socket.io/engine.io/linda status


## set HTTP Port

    % PORT=3000 npm start  # port:3000


## Deploy on Heroku

install [heroku toolbelt](https://toolbelt.heroku.com/) then

    % heroku create --app my-great-linda-worker-name
    % git push heroku master
    % heroku config:set 'DEBUG=linda:worker*'
    % heroku logs --tail

edit `config.json`, set 'http://my-great-linda-worker-name.herokuapp.com' in `app.url`


## Test

    % npm install grunt-cli -g

    % npm test
    # or
    % grunt
