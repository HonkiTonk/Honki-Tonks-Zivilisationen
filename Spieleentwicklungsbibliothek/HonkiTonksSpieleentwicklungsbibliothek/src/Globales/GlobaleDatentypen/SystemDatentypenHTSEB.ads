package SystemDatentypenHTSEB is
   pragma Pure;

   type Spieler_Enum is (
                         Leer_Spieler_Enum,
                         
                         Mensch_Spieler_Enum,
                         KI_Spieler_Enum
                        );
   pragma Ordered (Spieler_Enum);
   
   subtype Spieler_Belegt_Enum is Spieler_Enum range Spieler_Enum'Succ (Spieler_Enum'First) .. Spieler_Enum'Last;
   
   
      
   type NullBisHundert is range 0 .. 100;
   subtype EinsBisHundert is NullBisHundert range 1 .. NullBisHundert'Last;
   
   
   
   subtype EigenerInteger is Integer range -1_000_000_000 .. 1_000_000_000;
   subtype EigenesNatural is EigenerInteger range 0 .. EigenerInteger'Last;
   subtype EigenesPositive is EigenesNatural range 1 .. EigenesNatural'Last;
   subtype EigenesNegative is EigenerInteger range EigenerInteger'First .. -1;
   
   
   
   type EinByte is mod 2**8;
   type ZweiByte is mod 2**16;
   type VierByte is mod 2**32;

end SystemDatentypenHTSEB;
