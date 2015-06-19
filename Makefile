SHAREDIR=/usr/share/whalebuilder

DIST=debian
RELEASES=sid stretch jessie jessie/backports wheezy wheezy/backports squeeze \
      experimental unstable testing stable stable/backports oldstable oldstable/backports

all: $(foreach d, $(RELEASES), $(DIST)/$d/Dockerfile)

$(DIST)/%/backports/Dockerfile: $(SHAREDIR)/Dockerfile.base.erb
	@mkdir -p $(DIST)/$*/backports
	./make_dockerfile.rb --maintainer "Hubert Chathi <hubert@uhoreg.ca>" -d $(DIST) -r $*-backports $(DIST)/$*/backports

$(DIST)/%/Dockerfile: $(SHAREDIR)/Dockerfile.base.erb
	@mkdir -p $(DIST)/$*
	./make_dockerfile.rb --maintainer "Hubert Chathi <hubert@uhoreg.ca>" -d $(DIST) -r $* $(DIST)/$*
