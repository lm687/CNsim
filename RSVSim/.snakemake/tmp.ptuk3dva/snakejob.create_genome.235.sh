#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/e2d26ea9-4a1b-41d7-b3ff-707e8bdaa895"], "output": ["output/output_genome2/reads/sim_transloc_readse2d26ea9-4a1b-41d7-b3ff-707e8bdaa895.fa"], "wildcards": {"genome": "genome2", "name": "e2d26ea9-4a1b-41d7-b3ff-707e8bdaa895"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 235, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_readse2d26ea9-4a1b-41d7-b3ff-707e8bdaa895.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva exposures/e2d26ea9-4a1b-41d7-b3ff-707e8bdaa895 --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/235.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/235.jobfailed; exit 1)

