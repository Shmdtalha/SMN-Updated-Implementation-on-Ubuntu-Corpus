import std;
import core.stdc.stdlib : exit;

void main(string[] args){
	if (args.length < 3 || args.canFind("-h") || args.canFind("--help")){
		stderr.writefln!
			"Usage:\n\t%s 2to1 <responses.txt> <file0.txt> ... <outputDir>"(
					args[0]);
		stderr.writefln!
			"\t%s 1to2 <file0.txt> ... <outputDir>"(
					args[0]);
		exit(0);
		return;
	}

	if (args[1] == "2to1"){
		if (args.length < 5){
			stderr.writeln("Not enough arguments. Use --help to see Usage");
			exit(1);
			return;
		}
		string respPath = args[2];
		string[] filesPath = args[3 .. $ - 1];
		string outDir = args[$ - 1];
		string[size_t] responses = responsesParse(respPath);
		foreach (path; filesPath.parallel){
			string base = path.baseName;
			string outPath = format!"%s%s%s"(outDir, dirSeparator, base);
			writefln!"%s starting..."(base);
			immutable size_t count = twoToOne(responses, path, outPath);
			writefln!"%s done. Total output lines: %d"(base, count);
		}
		return;
	}

	if (args[1] == "1to2"){
		stderr.writefln!"1to2 not implemented yet";
		exit(1);
		return;
	}
}

/// Parses responses of corpus v2 format
/// Returns: assoc_array mapping response id to string
string[size_t] responsesParse(string path){
	string[size_t] ret;
	foreach (string[] cols; File(path, "r").byLineCopy.map!(s => s.split("\t"))){
		if (cols.length != 2)
			continue;
		ret[cols[0].to!size_t] = cols[1];
	}
	return ret;
}

/// Converts a file at `path` from corpus v2 to corpus v1 at `outPath`
/// Returns: number of rows in resulting file
size_t twoToOne(string[size_t] responses, string path, string outPath){
	File f = File(outPath, "w");
	size_t ret;
	foreach (char[][] cols; File(path, "r").byLine.map!(s => s.split("\t"))){
		if (cols.length != 4)
			continue;
		foreach (i; 2 .. 4){
			if (cols[i] == "NA")
				continue;
			foreach (size_t id; cols[i].split("|").map!(s => s.to!size_t)){
				f.writefln!"%d\t%s\t%s"(i == 2, cols[1], responses[id]);
				ret ++;
			}
		}
	}
	return ret;
}

/// Converts a corpus v1 at `outPath` to v2. Also updates `responses`
/// Returns: number of rows in resulting file
size_t oneToTwo(ref size_t[string] responses, string path, string outPath){
	size_t ret;
	// TODO

	return ret;
}
