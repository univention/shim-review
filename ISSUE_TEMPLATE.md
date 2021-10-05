Make sure you have provided the following information:

 - [x] link to your code branch cloned from rhboot/shim-review in the form user/repo@tag

    univention/shim@4.4-9

 - [x] completed README.md file with the necessary information

    [README.md](README.md)

 - [x] shim.efi to be signed

    [out/shimx64.efi](out/shimx64.efi)

 - [x] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)

    ```sh
    openssl x509 -noout -in univention-uefi-ca.der -inform der -pubkey
    ```

    ```
    -----BEGIN PUBLIC KEY-----
    MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyxzbaZOfU6aHDLjbowYM
    p2hixnSx2Aqgm0iRD781w0ZvxqVkYZ5ucojSHVmDP+tX9zQMi5zmiME8yKQ2+MTi
    JQBjgUQCoiIQJ/ZoNfGbzNHX/jOVSCaYQ/UOj9NT/eY8p3KlXYZk6MZgX7aa1sMv
    cvKuelUxWyjhrIPurIybYlR74g4emlb++S5IJZmiucCPs8OMq0fyhwrFmoujKXIN
    qM+Hj8ZGMiQMgM1rubx9XgmmUK1meR/fNTLQI3KTcveyF+/wQ4uit9+mMU8HuUY9
    BIvvhlgbMlZAOadDno/DHslHBh5d+wNqqVp6e/2eHAnF2bKKGlK4va3xGRKhkKi1
    RQIDAQAB
    -----END PUBLIC KEY-----
    ```

 - [x] binaries, for which hashes are added do vendor_db ( if you use vendor_db and have hashes allow-listed )

    not used

 - [x] any extra patches to shim via your own git tree or as files

    * 46d33604006b1d301581ad8daa2b29bd62446075@univention/shim

 - [x] any extra patches to grub via your own git tree or as files

    - [Debian's patches 2.02+dfsg1-20+deb10u4](https://salsa.debian.org/grub-team/grub/-/tree/debian/2.02+dfsg1-20+deb10u4/debian/patches)
    - [UCS specific patches](grub2/)

 - [x] build logs

    - [out/patch.log](out/shim_15.4-7~deb10u1A~4.4.0.202110051737.patch.log)
    - [out/i386.log](out/shim_15.4-7~deb10u1A~4.4.0.202110051737.i386.log) is not to be signed, but only build for legacy reasons
    - [out/amd64.log](out/shim_15.4-7~deb10u1A~4.4.0.202110051737.amd64.log)

 - [x] a Dockerfile to reproduce the build of the provided shim EFI binaries

    [Dockerfile](Dockerfile)

###### What organization or people are asking to have this signed:
Univention GmbH

###### What product or service is this for:
Univention Corporate Server 4.4

###### Please create your shim binaries starting with the 15.4 shim release tar file:
###### https://github.com/rhboot/shim/releases/download/15.4/shim-15.4.tar.bz2
###### This matches https://github.com/rhboot/shim/releases/tag/15.4 and contains
###### the appropriate gnu-efi source.
###### Please confirm this as the origin your shim.
<https://github.com/univention/shim/tree/4.4> is based on
<https://salsa.debian.org/efi-team/shim/-/tags/debian/15.4-7_deb10u1> is baed on
<https://github.com/rhboot/shim/releases/tag/15.4>

###### What's the justification that this really does need to be signed for the whole world to be able to boot it:
UCS is a Debian based Linux distribution for enterprise customers.
It is used by many companies, governments, ministries, banks and schools.
Many require Secure Boot to be compliant.
As they use standard hardware, where the "Microsoft Corporation UEFI CA" is pre-installed. Secure Boot must work for them out-of-the-box.

###### How do you manage and protect the keys used in your SHIM?
The private key is stored on a hardware token.
The token is locked away until a binary needs to be signed.
In addition it requires a password to unlock the functionality.
Only two people have access to the token and its password.

###### Do you use EV certificates as embedded certificates in the SHIM?
Yes - see [in/univention-uefi-ca.der](in/univention-uefi-ca.der)

###### If you use new vendor_db functionality, are any hashes allow-listed, and if yes: for what binaries ?
We do not use `vendor_db`.

###### Is kernel upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 present in your kernel, if you boot chain includes a Linux kernel ?
We will only load Linux v4.9.x where x ist currently 272.
The Lockdown features was only introduced with Linux v5.4, which the Debian and our kernel does not include.

###### if SHIM is loading GRUB2 bootloader, are CVEs CVE-2020-14372,
###### CVE-2020-25632, CVE-2020-25647, CVE-2020-27749, CVE-2020-27779,
###### CVE-2021-20225, CVE-2021-20233, CVE-2020-10713, CVE-2020-14308,
###### CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705,
###### ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
###### and if you are shipping the shim_lock module CVE-2021-3418
###### fixed ?
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

###### "Please specifically confirm that you add a vendor specific SBAT entry for SBAT header in each binary that supports SBAT metadata
###### ( grub2, fwupd, fwupdate, shim + all child shim binaries )" to shim review doc ?
###### Please provide exact SBAT entries for all SBAT binaries you are booting or planning to boot directly through shim

shim,fb,mm: `objcopy -O binary --only-section=.sbat out/shimx64.efi ./tmp && cat ./tmp ; rm -f ./tmp`:

```
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,1,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.debian,1,Debian,shim,15.4,https://tracker.debian.org/pkg/shim
shim.univention,1,Univention,shim,15.4-7~deb10u1,https://forge.univention.org/bugzilla/
```

grub: `objcopy -O binary --only-section=.sbat grubx64.efi ./tmp && cat ./tmp ; rm -f ./tmp`

```
objcopy -O binary --only-section=.sbat x/usr/lib/grub/x86_64-efi/monolithic/grubx64.efi ./tmp && cat ./tmp ; rm -f ./tmp
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,1,Free Software Foundation,grub,2.02,https://www.gnu.org/software/grub/
grub.debian,1,Debian,grub2,2.02+dfsg1-20+deb10u4,https://tracker.debian.org/pkg/grub2
grub.univention,1,Univention,grub2,2.02+dfsg1-20+deb10u4A~4.4.0.202110052241,https://forge.univention.org/bugzilla
```

kernel.efi:
*not SBAT yet*

##### Were your old SHIM hashes provided to Microsoft ?
Previously we used a v0.7 signed my Microsoft 2014 with hash `495300790e6c9bf2510daba59db3d57e9d2b85d7d7640434ec75baa3851c74e5`.
This hash is alredy contained in DBX available <https://uefi.org/sites/default/files/resources/dbxupdate_x64.bin>.
We use no other SHIM ever signed by Microsoft.

The new SHIM uses a new certificate, so there is no chain to our old signed binaries.

##### Did you change your certificate strategy, so that affected by CVE-2020-14372, CVE-2020-25632, CVE-2020-25647, CVE-2020-27749,
##### CVE-2020-27779, CVE-2021-20225, CVE-2021-20233, CVE-2020-10713,
##### CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705 ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
##### grub2 bootloaders can not be verified ?
yes, we're now using a different certificate.

##### What exact implementation of Secureboot in grub2 ( if this is your bootloader ) you have ?
##### * Upstream grub2 shim_lock verifier or * Downstream RHEL/Fedora/Debian/Canonical like implementation ?
We're using the downstream Debian implementation.

###### What is the origin and full version number of your bootloader (GRUB or other)?
* Upstream version: 2.02
* Debian version: 2.02+dfsg1-20+deb10u4
* Our version: 2.02+dfsg1-20+deb10u4A~4.4.0-2021100DHHMM

###### If your SHIM launches any other components, please provide further details on what is launched
SHIM is only used to launch GRUB2.

###### If your GRUB2 launches any other binaries that are not Linux kernel in SecureBoot mode,
###### please provide further details on what is launched and how it enforces Secureboot lockdown
GRUB2 is only used to load Linux kernel.

###### If you are re-using a previously used (CA) certificate, you
###### will need to add the hashes of the previous GRUB2 binaries
###### exposed to the CVEs to vendor_dbx in shim in order to prevent
###### GRUB2 from being able to chainload those older GRUB2 binaries. If
###### you are changing to a new (CA) certificate, this does not
###### apply. Please describe your strategy.
We use a new EV certificate.

###### How do the launched components prevent execution of unauthenticated code?
We chain load SHIM → GRUB2 → Linux kernel.
The later only loads kernel modules signed by us.

###### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
No, we only use static build of GRUB2.

###### What kernel are you using? Which patches does it includes to enforce Secure Boot?
Linux 4.9.272 or later with Debian patches

###### What changes were made since your SHIM was last signed?
- Upgrade from 0.7 to 15.4.
- Replace EV certificate from 2014 with EV certificate from 2020

###### What is the SHA256 hash of your final SHIM binary?
```
sha256sum out/shimx64.efi
# 5803f5e0fc873779529045bdc3d55494421a67c08d8e0708261d9256f01539f1  out/shimx64.efi

pesign -i out/shimx64.efi -h
# hash: 3cf97eba6a6d2c6a971974af4ff5cbefa4faf212f317cd06f21f9156e93cf515
```
