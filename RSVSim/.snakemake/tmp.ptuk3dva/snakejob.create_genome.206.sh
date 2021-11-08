#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/316dbcd5-2e0c-4976-9fe2-c05bce116c0f"], "output": ["output/output_genome2/reads/sim_transloc_reads316dbcd5-2e0c-4976-9fe2-c05bce116c0f.fa"], "wildcards": {"genome": "genome2", "name": "316dbcd5-2e0c-4976-9fe2-c05bce116c0f"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 206, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_reads316dbcd5-2e0c-4976-9fe2-c05bce116c0f.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva exposures/316dbcd5-2e0c-4976-9fe2-c05bce116c0f --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/206.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/206.jobfailed; exit 1)

