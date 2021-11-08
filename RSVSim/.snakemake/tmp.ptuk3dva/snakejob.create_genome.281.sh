#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/68cef2f2-9802-49a5-b4b2-15b97a73ebf5"], "output": ["output/output_genome2/reads/sim_transloc_reads68cef2f2-9802-49a5-b4b2-15b97a73ebf5.fa"], "wildcards": {"genome": "genome2", "name": "68cef2f2-9802-49a5-b4b2-15b97a73ebf5"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 281, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_reads68cef2f2-9802-49a5-b4b2-15b97a73ebf5.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva exposures/68cef2f2-9802-49a5-b4b2-15b97a73ebf5 --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/281.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/281.jobfailed; exit 1)

