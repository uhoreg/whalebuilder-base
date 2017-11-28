SHAREDIR=/usr/share/whalebuilder

DEBIAN_RELEASES=sid buster stretch stretch/backports jessie jessie/backports wheezy wheezy/backports squeeze \
      experimental unstable testing stable stable/backports oldstable oldstable/backports

UBUNTU_RELEASES=trusty xenial zesty artful bionic

all: $(foreach d, $(DEBIAN_RELEASES), debian/$d/Dockerfile) $(foreach d, $(UBUNTU_RELEASES), ubuntu/$d/Dockerfile)

debian/%/backports/Dockerfile: $(SHAREDIR)/Dockerfile.base.erb
	@mkdir -p debian/$*/backports
	./make_dockerfile.rb --maintainer "Hubert Chathi <hubert@uhoreg.ca>" -d debian -r $*-backports debian/$*/backports

debian/%/Dockerfile: $(SHAREDIR)/Dockerfile.base.erb
	@mkdir -p debian/$*
	./make_dockerfile.rb --maintainer "Hubert Chathi <hubert@uhoreg.ca>" -d debian -r $* debian/$*

ubuntu/%/Dockerfile: $(SHAREDIR)/Dockerfile.base.erb
	@mkdir -p ubuntu/$*
	./make_dockerfile.rb --maintainer "Hubert Chathi <hubert@uhoreg.ca>" -d ubuntu -r $* ubuntu/$*
