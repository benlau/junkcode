var program = require('commander');

program
    .version('0.1.0')
    .option('-C, --chdir <path>', 'change the working directory')

program
    .command('init')
    .description("create default rule.json and wizard.json")
    .action(function(cmd,options) {
        console.log("init");
    });

program
    .command("generate <output>")
    .description("generate Qt Creator Wizard Project folder")
    .action(function(cmd, options) {
        console.log("generate", cmd);
    });


program.parse(process.argv);

if (!process.argv.slice(2).length) {
    program.outputHelp();
}
