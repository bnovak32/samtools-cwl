cwlVersion: v1.2
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: bnovak32/alpine-samtools:1.18
  InlineJavascriptRequirement: {}

baseCommand: ["samtools", "flagstat"]

inputs:
  input_file:
    label: Input S/BAM file
    type: File
    doc: Aligned reads in either SAM or BAM format.
    format: 
      - edam:format_2572  # BAM
      - edam:format_2573  # SAM
      - edam:format_3462  # CRAM
    inputBinding:
      position: 200

  out_format:
    label: Output format
    type: 
      type: enum
      symbols:
        - json
        - tsv 
        - txt
    default: tsv
    doc: Choose between standard text, tab-delimted text (tsv), or json formats
    inputBinding:
      prefix: --output-fmt
  
  output_basename:
    label: Basename for output files
    type: string
    doc: Output files will be named {output_basename}.flagstat.{output_format}
   
outputs:
  flagstat:
    type: File
    streamable: true
    outputBinding:
      glob: $(inputs.output_basename).flagstat.$(inputs.out_format)

stdout: $(inputs.output_basename).flagstat.$(inputs.out_format)

$namespaces:
  edam: http://edamontology.org/
$schemas:
  - https://edamontology.org/EDAM_1.25.owl

