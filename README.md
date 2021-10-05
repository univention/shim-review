This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your branch
- approval is ready when you have accepted tag

Note that we really only have experience with using GRUB2 on Linux, so asking
us to endorse anything else for signing is going to require some convincing on
your part.

Here's the template:

-------------------------------------------------------------------------------
What organization or people are asking to have this signed:
-------------------------------------------------------------------------------
Univention GmbH

-------------------------------------------------------------------------------
What product or service is this for:
-------------------------------------------------------------------------------
Univention Corporate Server 4.4

-------------------------------------------------------------------------------
What's the justification that this really does need to be signed for the whole world to be able to boot it:
-------------------------------------------------------------------------------
UCS is a Debian based Linux distribution for enterprise customers.
It is used by many companies, governments, ministries, banks and schools.
Many require Secure Boot to be compliant.
As they use standard hardware, where the "Microsoft Corporation UEFI CA" is pre-installed. Secure Boot must work for them out-of-the-box.

-------------------------------------------------------------------------------
Who is the primary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Philipp Hahn
- Position: Open Source Software Engineer
- Email address: hahn@univention.de
- PGP key: 58AF 7C2E 007C DBE6 2C59  E078 F50E FDCF 8AD0 4B| 321A

-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Erik Damrose
- Position: Open Source Software Engineer
- Email address: damrose@univention.de
- PGP key: C7E6 DA31 A12F C489 13EA 0A15 FB00 8168 5197 E505

-------------------------------------------------------------------------------
Please create your shim binaries starting with the 15.4 shim release tar file:
https://github.com/rhboot/shim/releases/download/15.4/shim-15.4.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/15.4 and contains
the appropriate gnu-efi source.
-------------------------------------------------------------------------------
<https://github.com/univention/shim/tree/4.4> is based on
<https://salsa.debian.org/efi-team/shim/-/tags/debian/15.4-7_deb10u1> is baed on
<https://github.com/rhboot/shim/releases/tag/15.4>

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
<https://github.com/univention/shim/tree/4.4>

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
Upstream patches picked by Debian:
- 822d07ad4f07ef66fe447a130e1027c88d02a394@rhboot/shim
- 5b3ca0d2f7b5f425ba1a14db8ce98b8d95a2f89f@rhboot/shim
- 4068fd42c891ea6ebdec056f461babc6e4048844@rhboot/shim
- 493bd940e5c6e28e673034687de7adef9529efff@rhboot/shim
- 9f973e4e95b1136b8c98051dbbdb1773072cc998@rhboot/shim
- 34e3ef205c5d65139eacba8891fa773c03174679@rhboot/shim
Our patches:
- 46d33604006b1d301581ad8daa2b29bd62446075@univention/shim add our certificate

-------------------------------------------------------------------------------
If bootloader, shim loading is, GRUB2: is CVE-2020-14372, CVE-2020-25632,
 CVE-2020-25647, CVE-2020-27749, CVE-2020-27779, CVE-2021-20225, CVE-2021-20233,
 CVE-2020-10713, CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311,
 CVE-2020-15705, and if you are shipping the shim_lock module CVE-2021-3418
-------------------------------------------------------------------------------
yes, we're booting GRUB2
- [x] CVE-2020-14372 acpi: Don't register the acpi command when locked down `2.02+dfsg1-20+deb10u4`
- [x] CVE-2020-25632 dl: Only allow unloading modules that are not dependencies `2.02+dfsg1-20+deb10u4`
- [x] CVE-2020-25647 usb: Avoid possible out-of-bound accesses caused by malicious devices `2.02+dfsg1-20+deb10u4`
- [x] CVE-2020-27749 kern/parser: Fix a stack buffer overflow `2.02+dfsg1-20+deb10u4`
- [x] CVE-2020-27779 mmap: Don't register cutmem and badram commands when lockdown is enforced `2.02~beta3-5+deb9u2`
- [x] CVE-2021-20225 lib/arg: Block repeated short options that require an argument `2.02+dfsg1-20+deb10u4`
- [x] CVE-2021-20233 commands/menuentry: Fix quoting in setparams_prefix() `2.02+dfsg1-20+deb10u4`
- [x] CVE-2020-10713 yylex: Make lexer fatal errors actually be fatal `2.02+dfsg1-20+deb10u1`
- [x] CVE-2020-14308 calloc: Use calloc() at most places  `2.02+dfsg1-20+deb10u1`
- [x] CVE-2020-14309 malloc: Use overflow `2.02+dfsg1-20+deb10u1`
- [x] CVE-2020-14310 malloc: Use overflow `2.02+dfsg1-20+deb10u1`
- [x] CVE-2020-14311 malloc: Use overflow `2.02+dfsg1-20+deb10u1`
- [x] CVE-2020-15705 *not affected* - see [Debian](https://security-tracker.debian.org/tracker/CVE-2020-15705)
- [x] CVE-2021-3418 *not affected* - see [Debian](https://security-tracker.debian.org/tracker/CVE-2021-3418)

-------------------------------------------------------------------------------
What exact implementation of Secureboot in GRUB2 ( if this is your bootloader ) you have ?
* Upstream GRUB2 shim_lock verifier or * Downstream RHEL/Fedora/Debian/Canonical like implementation ?
-------------------------------------------------------------------------------
We're using the Downstream Debian implementation

-------------------------------------------------------------------------------
If bootloader, shim loading is, GRUB2, and previous shims were trusting affected
by CVE-2020-14372, CVE-2020-25632, CVE-2020-25647, CVE-2020-27749,
  CVE-2020-27779, CVE-2021-20225, CVE-2021-20233, CVE-2020-10713,
  CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705,
  and if you were shipping the shim_lock module CVE-2021-3418
  ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
  grub2:
* were old shims hashes provided to Microsoft for verification
  and to be added to future DBX update ?
* Does your new chain of trust disallow booting old, affected by CVE-2020-14372,
  CVE-2020-25632, CVE-2020-25647, CVE-2020-27749,
  CVE-2020-27779, CVE-2021-20225, CVE-2021-20233, CVE-2020-10713,
  CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705,
  and if you were shipping the shim_lock module CVE-2021-3418
  ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
  grub2 builds ?
-------------------------------------------------------------------------------
Previously we used a v0.7 signed my Microsoft 2014 with hash `495300790e6c9bf2510daba59db3d57e9d2b85d7d7640434ec75baa3851c74e5`.
This hash is alredy contained in DBX available <https://uefi.org/sites/default/files/resources/dbxupdate_x64.bin>.
We use no other `shim` ever signed by Microsoft.

The new SHIM uses a new certificate, so there is no chain to our old signed binaries.

-------------------------------------------------------------------------------
If your boot chain of trust includes linux kernel, is
"efi: Restrict efivar_ssdt_load when the kernel is locked down"
upstream commit 1957a85b0032a81e6482ca4aab883643b8dae06e applied ?
Is "ACPI: configfs: Disallow loading ACPI tables when locked down"
upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 applied ?
-------------------------------------------------------------------------------
We will only load Linux v4.9.x where x ist currently 272.
The Lockdown features was only introduced with Linux v5.4, which the Debian and our kernel does not include.

-------------------------------------------------------------------------------
If you use vendor_db functionality of providing multiple certificates and/or
hashes please briefly describe your certificate setup. If there are allow-listed hashes
please provide exact binaries for which hashes are created via file sharing service,
available in public with anonymous access for verification
-------------------------------------------------------------------------------
Not used.

-------------------------------------------------------------------------------
If you are re-using a previously used (CA) certificate, you will need
to add the hashes of the previous GRUB2 binaries to vendor_dbx in shim
in order to prevent GRUB2 from being able to chainload those older GRUB2
binaries. If you are changing to a new (CA) certificate, this does not
apply. Please describe your strategy.
-------------------------------------------------------------------------------
The new SHIM uses a new certificate, so there is no chain to out old signed binaries.

Old:
```
# openssl x509 -noout -subject -serial -in codesigning2014.pem
subject=businessCategory = Private Organization, jurisdictionC = DE, jurisdictionST = Bremen, serialNumber = HRB 20755, street = Mary-Somerville-Stra\C3\9Fe 1, postalCode = 28359, C = DE, L = Bremen, O = Univention GmbH, CN = Univention GmbH
serial=0223EDBA9AF41AC83237C5256A9DD2DF
```

New:
```
# openssl x509 -noout -subject -serial -in codesigning2020.pem
subject=jurisdictionC = DE, jurisdictionST = Bremen, jurisdictionL = Bremen, businessCategory = Private Organization, serialNumber = HRB 20755 HB, C = DE, ST = Bremen, L = Bremen, O = Univention GmbH, CN = Univention GmbH
serial=088C799F6812F2605F4D66AC6D1AC2AA
```

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
If the shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case and the differences would be.
-------------------------------------------------------------------------------
See [Dockerfile](Dockerfile):
```
# dpkg-query -W gcc-8 binutils libelf-dev
binutils        2.31.1-16
gcc-8   8.3.0-6
libelf-dev:amd64        0.176-1.1
```

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
- [patch.log](out/shim_15.4-7~deb10u1A~4.4.0.202110051737.patch.log) applies patch adding our certificate
- [i386.log](out/shim_15.4-7~deb10u1A~4.4.0.202110051737.i386.log) is unused as be provide Secure-Boot only for amd64
- [amd64.log](out/shim_15.4-7~deb10u1A~4.4.0.202110051737.amd64.log)
- [shimx64.efi](out/shimx64.efi) resulting binary

-------------------------------------------------------------------------------
Add any additional information you think we may need to validate this shim
-------------------------------------------------------------------------------
Our UCS-4.4 was based on Debian-9-Stretch, which only has `gcc-6`, which is too old to build `shim-15.4`.
Therefore we build it using UCS-5.0, which is based on Debian-10-Buster, which has `gcc-8`.
Our internal build system does not use Docker and either do we currently have a public Docker image suitable for building.
Therefore the [Dockerfile](Dockerfile) uses `Debian:Buster`, which produces the binary identical output.
