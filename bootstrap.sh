#!/bin/bash

# Check if being run as root

apt -y install ssh puppet git

puppet apply ThreeLeaf-4u.pp
