<h1>
<img src="https://testainers.com/assets/assets/images/testainers-80.png" alt="Testainers" title="Testainers">
check
</h1>

[![Build With Love](https://img.shields.io/badge/%20built%20with-%20%E2%9D%A4-ff69b4.svg)](https://github.com/testainers/check/stargazers)
[![Version](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fapi.github.com%2Frepos%2Ftestainers%2Fcheck%2Freleases%2Flatest&query=name&label=version&color=orange)](https://github.com/testainers/check/releases/latest)
[![Licence](https://img.shields.io/github/license/testainers/check?color=blue)](https://github.com/testainers/check/blob/main/LICENSE)
[![Build](https://img.shields.io/github/actions/workflow/status/testainers/check/main.yml?branch=main)](https://github.com/testainers/check/releases/latest)
[![Coverage Report](https://img.shields.io/badge/coverage-report-C08EA1)](https://testainers.github.io/check/coverage/)

Introducing "Check", our CLI HTTP Request tool engineered to simplify and
expedite your web interactions. With its user-friendly commands and
comprehensive features, Check empowers users to seamlessly navigate HTTP
requests for tasks like API testing, data retrieval, and web development. Say
farewell to cumbersome setups and clunky interfaces; Check prioritizes intuitive
usability without sacrificing functionality. Whether you're a seasoned developer
or just dipping your toes into web technologies, Check is your dependable
companion for confidently mastering the intricacies of web requests.

## Funding

Your contribution will help drive the development of quality tools for the
Flutter and Dart developer community. Any amount will be appreciated.
Thank you for your continued support!

[![BuyMeACoffee](https://www.buymeacoffee.com/assets/img/guidelines/download-assets-sm-2.svg)](https://www.buymeacoffee.com/edufolly)

## PIX

Sua contribuição ajudará a impulsionar o desenvolvimento de ferramentas de
qualidade para a comunidade de desenvolvedores Flutter e Dart. Qualquer quantia
será apreciada.
Obrigado pelo seu apoio contínuo!

[![PIX](helpers/pix.png)](https://nubank.com.br/pagar/2bt2q/RBr4Szfuwr)

## Examples

Check http://localhost:8080 with GET method.

```shell
check :8080
```

Check http://localhost:8080 with POST method.

```shell
check POST :8080
```

Check http://localhost:8080 with GET method and timeout to 5 seconds.

```shell
check -t 5 GET :8080
```

### Exit Codes

The exit codes in the range from 1 to 8 are reserved for specific application
purposes.

If the HTTP request returns a status code below 200, the exit code will be set
to 9.

For HTTP request status codes falling within the range of 200 to 299, the exit
code will be set to 0, indicating a successful request.

For status codes from 300 onwards, subtract 290 from the status code to
determine the exit code.

Any HTTP request code exceeding 545 will result in an exit code of 255,
indicating an error condition beyond the tool's handling capability.

| Request Status Code | Exit Code |
|---------------------|-----------|
| 0 - 199             | 9         |
| 200 - 299           | 0         |
| 300                 | 10        |
| 301                 | 11        |
| 302                 | 12        |
| 389                 | 99        |
| 390                 | 100       |
| 399                 | 109       |
| 400                 | 110       |
| 401                 | 111       |
| 403                 | 113       |
| 404                 | 114       |
| 500                 | 210       |
| 544                 | 254       |
| 545                 | 255       |
| 599                 | 255       |

To check the status code, visit:

https://developer.mozilla.org/en-US/docs/Web/HTTP/Status

To get the request status code, use the command:

```shell
CODE=$(check httpbingo.org/status/204)
echo $CODE
```

### Compile

```shell
dart compile exe bin/check.dart -o check
```
