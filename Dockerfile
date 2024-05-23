# In theory changing the version number here should be all we
# need to do to get a binary for a particular Ubuntu release.
#
# But that's predicated on being able to get a version of java-21
# installed.
#
# It been tested on Ubuntu 23.04 and 22.04
FROM riscv64/ubuntu:22.04

# Core dependencies needed to bootstrap Bazel
RUN apt-get update && apt-get -y install openjdk-21-jdk build-essential zip unzip wget git

# We need to fix the rules_python package before we start building
# bazel.  So do that.
RUN git clone https://github.com/bazelbuild/rules_python.git
ADD rules_python.patch /tmp/rules_python.patch
RUN cd rules_python && patch -p1 < /tmp/rules_python.patch

# We also need to put a couple header files into a location where they're found
# automatically.  This probably a bug in bazel, but I'm not familiar enough
# with bazel to find and fix it myself
RUN cp /usr/lib/jvm/java-21-openjdk-riscv64/include/linux/*.h /usr/include

# Now download bazel's dist file and patch it to use the rules_python package
RUN wget https://github.com/bazelbuild/bazel/releases/download/7.1.2/bazel-7.1.2-dist.zip
RUN mkdir bazel-7.1.2 && cd bazel-7.1.2 && unzip ../bazel-7.1.2-dist.zip
ADD bazel.patch /tmp/bazel.patch
RUN cd bazel-7.1.2 && patch -R -p1 < /tmp/bazel.patch
RUN cd bazel-7.1.2 && env EXTRA_BAZEL_ARGS="--tool_java_runtime_version=local_jdk" bash ./compile.sh
