use ansi_term::Colour;

pub struct Print;

const ERROR: Colour = Colour::RGB(235, 66, 66);
const SUCCESS: Colour = Colour::RGB(71, 201, 106);
const INFO: Colour = Colour::RGB(242, 165, 48);

// trait

impl Print {
   pub fn plain<A>(msg: A, new_line: bool)
   where
      A: ToString,
   {
      match new_line {
         true => println!("{}", msg.to_string()),
         false => print!("{}", msg.to_string()),
      }
   }

   pub fn error<A>(msg: A, new_line: bool)
   where
      A: ToString,
   {
      match new_line {
         true => println!("{}", ERROR.paint(msg.to_string())),
         false => print!("{}", ERROR.paint(msg.to_string())),
      }
   }

   pub fn success<A>(msg: A, new_line: bool)
   where
      A: ToString,
   {
      match new_line {
         true => println!("{}", SUCCESS.paint(msg.to_string())),
         false => print!("{}", SUCCESS.paint(msg.to_string())),
      }
   }

   pub fn info<A>(msg: A, new_line: bool)
   where
      A: ToString,
   {
      match new_line {
         true => println!("{}", INFO.paint(msg.to_string())),
         false => print!("{}", INFO.paint(msg.to_string())),
      }
   }
}

