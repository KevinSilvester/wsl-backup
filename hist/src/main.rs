use std::process::exit;

mod core;
mod utils;

use crate::core::Config;
use crate::core::Tasks;
use crate::core::{Cli, CliArg};
use crate::utils::Print;
use crate::utils::{ErrorKind, ProcResult};

fn main() {
   let _fn = || -> ProcResult<()> {
      let config = Config::new()?;
      let mut tasks = Tasks::new(config.hist_path)?;

      match Cli::new().run() {
         CliArg::Add(program) => tasks.add_program(&program),
         CliArg::Delete(program) => tasks.delete_program(&program),
         CliArg::Check(program) => {
            tasks.check_program(&program, true)?;
            Ok(())
         }
         CliArg::List => {
            tasks.list_programs();
            Ok(())
         }
         CliArg::Version((a, b)) => {
            Print::success(a, false);
            print!(" ");
            Print::plain(b, true);
            Ok(())
         }
         CliArg::Invalid(msg) => {
            Print::error(&msg, false);
            exit(1);
         }
      }
   };

   match _fn() {
      Ok(_) => exit(0),
      Err(error) => match error.kind {
         ErrorKind::Cli => {
            Print::error("Error: invalid command line arguments", true);
            exit(1);
         }
         ErrorKind::Io => {
            Print::error("Error: unable to read/write files", true);
            exit(1);
         }
         ErrorKind::Regex => {
            Print::error("Error: invalid regular expression", true);
            exit(1);
         }
         ErrorKind::Env => {
            Print::error("Error: unable to read/write environment variables", true);
            exit(1);
         }
         ErrorKind::Other => {
            Print::error("Error: unknown error", true);
            exit(1);
         }
      },
   }
}
