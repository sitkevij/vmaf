set -ex
file1=tos-6705k-h264-yuv420p-1920x800-24fps-mp3-44100s.mov
file2=tos-6705k.webm
size=400K
rng=`head -c 4 /dev/urandom | od -t x1 | tr -d '\n ' | tr -d ' '`
tempdir=/tmp/$rng
dir=/media

echo "** get $file1"
curl -LOs https://raw.githubusercontent.com/sitkevij/test-media/master/media/$file1 > $file1
echo "** transcode $file1 to $size $file2"
docker run --rm -v $(PWD):$dir sitkevij/ffmpeg -i $dir/$file1 -c:v libvpx-vp9 -b:v $size -c:a libvorbis $dir/$file2 -y
echo "** transcode $file1 to yuv"
docker run --rm -v $(PWD):$dir sitkevij/ffmpeg -i $dir/$file1 -c:v rawvideo -pix_fmt yuv420p $dir/$file1.yuv -y
echo "** transcode $file2 to yuv"
docker run --rm -v $(PWD):$dir sitkevij/ffmpeg -i $dir/$file2 -c:v rawvideo -pix_fmt yuv420p $dir/$file2.yuv -y
echo "** vmaf $file1 to $file2"
docker run --rm -v $(PWD):$dir sitkevij/vmaf run_vmaf yuv420p 1920 800 $dir/$file1.yuv $dir/$file2.yuv --out-fmt json
