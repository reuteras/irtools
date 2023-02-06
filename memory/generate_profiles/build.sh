#!/bin/bash

cd /build

for kernel in * ; do
    rpm2cpio "${kernel}" | cpio -idmv
done

versions=$(ls | sed -E "s/^[-a-z]+//" | sed -E "s/\.rpm//" | sort | uniq )

echo "${versions}"
