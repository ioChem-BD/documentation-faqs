#### Can't remember my password. How can I reset it?

On the login form you will see two links under the username/password textboxes, you have to click on the *Have you forgotten your password?* link. 

![Reset password link](/general/images/reset-password.png)

You will be redirected to a form where you must provide your username (your email), after clicking on the *I forgot my password* button, you will receive a message with instructions to reset your password.

Once your password is updated you also need to change your shell client password. To do so, open a command line terminal and move inside the shell client folder, then type the following command:

```shell
   $ . start-rep-shell -t update_password
   Shell client utilities
   Enter your new password: ******
   Enter new password again: ******
   Password has been changed
```
