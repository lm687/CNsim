#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/aca7ed22-af97-452b-ac62-b00d148a62ea"], "output": ["output/output_genome2/reads/sim_transloc_readsaca7ed22-af97-452b-ac62-b00d148a62ea.fa"], "wildcards": {"genome": "genome2", "name": "aca7ed22-af97-452b-ac62-b00d148a62ea"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 245, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_readsaca7ed22-af97-452b-ac62-b00d148a62ea.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva exposures/aca7ed22-af97-452b-ac62-b00d148a62ea --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/245.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/245.jobfailed; exit 1)

