#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/ffac781d-60f0-4119-b50e-641cb192eb3a"], "output": ["output/output_genome2/reads/sim_transloc_readsffac781d-60f0-4119-b50e-641cb192eb3a.fa"], "wildcards": {"genome": "genome2", "name": "ffac781d-60f0-4119-b50e-641cb192eb3a"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 205, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_readsffac781d-60f0-4119-b50e-641cb192eb3a.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva exposures/ffac781d-60f0-4119-b50e-641cb192eb3a --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/205.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/205.jobfailed; exit 1)

