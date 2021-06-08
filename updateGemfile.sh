VERSION=$(gem search -e eyes_images | grep eyes_images | grep -E -o "[0-9]+.[0-9]+.[0-9]+")
echo "$VERSION"
bundle remove eyes_images && bundle add eyes_images -v "$VERSION"