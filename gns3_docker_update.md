```bash

sed -i 's|http://docker/v1.24/|http://docker/v1.44/|g' ~/.local/lib/python3.13/site-packages/gns3server/compute/docker/__init__.py && sed -i 's/DOCKER_MINIMUM_API_VERSION = "1.25"/DOCKER_MINIMUM_API_VERSION = "1.44"/g' ~/.local/lib/python3.13/site-packages/gns3server/compute/docker/__init__.py

```