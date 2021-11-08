#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/4e8cf728-45ca-457b-97d7-75810423d4e9"], "output": ["output/output_genome2/reads/sim_transloc_reads4e8cf728-45ca-457b-97d7-75810423d4e9.fa"], "wildcards": {"genome": "genome2", "name": "4e8cf728-45ca-457b-97d7-75810423d4e9"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 290, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_reads4e8cf728-45ca-457b-97d7-75810423d4e9.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.0xxjtz_s exposures/4e8cf728-45ca-457b-97d7-75810423d4e9 --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.0xxjtz_s/290.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.0xxjtz_s/290.jobfailed; exit 1)

