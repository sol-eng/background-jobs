message("Setting x <- 2")
x <- 2

message("Setting y <- 'b'")
y <- "b"


if (exists("z")) {
  message("Setting z <- mean(z)")
  z <- mean(z)
} else {
  message("No z found!")
} 
