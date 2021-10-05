FROM debian:buster-slim
ENV DEBIAN_FRONTEND=noninteractive
COPY in/univention /etc/dpkg/origins/univention
RUN ln -sf univention /etc/dpkg/origins/default && \
    apt-get update -q && \
    apt-get install -q --assume-yes build-essential git bsdmainutils quilt

RUN git clone --branch 4.4 --single-branch https://github.com/univention/shim.git shim
WORKDIR /shim
RUN apt-get build-dep -q --assume-yes .
RUN QUILT_PATCHES="$PWD/debian/patches" quilt push -a
COPY in/changelog debian/
RUN dpkg-buildpackage -us -uc -b

WORKDIR /
COPY out/shimx64.efi /shim-review/
# FIXME: This only works on x86-64 efi binary
RUN hexdump -Cv /shim-review/shimx64.efi > orig && \
    hexdump -Cv /shim/shimx64.efi > build && \
    diff -u orig build
