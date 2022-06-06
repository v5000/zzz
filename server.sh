#!/bin/bash
az group create --name  Server --location centralus
az vm create --resource-group Server --name vps1 --location centralus --image UbuntuLTS --size Standard_D4s_v4 --admin-username azureuser --admin-password JAKnakska77wdwdd --no-wait