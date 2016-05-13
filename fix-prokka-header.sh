#!/bin/sh
# Script by JK
# Fixes prokka LOCUS header error where contigXXXXX merges with the contig length.
# Type 'fix-prokka-header.sh -h' for help.

# Functions

function msg
{
	echo "$*"
}

function err
{
	echo "ERROR: $*" 1>&2
	exit 1
}

function usage
{
	msg "Name:"
	msg "  fix-prokka-header.sh"
	msg "Author:"
	msg "  Jason Kwong <j.kwong1@student.unimelb.edu.au>"
	msg "Usage:"
	msg "  fix-prokka-header.sh contigs.gbk > corrected.gbk"
	msg "Parameters:"
	msg "  contigs.gbk    Genbank file from prokka ie. file.gbk"
	msg "Options:"
	msg "  -h             Show this help"
	exit 0
}

# Options
while getopts "ha:t:r:" opt; do
	case $opt in
		h)
			usage ;;
	esac
done

# skip over options to pass arguments
shift $((OPTIND - 1))

# read our mandatory positional parameters
[[ $# -lt 1 ]] && usage

# Insert tab space to fix header
sed -e 's/\(contig000...\)\(\w.* bp\)/\1\t \2/g' $1 >&1 |less
