Repository containing Dockerfile and related collateral for building bazel-6 or bazel-7 on riscv64 for Ubuntu.

"Dockerfile" is used for bazel-7, "Dockerfile.bazel6" is used for bazel-6 releases.  You can also adjust the
version of Ubuntu used for the build in the Dockerfiles.

To build for bazel-7 use something like this "docker build -f Dockerfile patches".  To build for bazel-6 use
"docker build -f Dockerfile.bazel6 --build-arg=BAZEL_VERSION=6.0.0 patches"


We do not yet have a docker based flow to build bazel on Fedora.  We have managed to build bazel on Fedora by first installing java-21-openjdk and java-21-openjdk-devel, then using the same basic process shown in the Dockerfile.  There are not good docker images to start this process from.

We are including varous binaries for Ubuntu 22.04, Ubuntu 23.04 and Fedora 38 (as provided on the milk-v pioneer system).

Note that the patch to rules_python should no longer be necessary as that patch has been accepted upstream.  But we still need to repo override to pick up a version of rules_python that has the riscv64 fix.

Bazel-7 Builds require jni_md.h.  Normally this should be handled within the bazel configuration.  But I'm not familiar enough with bazel to know where to fix this.  So for the purposes of building in the Dockerfile I just put the necessary header files into /usr/include so they are found automatically.
