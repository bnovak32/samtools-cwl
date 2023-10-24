cwlVersion: v1.2
class: CommandLineTool

label: Create a BAM index
doc: |
  Given a coordinate-sorted BAM file, generate an index file and return the original 
  sorted BAM with the index file as a secondaryFile.

requirements:
  DockerRequirement:
    dockerPull: bnovak32/alpine-samtools:1.18
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.sorted_bam)

baseCommand: ["samtools", "index"]

arguments:
  - valueFrom: "-b"
    position: 1

inputs:
  sorted_bam:
    label: Input BAM file
    type: File
    doc: Aligned reads in BAM format. Must be coordinate sorted.
    format: 
      - edam:format_2572  # BAM
    inputBinding:
      position: 200

outputs:
  bam_sorted_indexed:
    type: File
    secondaryFiles: 
      - .bai
    format: edam:format_2572  # BAM
    outputBinding:
      glob: $(inputs.sorted_bam.basename)


$namespaces:
  edam: http://edamontology.org/
$schemas:
  - https://edamontology.org/EDAM_1.25.owl

