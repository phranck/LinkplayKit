# LinkPlay

The `LinkPlay` Swift package uses Apple's mDNS [`NetService`](https://developer.apple.com/documentation/foundation/netservice) to find devices on your local network. It searches for the `_linkplay._tcp.` Bonjour service type, which is used in the [Linkplay Technology](https://www.linkplay.com/) DIY boards.

### ToDo
[ ] Migrate to the new `Network` framework because of `NetService` has been deprecated since iOS 15.
