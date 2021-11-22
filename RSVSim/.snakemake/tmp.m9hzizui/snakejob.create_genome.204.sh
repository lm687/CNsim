#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/58cb6baf-cca1-4d4b-8575-aefda2f6f8de"], "output": ["output/output_genome2/reads/sim_transloc_reads58cb6baf-cca1-4d4b-8575-aefda2f6f8de_nreads12000_sizedels1000.fa"], "wildcards": {"genome": "genome2", "name": "58cb6baf-cca1-4d4b-8575-aefda2f6f8de", "nreads": "12000", "size_deletion": "1000"}, "params": {}, "log": [], "threads": 1, "resources": {"tmpdir": "/tmp"}, "jobid": 204, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-cnsigs/bin/python3.9 \
-m snakemake output/output_genome2/reads/sim_transloc_reads58cb6baf-cca1-4d4b-8575-aefda2f6f8de_nreads12000_sizedels1000.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force --cores all --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.m9hzizui exposures/58cb6baf-cca1-4d4b-8575-aefda2f6f8de --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /home/lm687/.conda/envs/snakemake-cnsigs/bin \
--mode 2  --default-resources "tmpdir=system_tmpdir"  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.m9hzizui/204.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.m9hzizui/204.jobfailed; exit 1)

