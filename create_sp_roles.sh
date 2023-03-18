#!/bin/bash

subscription_id=$1
appRoles=( 'Application.Read.All' 'Application.ReadWrite.All' 'Application.ReadWrite.OwnedBy' 'Directory.Read.All' 'Directory.ReadWrite.All' 'Group.Read.All' 'Group.ReadWrite.All' 'GroupMember.Read.All' 'GroupMember.ReadWrite.All' )

## Get Microsoft Graph API Id ##
graphId=$(az ad sp list --query "[?appDisplayName=='Microsoft Graph'].appId | [0]" --all -o tsv)
echo "Graph ID : $graphId"

## Create Service Principal ##
az ad sp create-for-rbac --name="dyn_creds_test" --role="Owner" --scopes="/subscriptions/${subscription_id}" >> sp_test.json
appId=$(jq -r .appId sp_test.json)
echo "Application ID : $appId"

for role in ${appRoles[@]}; do
    role_id=$(az ad sp show --id $graphId --query "appRoles[?value=='${role}'].id | [0]" -o tsv)
    echo "$role = $role_id"
    az ad app permission add --id ${appId} --api ${graphId} --api-permissions ${role_id}=Role
    az ad app permission grant --id ${appId} --api ${graphId} --scope ${role}
done