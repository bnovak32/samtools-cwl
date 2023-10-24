cwlVersion: v1.2
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: bnovak32/alpine-samtools:1.18
  InlineJavascriptRequirement: {}

baseCommand: ["samtools", "view"]

arguments:
  - valueFrom: "-h"  # include the headers
    position: 1
  - valueFrom: "-b"  # output BAM format
    position: 2
  - valueFrom: "--no-PG"  # don't add the PG header
  
stdout: $(inputs.samfile.nameroot).bam

inputs:
  samfile:
    label: Input SAM file
    type: File
    doc: Aligned reads in SAM format.
    format: 
      - edam:format_2573  # SAM
    inputBinding:
      position: 3
  
outputs:
  bamfile:
    type: File
    format: edam:format_2572  # BAM
    outputBinding:
      glob: $(inputs.samfile.nameroot).bam
      
$namespaces:
  edam: http://edamontology.org/
$schemas:
  - https://edamontology.org/EDAM_1.25.owl

