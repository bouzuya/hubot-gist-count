# hubot-gist-count

A Hubot script that count public gists

## Installation

    $ npm install git://github.com/bouzuya/hubot-gist-count.git

or

    $ # TAG is the package version you need.
    $ npm install 'git://github.com/bouzuya/hubot-gist-count.git#TAG'

## Example

    bouzuya> hubot help gist-count
      hubot> hubot gist-count <username> - count public gists

    bouzuya> hubot gist-count bouzuya
      hubot> https://gist.github.com/bouzuya (88)

## Configuration

See [`src/scripts/gist-count.coffee`](src/scripts/gist-count.coffee).

## Development

`npm run`

## License

[MIT](LICENSE)

## Author

[bouzuya][user] &lt;[m@bouzuya.net][mail]&gt; ([http://bouzuya.net][url])

## Badges

[![Build Status][travis-badge]][travis]
[![Dependencies status][david-dm-badge]][david-dm]
[![Coverage Status][coveralls-badge]][coveralls]

[travis]: https://travis-ci.org/bouzuya/hubot-gist-count
[travis-badge]: https://travis-ci.org/bouzuya/hubot-gist-count.svg?branch=master
[david-dm]: https://david-dm.org/bouzuya/hubot-gist-count
[david-dm-badge]: https://david-dm.org/bouzuya/hubot-gist-count.png
[coveralls]: https://coveralls.io/r/bouzuya/hubot-gist-count
[coveralls-badge]: https://img.shields.io/coveralls/bouzuya/hubot-gist-count.svg
[user]: https://github.com/bouzuya
[mail]: mailto:m@bouzuya.net
[url]: http://bouzuya.net
