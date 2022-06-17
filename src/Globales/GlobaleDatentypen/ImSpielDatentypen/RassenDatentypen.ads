pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package RassenDatentypen is
   
   type Rassen_Enum is (
                        Keine_Rasse_Enum,
                        
                        Menschen_Enum, Kasrodiah_Enum, Lasupin_Enum, Lamustra_Enum, Manuky_Enum, Suroka_Enum, Pryolon_Enum, Moru_Phisihl_Enum, Larinos_Lotaris_Enum, Carupex_Enum,
                        Alary_Enum, Natries_Zermanis_Enum, Tridatus_Enum, Senelari_Enum, Aspari_2_Enum, Ekropa_Enum,
                        
                        Tesorahn_Enum, Talbidahr_Enum
                       );
   pragma Ordered (Rassen_Enum);
   
   subtype Rassen_Verwendet_Enum is Rassen_Enum range Menschen_Enum .. Talbidahr_Enum;
   subtype Rassen_Überirdisch_Enum is Rassen_Verwendet_Enum range  Menschen_Enum.. Ekropa_Enum;
   subtype Rassen_Unterirdisch_ENum is Rassen_Verwendet_Enum range Tesorahn_Enum .. Talbidahr_Enum;

   type Spieler_Enum is (
                         Leer_Spieler_Enum,
                         
                         Spieler_Mensch_Enum,
                         Spieler_KI_Enum
                        );
   pragma Ordered (Spieler_Enum);
   
   subtype Spieler_Belegt_Enum is Spieler_Enum range Spieler_Mensch_Enum .. Spieler_KI_Enum;
   
   type RassenImSpielArray is array (Rassen_Verwendet_Enum'Range) of Spieler_Enum;

end RassenDatentypen;
