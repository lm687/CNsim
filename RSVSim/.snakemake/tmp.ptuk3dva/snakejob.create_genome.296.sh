#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/55c926e3-e0c5-4f35-b916-213d20536980"], "output": ["output/output_genome2/reads/sim_transloc_reads55c926e3-e0c5-4f35-b916-213d20536980.fa"], "wildcards": {"genome": "genome2", "name": "55c926e3-e0c5-4f35-b916-213d20536980"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 296, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_reads55c926e3-e0c5-4f35-b916-213d20536980.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva exposures/55c926e3-e0c5-4f35-b916-213d20536980 --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/296.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/296.jobfailed; exit 1)

