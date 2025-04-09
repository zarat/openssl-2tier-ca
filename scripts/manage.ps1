function ImportRootCa {

	Param($rootCertPath)
    #$rootCertPath = ".\root-ca.crt"  
	$rootCert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 $rootCertPath
	$store = New-Object System.Security.Cryptography.X509Certificates.X509Store("Root", "CurrentUser")
    $store.Open("MaxAllowed")
    $store.Add($rootCert)
    $store.Close()
    Write-Host "Root CA Zertifikat wurde erfolgreich importiert."

}

function ImportIntermediateCa {

	Param($certPath)
    #$certPath = ".\intermediate-ca.crt"
    $cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 $certPath
    $store = New-Object System.Security.Cryptography.X509Certificates.X509Store("CA", "CurrentUser")
    $store.Open("MaxAllowed")
    $store.Add($cert)
    $store.Close()
    Write-Host "Intermediate CA Zertifikat wurde erfolgreich importiert."

}

function ShowRootCa {

    $store = New-Object System.Security.Cryptography.X509Certificates.X509Store("Root", "CurrentUser")
    $store.Open("ReadOnly")
    $store.Certificates | Format-Table Thumbprint, Subject
    $store.Close()

}

function ShowIntermediateCa {

    $store = New-Object System.Security.Cryptography.X509Certificates.X509Store("CA", "CurrentUser")
    $store.Open("ReadOnly")
    $store.Certificates | Format-Table Thumbprint, Subject
    $store.Close()

}

function RemoveRootCa {

    Param($footprint)

    $thumbprint = $footprint
    $store = New-Object System.Security.Cryptography.X509Certificates.X509Store("Root", "CurrentUser")
    $store.Open("MaxAllowed")
    $certToRemove = $store.Certificates | Where-Object { $_.Thumbprint -eq $thumbprint }
    if ($certToRemove) {
        $store.Remove($certToRemove)
        Write-Host "Zertifikat entfernt: $($certToRemove.Subject)"
    } else {
        Write-Host "Zertifikat mit dem Thumbprint $thumbprint nicht gefunden."
    }
    $store.Close()

}

function RemoveIntermediateCa {

    Param($footprint)

    $thumbprint = $footprint
    $store = New-Object System.Security.Cryptography.X509Certificates.X509Store("CA", "CurrentUser")
    $store.Open("MaxAllowed")
    $certToRemove = $store.Certificates | Where-Object { $_.Thumbprint -eq $thumbprint }
    if ($certToRemove) {
        $store.Remove($certToRemove)
        Write-Host "Zertifikat entfernt: $($certToRemove.Subject)"
    } else {
        Write-Host "Zertifikat mit dem Thumbprint $thumbprint nicht gefunden."
    }
    $store.Close()

}

# Test

#ImportRootCa "..\ca\root\root-ca.crt"
#ImportIntermediateCa "..\ca\intermediate\intermediate-ca.crt"

#RemoveRootCa "C120A3249C48069E19897339F86BBF77DD5BDA59"
#RemoveIntermediateCa "8ED0B30E54CD437E9A1E0C74AD528B933B555EB5"

ShowRootCa
ShowIntermediateCa

pause