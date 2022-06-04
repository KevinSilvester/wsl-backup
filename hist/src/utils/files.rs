use crate::utils::ProcResult;
use std::fs;
use std::io::prelude::*;

pub struct Files;

impl Files {
   pub fn read_file(file: &str) -> ProcResult<Vec<String>> {
      let content = fs::read_to_string(file)?;
      let lines: Vec<&str> = content.split("\n").collect();
      let mut programs = Vec::new();

      lines.iter().for_each(|line| {
         if line.len() > 0 {
            programs.push(line.to_string());
         }
      });

      Ok(programs)
   }

   pub fn write_file(file: &str, content: Vec<String>) -> ProcResult<()> {
      fs::rename(file, &format!("{}.bak", file))?;
      let mut file = fs::OpenOptions::new().write(true).create(true).open(file)?;

      file.write_all(content.join("\n").as_bytes())?;
      file.sync_all()?;
      Ok(())
   }
}
