#!/bin/bash

host hermione
host hagrid.hogwarts.david.
host -t CNAME rookshanks.hogwarts.david.

nslookup harry
nslookup ron.hogwarts.david.
nslookup luna.ravenclaw.hogwarts.david.

dig info.hogwarts.david. TXT
dig hogwarts.david. SOA 
dig hogwarts.david. NS
dig neville.gryffindor.hogwarts.david.
dig fred.gryffindor.hogwarts.david.