package main

import (
	"dagger.io/dagger"
	"dagger.io/dagger/core"
	"universe.dagger.io/docker"
)

#ExBuild: docker.#Dockerfile & {
	platforms: ["linux/arm64"]

}

// Example usage in a plan
dagger.#Plan & {
	client: {
		filesystem: {
			".": read: contents:            dagger.#FS
			"~/P/do_token": read: contents: dagger.#Secret
		}

		commands: cat: {
			name: "cat"
			args: ["/Users/casey/P/do_token"]
		}
	}

	actions: {
		registry: core.#TrimSecret & {
			input: client.filesystem."~/P/do_token".read.contents
		}
		build: #ExBuild & {
			source: client.filesystem.".".read.contents
		}
		push: docker.#Push & {
			image: build.output
			dest:  "registry.digitalocean.com/bgroupe/obey:bex.01a"
			auth: {
				username: client.commands.cat.stdout
				secret:   registry.output
			}

		}
	}
}
