#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/e48c3755-5811-40d2-8c41-1b0b7eee7304"], "output": ["output/output_genome2/reads/sim_transloc_readse48c3755-5811-40d2-8c41-1b0b7eee7304.fa"], "wildcards": {"genome": "genome2", "name": "e48c3755-5811-40d2-8c41-1b0b7eee7304"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 295, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_readse48c3755-5811-40d2-8c41-1b0b7eee7304.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva exposures/e48c3755-5811-40d2-8c41-1b0b7eee7304 --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/295.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/295.jobfailed; exit 1)

