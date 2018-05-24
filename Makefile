export BUILDKIT_PROGRESS = plain

REPOSITORY = sensorfu/rust-env
DOCKER = docker

# Rust version dash our container version
VERSION = 1.65.0-0

build: glibc linux-amd64 linux-armv7 linux-aarch64 linux-mips32el
push: push-glibc push-linux-amd64 push-linux-armv7 push-linux-aarch64

glibc: Dockerfile.glibc
	$(DOCKER) build -t $(REPOSITORY):$@-$(VERSION) -f $< .
	$(DOCKER) tag $(REPOSITORY):$@-$(VERSION) $(REPOSITORY):$@-latest

linux-amd64: Dockerfile.linux-amd64 cargo.config
	$(DOCKER) build -t $(REPOSITORY):$@-$(VERSION) -f $< .
	$(DOCKER) tag $(REPOSITORY):$@-$(VERSION) $(REPOSITORY):$@-latest

linux-armv7: Dockerfile.linux-armv7 cargo.config
	$(DOCKER) build -t $(REPOSITORY):$@-$(VERSION) -f $< .
	$(DOCKER) tag $(REPOSITORY):$@-$(VERSION) $(REPOSITORY):$@-latest

linux-aarch64: Dockerfile.linux-aarch64 cargo.config
	$(DOCKER) build -t $(REPOSITORY):$@-$(VERSION) -f $< .
	$(DOCKER) tag $(REPOSITORY):$@-$(VERSION) $(REPOSITORY):$@-latest

linux-mips32el: Dockerfile.linux-mips32el cargo.config
	$(DOCKER) build -t $(REPOSITORY):$@-$(VERSION) -f $< .
	$(DOCKER) tag $(REPOSITORY):$@-$(VERSION) $(REPOSITORY):$@-latest

push-glibc: glibc
	$(DOCKER) push $(REPOSITORY):$<-$(VERSION)
	$(DOCKER) push $(REPOSITORY):$<-latest

push-linux-amd64: linux-amd64
	$(DOCKER) push $(REPOSITORY):$<-$(VERSION)
	$(DOCKER) push $(REPOSITORY):$<-latest

push-linux-armv7: linux-armv7
	$(DOCKER) push $(REPOSITORY):$<-$(VERSION)
	$(DOCKER) push $(REPOSITORY):$<-latest

push-linux-aarch64: linux-aarch64
	$(DOCKER) push $(REPOSITORY):$<-$(VERSION)
	$(DOCKER) push $(REPOSITORY):$<-latest

push-linux-mips32el: linux-mips32el
	$(DOCKER) push $(REPOSITORY):$<-$(VERSION)
	$(DOCKER) push $(REPOSITORY):$<-latest

.PHONY: build push glibc linux-amd64 linux-armv7 linux-aarch64 linux-mips32el push-glibc push-linux-amd64 push-linux-armv7 push-linux-aarch64 push-linux-mips32el
