package ZahlenDatentypen is
   pragma Pure;

   subtype EigenerInteger is Integer range -1_000_000_000 .. 1_000_000_000;
   subtype EigenesNatural is EigenerInteger range 0 .. EigenerInteger'Last;
   subtype EigenesPositive is EigenesNatural range 1 .. EigenesNatural'Last;
   subtype EigenesNegative is EigenerInteger range EigenerInteger'First .. -1;

   type NotAus is range 1 .. 100;
   -- subtype NotAusKlein is NotAus range 1 .. 5;

end ZahlenDatentypen;
