const shell = require('shelljs');
const fs = require('fs');
const parse = require('csv-parse/lib/sync');
const {Election, irv, plurality, condorcet} = require('caritat');

if (process.argv.length !== 3) {
    console.log('node index.js input.csv');
    return;
}

const content = fs.readFileSync(process.argv[2]);
const csv = parse(content,({delimiter: ","}));

const candidates = csv[0].slice(1);

var election = new Election({
    candidates: candidates
});

const sum = csv.length - 1;

csv.slice(1).forEach(record => {
    record = record.slice(1);
    const ballot = candidates.slice(0).sort(function(a,b) {
        var ia = candidates.indexOf(a);
        var ib = candidates.indexOf(b);
        return record[ib] - record[ia];
    });
    election.addBallot(ballot, 1 / sum * 100);
});

const condorcetWinner = condorcet.winner(election);
console.log(condorcetWinner);