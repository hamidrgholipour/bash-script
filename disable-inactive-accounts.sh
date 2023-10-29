#!/bin/bash

lastlog -b 90  | awk '{print $1}' | xargs -I{} echo {}
