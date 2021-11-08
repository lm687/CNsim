#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/f5943654-4487-4d0a-8f15-d601b6268e37"], "output": ["output/output_genome2/reads/sim_transloc_readsf5943654-4487-4d0a-8f15-d601b6268e37.fa"], "wildcards": {"genome": "genome2", "name": "f5943654-4487-4d0a-8f15-d601b6268e37"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 272, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_readsf5943654-4487-4d0a-8f15-d601b6268e37.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva exposures/f5943654-4487-4d0a-8f15-d601b6268e37 --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/272.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/272.jobfailed; exit 1)

