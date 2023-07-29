#!/bin/sh

set -e

if [ -z "$RAILWAY_VOLUME_MOUNT_PATH" ]; then
    echo no volume attached, please attach a volume.
    echo upon attaching a volume let this service rebuild
    exit 1
fi

if [ -z "$WEB_USERNAME" ]; then
    echo missing the WEB_USERNAME variable, please add it to continue
    exit 1
fi

if [ -z "$WEB_PASSWORD" ]; then
    echo missing the WEB_PASSWORD variable, please add it to continue
    exit 1
fi

rm -rf $RAILWAY_VOLUME_MOUNT_PATH/lost+found > /dev/null

FILEBROWSER_DATA_PATH=$RAILWAY_VOLUME_MOUNT_PATH/.filebrowser_data

DB_PATH=$FILEBROWSER_DATA_PATH/filebrowser.db

FILEBROWSER_USERNAME_PATH=$FILEBROWSER_DATA_PATH/username

if [ -f "$DB_PATH" ]; then
    if [ -f "$FILEBROWSER_USERNAME_PATH" ]; then
        FILEBROWSER_CURRENT_USERNAME=$(cat $FILEBROWSER_USERNAME_PATH)

        if [[ -n "$FILEBROWSER_CURRENT_USERNAME" && "$FILEBROWSER_CURRENT_USERNAME" != "$WEB_USERNAME" ]]; then
            echo new username was set in the service variables, changing username: $FILEBROWSER_CURRENT_USERNAME "->" $WEB_USERNAME
            ./filebrowser users update $FILEBROWSER_CURRENT_USERNAME --username $WEB_USERNAME --database $DB_PATH > /dev/null
            echo $WEB_USERNAME >| $FILEBROWSER_USERNAME_PATH
            echo username updated
        fi
    fi
else
    echo first start, creating database
    ./filebrowser config init --database $DB_PATH > /dev/null

    echo setting configurations
    ./filebrowser config set --address "0.0.0.0" --database $DB_PATH > /dev/null
    ./filebrowser config set --root $RAILWAY_VOLUME_MOUNT_PATH --database $DB_PATH > /dev/null

    ./filebrowser users add $WEB_USERNAME $WEB_PASSWORD --database $DB_PATH > /dev/null
fi

echo $WEB_USERNAME > $FILEBROWSER_USERNAME_PATH

./filebrowser users update $WEB_USERNAME --password $WEB_PASSWORD --database $DB_PATH > /dev/null

./filebrowser config set --port $PORT --database $DB_PATH > /dev/null

./filebrowser version && ./filebrowser --database $DB_PATH 2>&1