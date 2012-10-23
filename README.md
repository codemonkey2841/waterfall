This script lays out a debt repayment plan as per the Waterfall (or Snowball)
method.

When run. the script will read from a file called debts in the current
directory, then ask you for any extra funds to be used in the repayment plan
the are not accounted for in the minimum payments, and calculate the debt 
repayment plan.

# Debts File

The debts file is a comma-separated value (CSV) file that is in the format:
   
> Debt Label,Interest Rate (0-1),Minimum Payment,Current Balance


