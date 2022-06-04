use clap::{Arg, ArgMatches, Command, ValueHint};

const COMMAND_NAME: &str = "hist";
const VERSION: &str = "v0.2.1";

pub enum CliArg {
   Check(String),
   Add(String),
   Delete(String),
   List,
   Invalid(String),
   Version((String, String))
}

impl Default for CliArg {
   fn default() -> Self {
      Self::Invalid("Invalid argument".to_string())
   }
}

pub struct Cli {
   pub command_name: String,
   pub version: String,
   pub arg: CliArg,
}


impl Cli {
   pub fn new() -> Self {
      let command = Self::build_command();
      let matches = command.get_matches();
      Self {
         command_name: COMMAND_NAME.to_string(),
         version: VERSION.to_string(),
         arg: Self::parse_args(matches),
      }
   }

   pub fn run(&mut self) -> CliArg {
      std::mem::take(&mut self.arg)
   }

   fn parse_args(matches: ArgMatches) -> CliArg {
      let mut count = 0;

      count += matches.occurrences_of("check");
      count += matches.occurrences_of("add");
      count += matches.occurrences_of("delete");
      count += matches.occurrences_of("list");
      count += matches.occurrences_of("version");

      if count > 1 {
         CliArg::Invalid("Too many arguments received".to_string())
      } else {
         let mut arg_id = "";

         if matches.is_present("check") {
            arg_id = "check";
         }

         if matches.is_present("add") {
            arg_id = "add";
         }

         if matches.is_present("delete") {
            arg_id = "delete";
         }

         if matches.is_present("list") {
            arg_id = "list";
         }

         if matches.is_present("version") {
            arg_id = "version";
         }

         let val: &str = if arg_id != "list" && arg_id != "version" {
            matches.value_of(arg_id).unwrap()
         } else {
            ""
         };

         match arg_id {
            "check" => CliArg::Check(val.to_string()),
            "add" => CliArg::Add(val.to_string()),
            "delete" => CliArg::Delete(val.to_string()),
            "list" => CliArg::List,
            "version" => CliArg::Version((COMMAND_NAME.to_string(), VERSION.to_string())),
            _ => CliArg::Invalid("Invalid arguments".to_string()),
         }
      }
   }

   fn build_command() -> Command<'static> {
      return Command::new(COMMAND_NAME)
         .bin_name(COMMAND_NAME)
         .version(VERSION)
         .about("Helper to manage installer history file.")
         .arg_required_else_help(true)
         .disable_version_flag(true)
         .arg(
            Arg::new("check")
               .short('c')
               .long("check")
               .help("Checks if the given program is saved to the installer history file.")
               .takes_value(true)
               .value_name("PROGRAM")
               .multiple_values(false)
               .min_values(1)
               .max_values(1)
               .required(false)
               .value_hint(ValueHint::CommandName),
         )
         .arg(
            Arg::new("add")
               .short('a')
               .long("add")
               .help("Writes new program to the installer history file.")
               .takes_value(true)
               .value_name("PROGRAM")
               .multiple_values(false)
               .min_values(1)
               .max_values(1)
               .required(false)
               .value_hint(ValueHint::CommandName),
         )
         .arg(
            Arg::new("delete")
               .short('d')
               .long("delete")
               .help("Deletes the given program name from the installer history file.")
               .takes_value(true)
               .value_name("PROGRAM")
               .multiple_values(false)
               .min_values(1)
               .max_values(1)
               .required(false)
               .value_hint(ValueHint::CommandName),
         )
         .arg(
            Arg::new("list")
               .short('l')
               .long("list")
               .help("List all programs in installer history file.")
               .takes_value(false)
               .required(false),
         )
         .arg(
            Arg::new("version")
               .short('v')
               .long("version")
               .help("Display version")
               .takes_value(false)
               .required(false)
         );
   }
}
