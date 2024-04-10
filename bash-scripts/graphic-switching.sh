#!/bin/bash

# Check if AC adapter is connected
if acpi -a | grep -q 'on-line'; then
	echo "Laptop is plugged in."
	supergfxctl -m Hybrid
	if [ $? -eq 0 ]; then
		echo "Previous command ran successfully."
	else
		echo "Previous command failed."
	fi

else
	echo "Laptop is not plugged in."
	supergfxctl -m Integrated
	if [ $? -eq 0 ]; then
		echo "Previous command ran successfully."
	else
		echo "Previous command failed."
	fi

fi
