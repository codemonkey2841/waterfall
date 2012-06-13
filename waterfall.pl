#!/usr/bin/perl

my @debts;

print "Excess funds: \$";
my $extra = <>;

open(FILE, "<debts");
chomp(my @lines = <FILE>);
close FILE;

my $i = 0;
foreach my $line (@lines) {
   my @chunk = split(/,/, $line);
   $debts[$i] = {
      'name'     => $chunk[0],
      'interest' => $chunk[1],
      'payment'  => $chunk[2],
      'balance'  => $chunk[3],
      'paid'     => 0,
   };
   $i++;
}

my @sdebts = sort { $a->{'interest'} <= $b->{'interest'} } @debts;
redistribute($extra);

print "No.\t";
foreach my $i (@sdebts) {
   print "| " . $i->{'name'} . "\t";
}
print "\n";

my $n = 1;
while( !$sdebts[-1]->{'paid'} ) {
   show_payments($n++);
}

sub show_payments {
   
   my $n = shift;
   foreach my $i (@sdebts) {
      my $newbal = $i->{'balance'} * (1 + ($i->{'interest'} / 12));
      if( $newbal <= $i->{'payment'} && $i->{'payment'} != 0 ) {
         my $tmp = $i->{'payment'} - $newbal;
         $i->{'payment'} = $newbal;
         $i->{'paid'} = 1;
         redistribute($tmp);
      }
      $i->{'balance'} = $newbal - $i->{'payment'};
   }


   print $n . "\t";
   foreach $i (@sdebts) {
      print "| \$" . sprintf("%6s", sprintf("%.2f", $i->{'payment'})) . "\t";
   }
   print "\n";

}

sub redistribute {

   my $amt = shift;
   foreach my $i (@sdebts) {
      if( !$i->{'paid'} && $i->{'payment'} != $i->{'balance'}) {
         $i->{'payment'} += $amt;
         return;
      }
   }

}
