mod files;
mod print;
mod errors;

pub use files::Files;
pub use print::Print;
pub use errors::{ProcResult, ProcError, ErrorKind};

// pub fn attempt<F, E, T>(f: F, e: E) -> T
// where
//    F: FnOnce() -> Result<T, Box<dyn error::Error>>,
//    E: FnOnce(),
// {
//    let exec_fn = || -> Result<T, Box<dyn error::Error>> { f() };

//    match exec_fn() {
//       Ok(val) => val,
//       Err(_err) => {
//          e();
//          process::exit(2);
//       }
//    }
// }
