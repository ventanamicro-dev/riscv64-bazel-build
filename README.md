Repository containing Dockerfile and related collateral for building bazel on riscv64 for Ubuntu.  To build you should adjust the version of Ubuntu you want to build for in the Dockerfile (we have tested Ubuntu-22.04 and Ubuntu-23.04), then "docker build -f Dockerfile patches".  Several hours later you should have a docker image with a full bazel-7.1.2 build inside.  bazel-7.1.2/output/bazel is the final binary.

We do not yet have a docker based flow to build bazel on Fedora.  We have managed to build bazel on Fedora by first installing java-21-openjdk and java-21-openjdk-devel, then using the same basic process shown in the Dockerfile.  There are not good docker images to start this process from.

We are including binaries for Ubuntu 22.04, Ubuntu 23.04 and Fedora 38 (as provided on the milk-v pioneer system).

Note that the patch to rules_python should no longer be necessary as that patch has been accepted upstream.  But we still need to repo override to pick up a version of rules_python that has the riscv64 fix.

Builds require jni_md.h.  Normally this should be handled within the bazel configuration.  But I'm not familiar enough with bazel to know where to fix this.  So for the purposes of building in the Dockerfile I just put the necessary header files into /usr/include so they are found automatically.
