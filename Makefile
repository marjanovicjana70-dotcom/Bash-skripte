
STATS_SCRIPT=src/stats.sh
LOGS_SCRIPT=src/logs.sh

show-stats: ${STATS_SCRIPT}
	@bash ${STATS_SCRIPT}

show-logs: ${LOGS_SCRIPT}
	@bash ${LOGS_SCRIPT}