#!/bin/sh
set -ex
file1=tos-6705k-h264-yuv420p-1920x800-24fps-mp3-44100s.mov
file2=tos-6705k.webm
size=400K
# rng=$(head -c 4 /dev/urandom | od -t x1 | tr -d '\n ' | tr -d ' ')
# tempdir=/tmp/$rng

if [ -f "${file1}" ]
then
    echo "${file1} found, using."
else
    echo "${file1} not found, requesting..."
    curl -o "${file1}" "https://raw.githubusercontent.com/sitkevij/test-media/master/media/${file1}"
fi

echo "** transcode $file1 to $size $file2"
docker run --rm -v="$(pwd)":/tmp/ffmpeg sitkevij/ffmpeg -i "${file1}" -c:v libvpx-vp9 -b:v $size -c:a libvorbis "${file2}" -y
echo "** transcode $file1 to yuv"
docker run --rm -v="$(pwd)":/tmp/ffmpeg sitkevij/ffmpeg -i "${file1}" -c:v rawvideo -pix_fmt yuv420p "${file1}.yuv" -y
echo "** transcode $file2 to yuv"
docker run --rm -v="$(pwd)":/tmp/ffmpeg sitkevij/ffmpeg -i "${file2}" -c:v rawvideo -pix_fmt yuv420p "${file2}.yuv" -y
echo "** vmaf $file1 to $file2"
docker run --rm -v="$(pwd)":/tmp/vmaf sitkevij/vmaf run_vmaf yuv420p 1920 800 "${file1}.yuv" "${file2}.yuv" --out-fmt json