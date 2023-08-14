#!/usr/bin/env sysbench

-- ----------------------------------------------------------------------
-- test speed of CONNECT/DISCONNECT
-- ----------------------------------------------------------------------

function thread_init()
   drv = sysbench.sql.driver()
end

function thread_done()
end

function event()
   con = drv:connect()
   rs = con:query("SELECT 1 FROM dual")
   con:disconnect()
end

