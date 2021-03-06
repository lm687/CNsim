#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/f8865b15-6d06-46e9-8cad-8bc36f31367a"], "output": ["output/output_genome2/reads/sim_transloc_readsf8865b15-6d06-46e9-8cad-8bc36f31367a_nreads8000_sizedels1.fa"], "wildcards": {"genome": "genome2", "name": "f8865b15-6d06-46e9-8cad-8bc36f31367a", "nreads": "8000", "size_deletion": "1"}, "params": {}, "log": [], "threads": 1, "resources": {"tmpdir": "/tmp"}, "jobid": 48, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-cnsigs/bin/python3.9 \
-m snakemake output/output_genome2/reads/sim_transloc_readsf8865b15-6d06-46e9-8cad-8bc36f31367a_nreads8000_sizedels1.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force --cores all --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ce0cgaas exposures/f8865b15-6d06-46e9-8cad-8bc36f31367a --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /home/lm687/.conda/envs/snakemake-cnsigs/bin \
--mode 2  --default-resources "tmpdir=system_tmpdir"  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ce0cgaas/48.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ce0cgaas/48.jobfailed; exit 1)

