# ssh-login-telegram-notification
### Use with PAM
###### Setup a Telegram bot
First of all, you’ll need to have a Telegram account and create a Telegram bot
###### Script to send message via the bot
Put file ssh-telegram.sh to /usr/local/bin/
> Remember to replace <your bot token> and <your chat ID> with the real data of your own.
###### When a user logs in on the server
* With Debian/Ubuntu
Edit file /etc/pam.d/common-session
> session optional pam_exec.so type=open_session seteuid /usr/local/bin/ssh-telegram.sh
* With CentOS
Edit the file /etc/pam.d/system-auth
> session optional pam_exec.so type=open_session seteuid /usr/local/bin/tgbot.sh

### Put the command to run in the user’s shell init script, such as .bashrc, or /etc/profile or a script under /etc/profile.d/.
