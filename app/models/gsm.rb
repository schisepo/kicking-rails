require 'serialport'
require 'time'

class GSM
  
  SMSC = "+263772366021"  # SMSC for Vodafone UK - change for other networks

  def initialize(options = {})
    @port = SerialPort.new(options[:port] || 3, options[:baud] || 38400, options[:bits] || 8, options[:stop] || 1, SerialPort::NONE)
    @debug = options[:debug]
    cmd("AT")
    # Set to text mode
    cmd("AT+CMGF=1")
    # Set SMSC number
    cmd("AT+CSCA=\"#{SMSC}\"")    
  end
  
  def close
    @port.close
  end
  
  def cmd(cmd)
    @port.write(cmd + "\r")
    wait
  end
  
  def wait
    buffer = ''
    while IO.select([@port], [], [], 0.25)
      chr = @port.getc.chr;
      print chr if @debug == true
      buffer += chr
    end
    buffer
  end

  def send_sms(options)
    cmd("AT+CMGS=\"#{options[:number]}\"")
    cmd("#{options[:message][0..140]}#{26.chr}\r\r")
    sleep 3
    wait
    cmd("AT")
  end
  
  class SMS
    attr_accessor :id, :sender, :message, :connection
    attr_writer :time
    
    def initialize(params)
        @id = params[:id]; @sender = params[:sender]; @time = params[:time]; @message = params[:message]; @connection = params[:connection]
    end
    
    def delete
      @connection.cmd("AT+CMGD=#{@id}")
    end
    
    def time
      # This MAY need to be changed for non-UK situations, I'm not sure
      # how standardized SMS timestamps are..
      Time.parse(@time.sub(/(\d+)\D+(\d+)\D+(\d+)/, '\2/\3/20\1'))
    end
  end
  
  def messages
    sms = cmd("AT+CMGL=\"ALL\"")
    # Ugly, ugly, ugly!
    msgs = sms.scan(/\+CMGL\:\s*?(\d+)\,.*?\,\"(.+?)\"\,.*?\,\"(.+?)\".*?\n(.*)/)
    return nil unless msgs
    msgs.collect!{ |m| GSM::SMS.new(:connection => self, :id => m[0], :sender => m[1], :time => m[2], :message => m[3].chomp) } rescue nil
  end
end


#destination_number = "+263772222195"

#p = GSM.new(:debug => false)

## Send a text message
#p.send_sms(:number => destination_number, :message => "Test at #{Time.now}")

# #Read text messages from phone
#p.messages.each do |msg|
 # puts "#{msg.id} - #{msg.time} - #{msg.sender} - #{msg.message}"
  # msg.delete
#end