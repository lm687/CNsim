#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/07b96ad4-640b-48fb-8c60-04e63b5239b4"], "output": ["output/output_genome2/reads/sim_transloc_reads07b96ad4-640b-48fb-8c60-04e63b5239b4.fa"], "wildcards": {"genome": "genome2", "name": "07b96ad4-640b-48fb-8c60-04e63b5239b4"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 282, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_reads07b96ad4-640b-48fb-8c60-04e63b5239b4.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva exposures/07b96ad4-640b-48fb-8c60-04e63b5239b4 --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/282.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/282.jobfailed; exit 1)

