#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/1c8b7242-17d3-4be8-8d36-fb6b59c0945c"], "output": ["output/output_genome2/reads/sim_transloc_reads1c8b7242-17d3-4be8-8d36-fb6b59c0945c.fa"], "wildcards": {"genome": "genome2", "name": "1c8b7242-17d3-4be8-8d36-fb6b59c0945c"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 298, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_reads1c8b7242-17d3-4be8-8d36-fb6b59c0945c.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva exposures/1c8b7242-17d3-4be8-8d36-fb6b59c0945c --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/298.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/298.jobfailed; exit 1)

