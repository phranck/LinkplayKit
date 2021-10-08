# LinkplayKit

The `LinkplayKit` is an SDK for your Linkplay Home Audio solution. You can use it to implement you own music experience on both iOS and macOS.

 It uses Apple's mDNS [`NetService`](https://developer.apple.com/documentation/foundation/netservice) to find devices on your local network. It searches for the `_linkplay._tcp.` Bonjour service type, which is used in the [Linkplay Technology](https://www.linkplay.com/) DIY boards.
 
### What is it for?
All Linkplay devices comes with an HTTP API to retrieve informations about its current status or to control the device. `LinkplayKit` provides a developer friendly Swift API. It wraps the complexity of the above mentioned HTTP API.

### License
This software is published under the [MIT License](https://phranck.mit-license.org).

### Credits
The package was developed by [Frank Gregor](https://woodbytes.me).