var documenterSearchIndex = {"docs": [

{
    "location": "#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "#BioGenerics.IO.AbstractFormattedIO",
    "page": "Home",
    "title": "BioGenerics.IO.AbstractFormattedIO",
    "category": "type",
    "text": "Abstract formatted input/output type.\n\n\n\n\n\n"
},

{
    "location": "#BioGenerics.IO.AbstractReader",
    "page": "Home",
    "title": "BioGenerics.IO.AbstractReader",
    "category": "type",
    "text": "Abstract data reader type.\n\nSee subtypes(AbstractReader) for all available data readers.\n\n\n\n\n\n"
},

{
    "location": "#BioGenerics.IO.AbstractWriter",
    "page": "Home",
    "title": "BioGenerics.IO.AbstractWriter",
    "category": "type",
    "text": "Abstract data writer type.\n\nSee subtypes(AbstractWriter) for all available data writers.\n\n\n\n\n\n"
},

{
    "location": "#BioGenerics.IO.stream",
    "page": "Home",
    "title": "BioGenerics.IO.stream",
    "category": "function",
    "text": "stream(io::AbstractFormattedIO)\n\nReturn the underlying IO object; subtypes of AbstractFormattedIO must implement this method.\n\n\n\n\n\n"
},

{
    "location": "#BioGenerics.IO.tryread!-Tuple{BioGenerics.IO.AbstractReader,Any}",
    "page": "Home",
    "title": "BioGenerics.IO.tryread!",
    "category": "method",
    "text": "tryread!(reader::AbstractReader, output)\n\nTry to read the next element into output from reader.\n\nIf the result could not be read, then nothing will be returned instead.\n\n\n\n\n\n"
},

{
    "location": "#BioGenerics.Exceptions.MissingFieldException",
    "page": "Home",
    "title": "BioGenerics.Exceptions.MissingFieldException",
    "category": "type",
    "text": "MissingFieldException <: Exception\n\nAn exception type thrown when a missing field of a record is accessed.\n\n\n\n\n\n"
},

{
    "location": "#BioGenerics.Testing.intempdir",
    "page": "Home",
    "title": "BioGenerics.Testing.intempdir",
    "category": "function",
    "text": "intempdir(fn::Function, parent = tempdir())\n\nExecute some function fn in a temporary directory. After the function is executed, the directory is cleaned by doing the equivalent of rm -r.\n\n\n\n\n\n"
},

{
    "location": "#BioGenerics.Testing.random_aa-Tuple{Any}",
    "page": "Home",
    "title": "BioGenerics.Testing.random_aa",
    "category": "method",
    "text": "random_aa(n, probs = [0.24, 0.24, 0.24, 0.24, 0.04])\n\nCreate a random amino acid sequence of length n, by sampling the possible amino acid characters.\n\n\n\n\n\n"
},

{
    "location": "#BioGenerics.Testing.random_array-Tuple{Integer,Any,Any}",
    "page": "Home",
    "title": "BioGenerics.Testing.random_array",
    "category": "method",
    "text": "random_array(n::Integer, elements, probs)\n\nCreate a random array of length n, composed of possible elements, which are selected according to their prob.\n\n\n\n\n\n"
},

{
    "location": "#BioGenerics.Testing.random_dna",
    "page": "Home",
    "title": "BioGenerics.Testing.random_dna",
    "category": "function",
    "text": "random_dna(n, probs = [0.24, 0.24, 0.24, 0.24, 0.04])\n\nCreate a random DNA sequence of length n, by sampling the nucleotides A, C, G, T, and N, according to their probability in probs. \n\n\n\n\n\n"
},

{
    "location": "#BioGenerics.Testing.random_interval-Tuple{Any,Any}",
    "page": "Home",
    "title": "BioGenerics.Testing.random_interval",
    "category": "method",
    "text": "random_interval(minstart, maxstop)\n\nCreate a random interval between a minimum starting point, and a maximum stop point.\n\n\n\n\n\n"
},

{
    "location": "#BioGenerics.Testing.random_rna",
    "page": "Home",
    "title": "BioGenerics.Testing.random_rna",
    "category": "function",
    "text": "random_rna(n, probs = [0.24, 0.24, 0.24, 0.24, 0.04])\n\nCreate a random RNA sequence of length n, by sampling the nucleotides A, C, G, U, and N, according to their probability in probs. \n\n\n\n\n\n"
},

{
    "location": "#BioGenerics.Testing.random_seq-Tuple{Integer,Any,Any}",
    "page": "Home",
    "title": "BioGenerics.Testing.random_seq",
    "category": "method",
    "text": "random_seq(n::Integer, nts, probs)\n\nCreate a random sequence of length n, composed of nts, according to their prob.\n\n\n\n\n\n"
},

{
    "location": "#BioGenerics-1",
    "page": "Home",
    "title": "BioGenerics",
    "category": "section",
    "text": "Modules = [BioGenerics, BioGenerics.IO, BioGenerics.Exceptions, BioGenerics.Testing]"
},

]}
