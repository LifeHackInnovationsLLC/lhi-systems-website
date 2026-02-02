#!/bin/bash
# LHI Systems Website - Development Server Launcher
# Usage: ./launch.sh [start|stop|status|restart]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PID_FILE="$SCRIPT_DIR/.server.pid"
LOG_FILE="$SCRIPT_DIR/.server.log"

# Ensure LHI_SCRIPTS_ROOT is set
if [ -z "$LHI_SCRIPTS_ROOT" ]; then
    echo "Error: LHI_SCRIPTS_ROOT not set"
    exit 1
fi

# Source port registry for dynamic port lookup
source "${LHI_SCRIPTS_ROOT}/lhi_modules/lhi_git_projects/LifeHackInnovationsLLC/lhi_node_modules/lhi_bash_utilities/lib/port_registry.sh"
PORT=$(get_port_by_tool "lhisystems-website")

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

get_pid() {
    if [ -f "$PID_FILE" ]; then
        cat "$PID_FILE"
    fi
}

is_running() {
    local pid=$(get_pid)
    if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
        return 0
    fi
    return 1
}

start_server() {
    if is_running; then
        echo -e "${YELLOW}Server already running on port $PORT (PID: $(get_pid))${NC}"
        echo -e "URL: ${GREEN}http://localhost:$PORT${NC}"
        return 0
    fi

    # Check if port is in use
    if lsof -i :$PORT >/dev/null 2>&1; then
        echo -e "${RED}Port $PORT is already in use${NC}"
        lsof -i :$PORT
        return 1
    fi

    echo -e "${GREEN}Starting LHI Systems website on port $PORT...${NC}"
    cd "$SCRIPT_DIR"

    # Use Python's simple HTTP server
    nohup python3 -m http.server $PORT > "$LOG_FILE" 2>&1 &
    echo $! > "$PID_FILE"

    sleep 1
    if is_running; then
        echo -e "${GREEN}Server started successfully${NC}"
        echo -e "URL: ${GREEN}http://localhost:$PORT${NC}"
        echo -e "PID: $(get_pid)"
    else
        echo -e "${RED}Failed to start server${NC}"
        cat "$LOG_FILE"
        return 1
    fi
}

stop_server() {
    if ! is_running; then
        echo -e "${YELLOW}Server is not running${NC}"
        rm -f "$PID_FILE"
        return 0
    fi

    local pid=$(get_pid)
    echo -e "${YELLOW}Stopping server (PID: $pid)...${NC}"
    kill "$pid" 2>/dev/null || true
    rm -f "$PID_FILE"
    echo -e "${GREEN}Server stopped${NC}"
}

show_status() {
    if is_running; then
        echo -e "${GREEN}Server is running${NC}"
        echo -e "PID: $(get_pid)"
        echo -e "Port: $PORT"
        echo -e "URL: http://localhost:$PORT"
    else
        echo -e "${YELLOW}Server is not running${NC}"
    fi
}

case "${1:-start}" in
    start)
        start_server
        ;;
    stop)
        stop_server
        ;;
    restart)
        stop_server
        sleep 1
        start_server
        ;;
    status)
        show_status
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
        ;;
esac
