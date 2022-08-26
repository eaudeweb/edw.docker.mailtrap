# Mailtrap Docker Image
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

Catch all mail and display it in roundcube interface.

# Usage

## Start Mailtrap

    $ docker run -d --name=mailtrap -p 80:80 eaudeweb/mailtrap

## Send email

    $ docker run -it --link mailtrap alpine:3.6 sh

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

## Customisations:

Set environment variables

* `MT_USER` - mailbox user, default mailtrap
* `MT_PASSWD` - mailbox user password, default mailtrap
* `MT_MAILBOX_LIMIT` - mailbox limit in bytes, default 51200000
* `MT_MESSAGE_LIMIT` - message limit in bytes, default 10240000
* `MT_NETWORK_STYLE` - [host, subnet, or class](http://www.postfix.org/postconf.5.html#mynetworks_style), default subnet

and recreate the container.

## Testing the image locally

```
sudo docker build -t eaudeweb/mailtrap:test .
sudo docker-compose up
```

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/jeffrichards"><img src="https://avatars.githubusercontent.com/u/1960722?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Jeff Richards</b></sub></a><br /><a href="https://github.com/agilesyndrome/edw.docker.mailtrap/issues?q=author%3Ajeffrichards" title="Bug reports">🐛</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!