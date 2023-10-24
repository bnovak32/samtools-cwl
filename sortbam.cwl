cwlVersion: v1.2
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: bnovak32/alpine-samtools:1.18
  InlineJavascriptRequirement: {}

baseCommand: ["samtools", "sort"]

arguments:
  - "--write-index"
  - prefix: "-o"
    valueFrom: |
      ${
        if (inputs.sort_mode == "coordinate") {
          return inputs.output_basename.concat(".sorted.bam##idx##",inputs.output_basename,".sorted.bai")
        } else if (inputs.sort_mode == "template-coordinate") {
          return inputs.output_basename.concat(".tc_sorted.bam")
        } else if (inputs.sort_mode == "queryname") {
          return inputs.output_basename.concat(".qn_sorted.bam")
        }
      }

inputs:
  unsorted_alignments:
    label: Input S/BAM file
    type: File
    doc: Aligned reads in either SAM or BAM format.
    format: 
      - edam:format_2572  # BAM
      - edam:format_2573  # SAM
    inputBinding:
      position: 200

  sort_mode:
    type:
      type: enum
      symbols: 
        - coordinate
        - queryname
        - template-coordinate
      inputBinding:
        shellQuote: false
        valueFrom: |
          ${ if(inputs.sort_mode == "queryname") {
              return "-n"
            } else if(inputs.sort_mode == "template-coordinate") {
              return "--template-coordinate"
            } else { 
              return null 
            }
          }
          
  output_basename:
    label: Basename for output files
    type: string
    doc: "Output files will be named {output_basename}.sorted.bam"
   
outputs:
  sorted_alignments:
    type: File
    secondaryFiles:
      - ^.bai?
    format: edam:format_2572  # BAM
    outputBinding:
      glob: $(inputs.output_basename)*sorted.bam

$namespaces:
  edam: http://edamontology.org/
$schemas:
  - https://edamontology.org/EDAM_1.25.owl

