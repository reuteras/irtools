#!/bin/bash

cd /build || exit

for kernel in * ; do
    rpm2cpio "${kernel}" | cpio -idmv
done

# shellcheck disable=SC2012
versions=$(ls | sed -E "s/^[-a-z]+//" | sed -E "s/\.rpm//" | sort | uniq )

echo "${versions}"
