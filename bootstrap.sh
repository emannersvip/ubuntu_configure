#!/bin/bash

# Check if being run as root

apt -y install ssh puppet git

puppet apply base_setup.pp
