#!/bin/sh
# properties = {"type": "single", "rule": "align_bwa", "local": false, "input": ["output/output_genome2/reads/sim_transloc_readsa161a6c7-2fbd-4901-a163-9c3455d1ee59_nreads12000_sizedels1000.fa"], "output": ["output/output_genome2/alignments/aligned_sim_transloc_readsa161a6c7-2fbd-4901-a163-9c3455d1ee59_nreads12000_sizedels1000.bam"], "wildcards": {"genome": "genome2", "name": "a161a6c7-2fbd-4901-a163-9c3455d1ee59", "nreads": "12000", "size_deletion": "1000"}, "params": {}, "log": [], "threads": 1, "resources": {"tmpdir": "/tmp"}, "jobid": 119, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-cnsigs/bin/python3.9 \
-m snakemake output/output_genome2/alignments/aligned_sim_transloc_readsa161a6c7-2fbd-4901-a163-9c3455d1ee59_nreads12000_sizedels1000.bam --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force --cores all --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.apon5uti output/output_genome2/reads/sim_transloc_readsa161a6c7-2fbd-4901-a163-9c3455d1ee59_nreads12000_sizedels1000.fa --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules align_bwa --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /home/lm687/.conda/envs/snakemake-cnsigs/bin \
--mode 2  --default-resources "tmpdir=system_tmpdir"  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.apon5uti/119.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.apon5uti/119.jobfailed; exit 1)

