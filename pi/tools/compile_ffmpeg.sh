#
# Project: PiOmxTextures
# Author:  Luca Carlon
# Date:    01.04.2012
#
#!/bin/bash


# Configures and builds ffmpeg for the PiOmxTextures project. The result is placed in
# <ffmpeg_sources>/ffmpeg_compiled. Both static and shared libraries are compiled.
# Usage:
#    ./compile_ffmpeg.sh <n>, where n is the number of compilation threads to use.

# Check the user provided the number of threads to use when building.
if [ $# -ne 1 ]; then
   echo "Illegal arguments. Please provide just one parameter with the number of parallel threads to use when building."
   exit
fi

echo "Downloading ffmpeg sources from git..."
cd ..
if [ ! -d "3rdparty/ffmpeg" ]; then
   mkdir -p 3rdparty/ffmpeg
fi

cd 3rdparty/ffmpeg
git clone git://source.ffmpeg.org/ffmpeg ffmpeg_src
cd ffmpeg_src; git checkout n2.1

echo "Configuring..."
FLOAT=hard
export PATH=$PATH:/opt/rpi/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/
echo "Prefix to $PWD..."
./configure \
--extra-cflags="-mfpu=vfp -mfloat-abi=$FLOAT -mno-apcs-stack-check -mstructure-size-boundary=32 -mno-sched-prolog" \
--enable-cross-compile \
--enable-shared \
--enable-static \
--arch=arm \
--cpu=arm1176jzf-s \
--target-os=linux \
--disable-hwaccels \
--enable-parsers \
--disable-muxers \
--disable-filters \
--disable-encoders \
--disable-devices \
--disable-ffprobe \
--disable-ffplay \
--disable-ffserver \
--disable-ffmpeg \
--enable-shared \
--disable-doc \
--disable-postproc \
--enable-gpl \
--enable-protocol=http \
--enable-pthreads \
--enable-pic \
--disable-armv5te \
--disable-neon \
--enable-armv6t2 \
--enable-armv6 \
--enable-hardcoded-tables \
--disable-runtime-cpudetect \
--disable-debug \
--disable-crystalhd \
--disable-decoder=h264_vda \
--disable-decoder=h264_crystalhd \
--disable-decoder=h264_vdpau \
--disable-decoder=libstagefright_h264 \
--disable-decoder=vc1_crystalhd \
--disable-decoder=wmv3_crystalhd \
--disable-decoder=wmv3_vdpau \
--disable-decoder=mpeg1_vdpau \
--disable-decoder=mpeg2_crystalhd \
--disable-decoder=mpeg4_crystalhd \
--disable-decoder=mpeg4_vdpau \
--disable-decoder=mpeg_vdpau \
--disable-decoder=mpeg_xvmc \
--disable-decoder=msmpeg4_crystalhd \
--disable-decoder=vc1_vdpau \
--enable-decoder=mpegvideo \
--enable-decoder=mpeg1video \
--enable-decoder=mpeg2video \
--disable-decoder=mvc1 \
--disable-decoder=mvc2 \
--disable-decoder=h261 \
--disable-decoder=h263 \
--disable-decoder=rv10 \
--disable-decoder=rv20 \
--disable-decoder=mjpeg \
--disable-decoder=mjpegb \
--disable-decoder=sp5x \
--disable-decoder=jpegls \
--enable-decoder=mpeg4 \
--disable-decoder=rawvideo \
--disable-decoder=msmpeg4v1 \
--disable-decoder=msmpeg4v2 \
--disable-decoder=msmpeg4v3 \
--disable-decoder=wmv1 \
--disable-decoder=wmv2 \
--disable-decoder=h263p \
--disable-decoder=h263i \
--disable-decoder=svq1 \
--disable-decoder=svq3 \
--disable-decoder=dvvideo \
--disable-decoder=huffyuv \
--disable-decoder=cyuv \
--enable-decoder=h264 \
--disable-decoder=indeo3 \
--disable-decoder=vp3 \
--enable-decoder=theora \
--disable-decoder=asv1 \
--disable-decoder=asv2 \
--disable-decoder=ffv1 \
--disable-decoder=vcr1 \
--disable-decoder=cljr \
--disable-decoder=mdec \
--disable-decoder=roq \
--disable-decoder=xan_wc3 \
--disable-decoder=xan_wc4 \
--disable-decoder=rpza \
--disable-decoder=cinepak \
--disable-decoder=msrle \
--disable-decoder=msvideo1 \
--disable-decoder=idcin \
--disable-decoder=smc \
--disable-decoder=flic \
--disable-decoder=truemotion1 \
--disable-decoder=vmdvideo \
--disable-decoder=mszh \
--disable-decoder=zlib \
--disable-decoder=qtrle \
--disable-decoder=snow \
--disable-decoder=tscc \
--disable-decoder=ulti \
--disable-decoder=qdraw \
--disable-decoder=qpeg \
--disable-decoder=png \
--disable-decoder=ppm \
--disable-decoder=pbm \
--disable-decoder=pgm \
--disable-decoder=pgmyuv \
--disable-decoder=pam \
--disable-decoder=ffvhuff \
--disable-decoder=rv30 \
--disable-decoder=rv40 \
--enable-decoder=vc1 \
--enable-decoder=wmv3 \
--disable-decoder=loco \
--disable-decoder=wnv1 \
--disable-decoder=aasc \
--disable-decoder=indeo2 \
--disable-decoder=fraps \
--disable-decoder=truemotion2 \
--disable-decoder=bmp \
--disable-decoder=cscd \
--disable-decoder=mmvideo \
--disable-decoder=zmbv \
--disable-decoder=avs \
--disable-decoder=nuv \
--disable-decoder=kmvc \
--disable-decoder=flashsv \
--disable-decoder=cavs \
--disable-decoder=jpeg2000 \
--disable-decoder=vmnc \
--disable-decoder=vp5 \
--enable-decoder=vp6 \
--enable-decoder=vp6f \
--disable-decoder=targa \
--disable-decoder=dsicinvideo \
--disable-decoder=tiertexseqvideo \
--disable-decoder=tiff \
--disable-decoder=gif \
--disable-decoder=dxa \
--disable-decoder=dnxhd \
--disable-decoder=thp \
--disable-decoder=sgi \
--disable-decoder=c93 \
--disable-decoder=bethsoftvid \
--disable-decoder=ptx \
--disable-decoder=txd \
--disable-decoder=vp6a \
--disable-decoder=amv \
--disable-decoder=vb \
--disable-decoder=pcx \
--disable-decoder=sunrast \
--disable-decoder=indeo4 \
--disable-decoder=indeo5 \
--disable-decoder=mimic \
--disable-decoder=rl2 \
--disable-decoder=escape124 \
--disable-decoder=dirac \
--disable-decoder=bfi \
--disable-decoder=motionpixels \
--disable-decoder=aura \
--disable-decoder=aura2 \
--disable-decoder=v210x \
--disable-decoder=tmv \
--disable-decoder=v210 \
--disable-decoder=dpx \
--disable-decoder=frwu \
--disable-decoder=flashsv2 \
--disable-decoder=cdgraphics \
--disable-decoder=r210 \
--disable-decoder=anm \
--disable-decoder=iff_ilbm \
--disable-decoder=iff_byterun1 \
--disable-decoder=kgv1 \
--disable-decoder=yop \
--enable-decoder=vp8 \
--disable-decoder=webp \
--disable-decoder=pictor \
--disable-decoder=ansi \
--disable-decoder=r10k \
--disable-decoder=mxpeg \
--disable-decoder=lagarith \
--disable-decoder=prores \
--disable-decoder=jv \
--disable-decoder=dfa \
--disable-decoder=wmv3image \
--disable-decoder=vc1image \
--disable-decoder=utvideo \
--disable-decoder=bmv_video \
--disable-decoder=vble \
--disable-decoder=dxtory \
--disable-decoder=v410 \
--disable-decoder=xwd \
--disable-decoder=cdxl \
--disable-decoder=xbm \
--disable-decoder=zerocodec \
--disable-decoder=mss1 \
--disable-decoder=msa1 \
--disable-decoder=tscc2 \
--disable-decoder=mts2 \
--disable-decoder=cllc \
--disable-decoder=mss2 \
--disable-decoder=y41p \
--disable-decoder=escape130 \
--disable-decoder=exr \
--disable-decoder=avrp \
--disable-decoder=avui \
--disable-decoder=ayuv \
--disable-decoder=v308 \
--disable-decoder=v408 \
--disable-decoder=yuv4 \
--disable-decoder=sanm \
--disable-decoder=paf_video \
--disable-decoder=avrn \
--disable-decoder=cpia \
--disable-decoder=bintext \
--disable-decoder=xbin \
--disable-decoder=idf \
--cross-prefix=arm-linux-gnueabihf- \
--prefix=$PWD/ffmpeg_compiled

echo "Building..."
mkdir $PWD/ffmpeg_compiled
make -j$1
make install

echo "Cleaning up..."
mv ffmpeg_compiled/include ../
mv ffmpeg_compiled/lib ../

echo "Done! Bye bye! ;-)"
