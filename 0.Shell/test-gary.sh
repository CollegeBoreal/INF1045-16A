#!/bin/bash

echo "What is your name?"
read -sr PERSONNE_INPUT
echo "Bonjour, $PERSONNE_INPUT"
export PERSONNE=$PERSONNE_INPUT
