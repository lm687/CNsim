#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/2a5ae02f-d430-4c99-a993-390a49cfc3ab"], "output": ["output/output_genome2/reads/sim_transloc_reads2a5ae02f-d430-4c99-a993-390a49cfc3ab.fa"], "wildcards": {"genome": "genome2", "name": "2a5ae02f-d430-4c99-a993-390a49cfc3ab"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 266, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_reads2a5ae02f-d430-4c99-a993-390a49cfc3ab.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva exposures/2a5ae02f-d430-4c99-a993-390a49cfc3ab --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/266.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/266.jobfailed; exit 1)

