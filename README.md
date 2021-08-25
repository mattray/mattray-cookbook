# MattRay Cookbook

Manages Matt Ray's machines, including a couple Raspberry Pis, a Beaglebone Black, and a pair of broken Macs.

Much more about the builds and installations on [mattray.github.io](https://mattray.github.io)

### Platforms

- AMD workstation on Arch
- Beaglebone Black, 32-bit Arm on Debian 11 - apt-cacher-ng, Cinc builds
- MacBook Pro 6,2, Intel Core i5 M540 2.53GHz on Debian 11 - currently unused
- Raspberry Pi Zero W, 32-bit Arm on Raspbian 10 - FlightAware
- Raspberry Pi Zero W, 32-bit Arm on Debian 11 - Cinc builds
- Raspberry Pi 3 B+, 64-bit Arm on Debian 11 - K8s cluster
- Raspberry Pi 3 B+, 64-bit Arm on Debian 11 - K8s cluster
- Raspberry Pi 4 2 gigs RAM, 64-bit Arm on Debian 11 - K8s cluster
- Raspberry Pi 4 8 gigs RAM, 64-bit Arm on Debian 11 - K8s cluster
- RockPro64, 64-bit Arm on Debian 11
- Shuttle SH55J, Intel i7 @ 2.93GHz - currently unused

### Cinc

- Cinc 17

### Recipes and Tags

The `default` recipe looks for tags to select on hardware recipes (ie. `raspberry_pi`) as necessary.

Raspberry Pi devices running Debian 11 are tagged `rpi` to select the proper configuration.
