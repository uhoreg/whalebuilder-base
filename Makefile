SHAREDIR=/usr/share/whalebuilder

DEBRELEASES=sid stretch jessie jessie/backports wheezy wheezy/backports squeeze \
      experimental unstable testing stable stable/backports oldstable/backports

UBUNTURELEASES=latest precise trusty utopic vivid wily

all: $(foreach d, $(DEBRELEASES), debian/$d/Dockerfile) $(foreach d, $(UBUNTURELEASES), ubuntu/$d/Dockerfile)

debian/%/backports/Dockerfile: $(SHAREDIR)/Dockerfile.base.erb
	@mkdir -p debian/$*/backports
	./make_dockerfile.rb --maintainer "Hubert Chathi <hubert@uhoreg.ca>" -r $*-backports debian/$*/backports

debian/%/Dockerfile: $(SHAREDIR)/Dockerfile.base.erb
	@mkdir -p debian/$*
	./make_dockerfile.rb --maintainer "Hubert Chathi <hubert@uhoreg.ca>" -r $* debian/$*

ubuntu/%/Dockerfile: $(SHAREDIR)/Dockerfile.base.erb
	@mkdir -p ubuntu/$*
	./make_dockerfile.rb --maintainer "Hubert Chathi <hubert@uhoreg.ca>" -d ubuntu -r $* ubuntu/$*
