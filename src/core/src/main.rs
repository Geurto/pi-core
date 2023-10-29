fn main() -> Result<(), Box<dyn std::error::Error>> {
    let port_name = "/dev/esp32";
    let mut port = serialport::new(port_name, 115_200)
        .timeout(std::time::Duration::from_millis(10))
        .open()
        .expect("Failed to open port");

    let mut serial_buf: Vec<u8> = vec![0; 100];

    loop {
        match port.read(serial_buf.as_mut_slice()) {
            Ok(t) => {
                let s = String::from_utf8_lossy(&serial_buf[..t]);
                println!("{}", s);
            }
            Err(ref e) if e.kind() == std::io::ErrorKind::TimedOut => (),
            Err(e) => eprintln!("{:?}", e),
        }
    }
}
