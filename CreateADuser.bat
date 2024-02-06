# Import the Active Directory module
Import-Module ActiveDirectory

# Set the target OU path = Specifically for OU
$ouPath = "OU={OUNAME},DC={DOMAIN},DC=com"  # Adjust this to match your domain structure

# Set the user details

$firstNames = @("Jane", "John", "Janet", "Jay")
$lastNames = @("doe", "doe", "doe", "doe")
for ($i=0; $i -lt $firstNames.Length; $i++) {

    $userDetails = @{
        SamAccountName    = "$($firstNames[$i])$($lastNames[$i])"
        UserPrincipalName = "$($firstNames[$i]).$($lastNames[$i])@{DOMAIN}.com"
        GivenName         = "$($firstNames[$i])"
        Surname           = "$($lastNames[$i])"
        DisplayName       = "$($firstNames[$i]) $($lastNames[$i])"
        EmailAddress      = "$($firstNames[$i]).$($lastNames[$i])@{DOMAIN}.com"
        AccountPassword   = (ConvertTo-SecureString "password" -AsPlainText -Force)
        Enabled           = $true
        Name              = "$($firstNames[$i]) $($lastNames[$i])"  # Add the "Name" parameter
    }

    # Create the new user in the specified OU
    $newUser = New-ADUser @userDetails -Path $ouPath
}
