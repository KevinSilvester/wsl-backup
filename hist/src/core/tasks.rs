use crate::utils::Files;
use crate::utils::Print;
use crate::utils::{ProcResult};
use regex::Regex;

pub struct Tasks {
   file: String,
   installed_programs: Vec<String>,
}

impl Tasks {
   pub fn new(file: String) -> ProcResult<Self> {
      Ok(Self {
         file: file.clone(),
         installed_programs: Files::read_file(&file)?,
      })
   }

   pub fn check_program(&mut self, program: &str, print: bool) -> ProcResult<bool> {
      let re = Regex::new(&format!("^{}$", program))?;
      let mut found = false;
      let p = self.installed_programs.to_owned();

      for program in p {
         if re.is_match(&program) {
            found = true;
         }
      }

      if print {
         match found {
            true => Print::success(format!("{} is installed", program), true),
            false => {
               Print::info(format!("{} is not installed", program), true);
               std::process::exit(1);
            }
         }
      }

      Ok(found)
   }

   pub fn list_programs(&self) {
      println!("{}", self.installed_programs.join("\n"));
   }

   pub fn add_program(&mut self, program: &str) -> ProcResult<()> {
      match self.check_program(program, false) {
         Ok(true) => {
            Print::info(format!("{} is already installed", program), true);
            std::process::exit(1);
         }
         Ok(false) => {
            let mut tmp = std::mem::take(&mut self.installed_programs);
            tmp.push(program.to_string());
            Files::write_file(&self.file, tmp)?;
            Print::success(format!("{} added to hist file", program), true)
         }
         Err(e) => return Err(e),
      }
      Ok(())
   }

   pub fn delete_program(&mut self, program: &str) -> ProcResult<()> {
      match self.check_program(program, false) {
         Ok(true) => {
            let re = Regex::new(&format!("^{}$", program))?;
            let mut tmp = std::mem::take(&mut self.installed_programs);
            tmp.retain(|x| !re.is_match(x));
            Files::write_file(&self.file, tmp)?;
            Print::success(format!("{} deleted from hist file", program), true)
         }
         Ok(false) => {
            Print::info(format!("{} is not installed", program), true);
            std::process::exit(1)
         }
         Err(e) => return Err(e),
      }

      Ok(())
   }
}
