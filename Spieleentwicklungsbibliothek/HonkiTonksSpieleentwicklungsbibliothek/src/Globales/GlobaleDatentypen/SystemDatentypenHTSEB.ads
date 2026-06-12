package SystemDatentypenHTSEB is
   pragma Pure;

   type Spieler_Enum is (
                         Leer_Spieler_Enum,
                         
                         Mensch_Spieler_Enum,
                         KI_Spieler_Enum
                        );
   pragma Ordered (Spieler_Enum);
   
   subtype Spieler_Belegt_Enum is Spieler_Enum range Spieler_Enum'Succ (Spieler_Enum'First) .. Spieler_Enum'Last;
   
   
   
   type Anfang_Ende_Enum is (
                             Anfang_Enum, Ende_Enum
                            );
   
   
   
   type Erweiterter_Boolean_Enum is (
                                     True_Enum, Neutral_Enum, False_Enum
                                    );
   
   
   
   type Spielstand_Enum is (
                            Manueller_Spielstand_Enum,
                            Automatischer_Spielstand_Enum
                           );
   
   
      
   type NullBisHundert is range 0 .. 100;
   subtype EinsBisHundert is NullBisHundert range 1 .. NullBisHundert'Last;
   
   subtype LadezeitBasis is Float range 0.00 .. 100.00;
   subtype LadezeitVorhanden is LadezeitBasis range 1.00 .. LadezeitBasis'Last;
   
   
   
   subtype EigenerInteger is Integer range -1_000_000_000 .. 1_000_000_000;
   subtype EigenesNatural is EigenerInteger range 0 .. EigenerInteger'Last;
   subtype EigenesPositive is EigenesNatural range 1 .. EigenesNatural'Last;
   subtype EigenesNegative is EigenerInteger range EigenerInteger'First .. -1;
   
   
   
   type EinByte is mod 2**8; -- 0 .. 255
   type ZweiByte is mod 2**16; -- 0 .. 65_535
   type VierByte is mod 2**32; -- 0 .. 4_294_967_295
   
   type EinByteVorzeichen is range -2**7 .. (2**7) - 1; -- -128 .. 127
   type ZweiByteVorzeichen is range -2**15 .. (2**15) - 1; -- -32_768 .. 32_767
   type VierByteVorzeichen is range -2**31 .. (2**31) - 1; -- -2_147_483_648 .. 2_147_483_647
   
   subtype VierundsechzigElemente is EigenesPositive range EigenesPositive'First .. 64;
   subtype ZweiundreißigElemente is VierundsechzigElemente range VierundsechzigElemente'First .. VierundsechzigElemente'Last / 2;
   subtype SechzehnElemente is ZweiundreißigElemente range ZweiundreißigElemente'First .. ZweiundreißigElemente'Last / 2;
   subtype AchtElemente is SechzehnElemente range SechzehnElemente'First .. SechzehnElemente'Last / 2;
   
   
   
   type Durchläufe10000 is range 1 .. 10_000;
   subtype Durchläufe1000 is Durchläufe10000 range Durchläufe10000'First .. Durchläufe10000'Last / 10;
   subtype Durchläufe100 is Durchläufe1000 range Durchläufe1000'First .. Durchläufe1000'Last / 10;
   subtype Durchläufe10 is Durchläufe100 range Durchläufe100'First .. Durchläufe100'Last / 10;

end SystemDatentypenHTSEB;
