cwlVersion: v1.2
class: CommandLineTool

label: Create BAI index file.
doc: | 
  Given a coordinate-sorted BAM file, create a BAI index file and return it.

requirements:
  DockerRequirement:
    dockerPull: bnovak32/alpine-samtools:1.18
  InlineJavascriptRequirement: {}
  
baseCommand: ["samtools", "index"]

arguments:
  - valueFrom: "-b"  # force BAI format
    position: 1
  - prefix: "-o"  # write output to specific location
    valueFrom: $(runtime.outdir)/$(inputs.sorted_bam.basename).bai
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
  bam_index:
    type: File
    format: edam:format_3327  # BAI
    outputBinding:
      glob: $(inputs.sorted_bam.basename).bai


$namespaces:
  edam: http://edamontology.org/
$schemas:
  - https://edamontology.org/EDAM_1.25.owl

