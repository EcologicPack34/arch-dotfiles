-- show disk in status bar
Status:children_add(function()
    local command = "df -kh .|awk '!/^Filesystem/{printf \" %s FREE \", $(NF-2)}'"
    local info = ui.Span(io.popen(command):read('*a')):fg("green")
    return info
end, 1500, Header.RIGHT)
