Bootstrap: docker
From: ollama/ollama:{{ OLLAMA_TAG }}

%arguments
	OLLAMA_TAG=latest
	OLLAMA_LIBRARY_URL=https://ollama.com/library

%setup
	[ -n "${APPTAINER_ROOTFS:-}" ] && ./.build-scripts/write-apptainer-labels.sh >"${APPTAINER_ROOTFS}/.build_labels"

%post
	if ! [ -f /etc/debian_version ]; then
		echo "This container is only fully supported on Debian-based systems. Some commands may not work." >&2
	else
		export DEBIAN_FRONTEND=noninteractive
		apt-get update -yq && \
			apt-get install -y curl && \
			apt-get clean &&
			rm -rf /var/lib/apt/lists/* /var/cache/apt/*
	fi

%test
	ollama --help

%runscript
	set -o noglob -o errexit
	if [ $# -eq 0 ] || [ -z "${1:-}" ]; then
		echo "Usage: $0 ollama [args]" >&2
		exit 1
	fi
	OLLAMA_LIBRARY_URL="${OLLAMA_LIBRARY_URL:-{{ OLLAMA_LIBRARY_URL }}}"
	case "${1:-}" in
		available-models)
			shift
			command -v curl >/dev/null || { echo "curl not found. Exiting." >&2; exit 1; }
			curl -sL "${OLLAMA_LIBRARY_URL}" | grep -oP 'href="/library/\K[^"]+' || { echo "No models found at ${OLLAMA_LIBRARY_URL}" >&2; exit 2; }
			exit 0
			;;
		available-tags)
			shift
			command -v curl >/dev/null || { echo "curl not found. Exiting." >&2; exit 1; }
			curl -sL "${OLLAMA_LIBRARY_URL}/$1/tags" | grep -o "$1:[^\" ]*q[^\" ]*" | grep -E -v 'text|base|fp|q[45]_[01]' || { echo "No model tags found at ${OLLAMA_LIBRARY_URL}/$1/tags" >&2; exit 2; }
			exit 0
			;;
		*) 	;;
	esac
	# Run the ollama command with the remaining arguments:
	"$@"

%startscript
	set -o errexit -o noglob
	if [ -z "${OLLAMA_PORT:-}" ]; then
		echo "OLLAMA_PORT not set. Finding a random port to use" >&2
		get_random_port() {
			bash -c 'set -e; read LOWERPORT UPPERPORT < /proc/sys/net/ipv4/ip_local_port_range; PORTRANGE=$(( UPPERPORT - LOWERPORT )); while :; do PORT=$(( LOWERPORT + ( RANDOM % PORTRANGE) )); (echo -n > /dev/tcp/127.0.0/${PORT}) &>/dev/null || echo "${PORT}" && exit 0; done; exit 1'
		}
		OLLAMA_PORT="$(get_random_port)" || {
			echo "Failed to get random port. Exiting." >&2
			exit 1
		}
	fi

	# If we're runninng on klone, we should have access to /gscratch/scrubbed.
	# However, by default, /gscratch is not mounted in the container, whereas /mmfs1 is.
	# /gscratch is the same as /mmfs1/gscratch, so we can use /mmfs1/gscratch/scrubbed.
	if findmnt -M /gscratch -O rw -f 2>/dev/null || findmnt -M /mmfs1 -O rw -f 2>/dev/null; then
		OLLAMA_MODELS="${OLLAMA_MODELS:-${USER_SCRUBBED_DIR:-/gscratch/scrubbed}/${USER}/ollama/models}}"
		OLLAMA_MODELS_REAL="$(realpath "${OLLAMA_MODELS}")"
		if ! mkdir -p "${OLLAMA_MODELS}" 2>/dev/null || ! { [ -d "${OLLAMA_MODELS}" ] && [ ! -w "${OLLAMA_MODELS}" ]; } && [ -d "/mmfs1" ]; then
			case "${OLLAMA_MODELS_REAL}" in
				/gscratch/*) OLLAMA_MODELS="/mmfs1${OLLAMA_MODELS_REAL}" ;;
				*) ;;
			esac
		fi
	fi
	if [ -n "${OLLAMA_MODELS:-}" ]; then
		if [ -f "${OLLAMA_MODELS}" ]; then
			echo "\"${OLLAMA_MODELS}\" is a file. Exiting." >&2
			exit 1
		fi
		if ! mkdir -p "${OLLAMA_MODELS}" 2>/dev/null; then
			echo "Failed to create the directory \"${OLLAMA_MODELS}\". Exiting." >&2
			exit 1
		fi
		if ! [ -r "${OLLAMA_MODELS}" ]; then
			echo "The directory \"${OLLAMA_MODELS}\" is not readable. Exiting." >&2
			exit 1
		fi
		if ! [ -w "${OLLAMA_MODELS}" ]; then
			echo "The directory \"${OLLAMA_MODELS}\" is not writable. Exiting." >&2
			exit 1
		fi
		export OLLAMA_MODELS
	fi
	# Set up OLLAMA_HOST
	export OLLAMA_HOST="${OLLAMA_HOST:-127.0.0.1${OLLAMA_PORT:+:${OLLAMA_PORT}}}"
	ollama serve || {
		echo "Failed to start ollama. Exiting." >&2
		exit 1
	}
	OLLAMA_PID=$!
	trap 'kill -TERM $OLLAMA_PID' TERM INT

%help
	This is a simple container for running Ollama. For more information, visit https://ollama.ai.

