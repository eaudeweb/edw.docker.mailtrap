# Mailtrap Docker Image

Catch all mail and display it in roundcube interface.

# Usage

## Start Mailtrap

    $ docker run -d --name=mailtrap -p 80:80 eaudeweb/mailtrap

## Send email

    $ docker run -it --link mailtrap alpine sh

      $ telnet mailtrap 25
      ehlo example.com
      mail from: me@example.com
      rcpt to: you@example.com
      data
      Subject: Hello from me
      Hello You,

      This is a test.

      Cheers,
      Me
      .
      quit

## See email via Mailtrap Web UI:

* http://localhost

## Default login:

* **Username:** `mailtrap`
* **Password:** `mailtrap`
