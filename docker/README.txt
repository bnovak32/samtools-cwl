multiplatform build example:
docker buildx build --platform linux/amd64,linux/arm64 -f Dockerfile-full -t bnovak32/alpine-samtools:1.18 --push .
docker buildx build --platform linux/amd64,linux/arm64 -f Dockerfile-slim -t bnovak32/alpine-samtools:1.18-slim --push .

