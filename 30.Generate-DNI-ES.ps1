function Generate-DNI-ES {
    # Table of letters based on the remainder of the division by 23
    $dniLetters = @("T", "R", "W", "A", "G", "M", "Y", "F", "P", "D", "X", "B", "N", "J", "Z", "S", "Q", "V", "H", "L", "C", "K", "E")
    # Generate an 8-digit number within a realistic range (avoiding very low numbers)
    $dniNumber = (Get-Random -Minimum 1000000 -Maximum 99999999).ToString("D8")
    # Calculate the remainder of the number divided by 23
    $remainder = [int]$dniNumber % 23
    # Get the letter corresponding to the remainder
    $dniLetter = $dniLetters[$remainder]
    # Combine the number and the letter to form the complete DNI
    $dni = "$dniNumber$dniLetter"
    return $dni
}
# Invoke the function to generate a valid DNI
Generate-DNI-ES