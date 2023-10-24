cwlVersion: v1.2
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: bnovak32/alpine-samtools:1.18
  InlineJavascriptRequirement: {}

baseCommand: ["samtools", "stats"]

inputs:
  input_file:
    label: Input S/BAM file
    type: File
    doc: Aligned reads in either SAM, BAM, or CRAM format.
    format: 
      - edam:format_2572  # BAM
      - edam:format_2573  # SAM
      - edam:format_3462  # CRAM
    inputBinding:
      position: 200

  remove_dups:
    label: Exclude duplicates
    type: boolean?
    inputBinding:
      prefix: --remove-dups
    doc: Exclude reads marked as duplicates in the stats output

  ref_seq:
    label: Genome reference
    type: File?
    doc: Reference sequence (required for GC-depth and mismatches-per-cycle calculation).
    inputBinding:
      prefix: -r

  remove_overlaps:
    label: Remove overlap
    type: boolean?
    doc: "Remove overlaps of paired-end reads from coverage and base count computations. "
    inputBinding:
      prefix: --remove-overlaps

  output_basename:
    label: Basename for output files
    type: string
    doc: Output files will be named {output_basename}.stats.txt
   
outputs:
  sam_stats:
    type: File
    streamable: true
    outputBinding:
      glob: $(inputs.output_basename).stats.txt

stdout: $(inputs.output_basename).stats.txt

$namespaces:
  edam: http://edamontology.org/
$schemas:
  - https://edamontology.org/EDAM_1.25.owl

