from datetime import datetime, timedelta
import sys



if len(sys.argv) == 2:
    offset =sys.argv[1]
    
    if ":" not in offset:
        offset += ":00"
    if offset[0] == "-" or offset[0] == "+":
        direction = offset[0]
        offset = offset[1:].split(":")
    else:
        offset = offset.split(":")
        direction = "+"

    if direction == "-":
        time = (datetime.now() - timedelta(hours = int(offset[0]), minutes = int(offset[1])))
    if direction == "+":
        time = (datetime.now() + timedelta(hours = int(offset[0]), minutes = int(offset[1])))

else:
    time = datetime.now()
print(time.strftime("%H:%M"))
