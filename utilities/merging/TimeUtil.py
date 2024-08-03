from datetime import datetime, timezone

def unix_to_utc(unix_time):
    """
    Convert Unix timestamp to UTC human-readable format.
    """
    utc_time = datetime.fromtimestamp(unix_time, tz=timezone.utc)
    return utc_time.strftime('%Y-%m-%d %H:%M:%S %Z')

def unix_to_timestamp(unix_time):
    """
    Convert Unix timestamp to UTC timestamp for filenams
    """
    utc_time = datetime.fromtimestamp(unix_time, tz=timezone.utc)
    return utc_time.strftime('%Y%m%dT%H%M%SZ')

def unix_to_isotimestamp(unix_time):
    """
    Convert Unix timestamp to UTC timestamp in ISO format
    """
    
    stringtime = (datetime.fromtimestamp(unix_time,tz=timezone.utc)).isoformat(timespec='seconds')
    return stringtime

def utc_to_unix(utc_time):
    """
    Convert UTC human-readable format to Unix timestamp.
    """
    dt = datetime.strptime(utc_time, '%Y-%m-%d %H:%M:%S')
    dt = dt.replace(tzinfo=timezone.utc)
    return int(dt.timestamp())

def sam_to_unix(utc_time):
    """
    Convert UTC human-readable format to Unix timestamp.
    """
    dt = datetime.strptime(utc_time, '%Y-%m-%dT%H:%M:%S%z')
    dt = dt.replace(tzinfo=timezone.utc)
    return int(dt.timestamp())


def utcdate_to_unix(utc_time):
    """
    Convert UTC human-readable format to Unix timestamp.
    """
    dt = datetime.strptime(utc_time, '%Y-%m-%d')
    dt = dt.replace(tzinfo=timezone.utc)
    return int(dt.timestamp())

if __name__ == '__main__':

    day = "2024-04-01"
    time = "2024-04-01 12:00:00"

    unixdate = utcdate_to_unix(day)
    print ("day->unix",day,unixdate)
    unixtime = utc_to_unix(time)
    print ("time->unix",day,unixdate)

    newunixtime = unixtime+100000

    newdate = unix_to_utc(newunixtime)
    print ("unix->time",newunixtime,newdate)
    newtimestamp = unix_to_timestamp(newunixtime)
    print ("unix->timestamp",newunixtime,newtimestamp)
    newtimestamp = unix_to_isotimestamp(newunixtime)
    print ("unix->isotimestamp",newunixtime,newtimestamp)
    samtime = "2024-02-29T17:25:53+00:00"
    newtimestamp = sam_to_unix(samtime)
    print ("sam --> unix",samtime, newtimestamp)
    print ("sam --> utc",samtime,unix_to_utc(newtimestamp))

