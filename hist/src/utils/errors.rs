use anyhow;
use std::fmt;

pub type ProcResult<T> = anyhow::Result<T, ProcError>;

pub enum ErrorKind {
   Cli,
   Io,
   Regex,
   Other,
   Env
}

pub struct ProcError {
   pub kind: ErrorKind,
   pub message: String
}

impl ProcError {
   pub fn new(kind: ErrorKind, message: String) -> ProcError {
      ProcError {
         kind,
         message
      }
   }
}

impl fmt::Display for ProcError {
   fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
      match &self.kind {
         _ => write!(f, "{}", self.message),
      }
   }
}

impl From<anyhow::Error> for ProcError {
   fn from(err: anyhow::Error) -> ProcError {
      ProcError::new(ErrorKind::Other, err.to_string())
   }
}

impl From<clap::Error> for ProcError {
   fn from(err: clap::Error) -> ProcError {
      ProcError::new(ErrorKind::Cli, err.to_string())
   }
}

impl From<std::io::Error> for ProcError {
   fn from(err: std::io::Error) -> ProcError {
      ProcError::new(ErrorKind::Io, err.to_string())
   }
}

impl From<regex::Error> for ProcError {
   fn from(err: regex::Error) -> ProcError {
      ProcError::new(ErrorKind::Regex, err.to_string())
   }
}

impl From<std::env::VarError> for ProcError {
   fn from(err: std::env::VarError) -> ProcError {
      ProcError::new(ErrorKind::Env, err.to_string())
   }
}
