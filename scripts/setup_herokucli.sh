#!/bin/bash

install_cli() {
echo "---- installing heroku cli"
wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh

cat > ~/.netrc << EOF
machine api.heroku.com
  login $HEROKU_LOGIN
  password $HEROKU_API_KEY
machine git.heroku.com
  login $HEROKU_LOGIN
  password $HEROKU_API_KEY
EOF

}

verify_cli() {

echo "---- verifying heroku cli is properly installed"
if ! [ -x "$(command -v heroku)" ]; then
	echo 'Error: heroku cli is not installed.' >&2
	exit 1
fi

}

# confirm working cli
verify_login() {
echo "---- verifying login credentials"
heroku container:login
}

install_cli
verify_cli
verify_login