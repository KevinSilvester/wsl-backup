use crate::utils::ProcResult;

pub struct Config {
   pub root_dir: String,
   pub hist_path: String,
   pub all_path: String,
}

impl Config {
   pub fn new() -> ProcResult<Self> {
      let root_dir = std::env::var("ROOT")?;

      Ok(Self {
         root_dir: root_dir.clone(),
         hist_path: format!("{}/.installer-hist", root_dir),
         all_path: format!("{}/.installer-all", root_dir),
      })
   }
}
