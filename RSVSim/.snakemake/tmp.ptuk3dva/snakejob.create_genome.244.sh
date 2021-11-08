#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/c282b75c-e7d7-4bc1-82ef-fd995fb9bcaf"], "output": ["output/output_genome2/reads/sim_transloc_readsc282b75c-e7d7-4bc1-82ef-fd995fb9bcaf.fa"], "wildcards": {"genome": "genome2", "name": "c282b75c-e7d7-4bc1-82ef-fd995fb9bcaf"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 244, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_readsc282b75c-e7d7-4bc1-82ef-fd995fb9bcaf.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva exposures/c282b75c-e7d7-4bc1-82ef-fd995fb9bcaf --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/244.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/244.jobfailed; exit 1)

