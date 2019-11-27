# Flatpak in Docker example

> An example of building a Flatpak inside a Docker container

## Scenario

An Ubuntu Xenial instance running the HWE kernel (from the
`linux-virtual-hwe-16.04` package, version 4.15 at the time of writing) and
Docker from the `docker.io` package in the Ubuntu repos (version 18.09 at the
time of writing).

## Example

To build the container and run it:

```
docker build -t flatpak-builder https://raw.githubusercontent.com/adarnimrod/flatpak-docker-example/master/Dockerfile
docker run -it --security-opt seccomp=unconfined --security-opt apparmor=unconfined -v '/proc:/proc' -v '/var/cache/flatpak:/var/lib/builder/.local/share/flatpak' flatpak-builder
```

To pull the dependencies and build the Endless SDK inside the container:

```
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
for dep in org.freedesktop.Sdk/x86_64/1.6 org.freedesktop.Platform/x86_64/1.6  org.gnome.Sdk/x86_64/3.28 org.gnome.Sdk.Debug/x86_64/3.28 org.gnome.Sdk.Docs/x86_64/3.28 org.gnome.Platform/x86_64/3.28 ; do \
	flatpak install -y --user flathub $dep ; \
	flatpak update -y --user $dep ; \
done
flatpak list --user --runtime --show-details
for dep in org.gnome.Platform.Locale/x86_64/3.28 org.gnome.Sdk.Locale/x86_64/3.28 ; do \
	flatpak uninstall -y --user $dep || true ; \
	flatpak install -y --user --reinstall flathub $dep ; \
done
flatpak install --user flathub org.gnome.Sdk.Debug
flatpak list --user --runtime --all --show-details
	
flatpak-builder --verbose --disable-rofiles-fuse --from-git=https://github.com/adarnimrod/flatpak-docker-example builddir com.endlessm.apps.Sdk.json
```
