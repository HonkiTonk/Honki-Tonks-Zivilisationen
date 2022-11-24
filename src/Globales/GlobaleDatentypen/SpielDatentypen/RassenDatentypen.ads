package RassenDatentypen is
   pragma Pure;
   
   type Rassen_Enum is (
                        Keine_Rasse_Enum,
                        
                        Menschen_Enum, Kasrodiah_Enum, Lasupin_Enum, Lamustra_Enum, Manuky_Enum, Suroka_Enum, Pryolon_Enum, Moru_Phisihl_Enum, Larinos_Lotaris_Enum, Carupex_Enum,
                        Alary_Enum, Natries_Zermanis_Enum, Tridatus_Enum, Senelari_Enum, Aspari_2_Enum, Ekropa_Enum,
                        
                        Tesorahn_Enum, Talbidahr_Enum
                       );
   pragma Ordered (Rassen_Enum);
   
   subtype Rassen_Verwendet_Enum is Rassen_Enum range Rassen_Enum'Succ (Rassen_Enum'First) .. Rassen_Enum'Last;
   subtype Rassen_Überirdisch_Enum is Rassen_Verwendet_Enum range Rassen_Verwendet_Enum'First.. Ekropa_Enum;
   subtype Rassen_Unterirdisch_Enum is Rassen_Verwendet_Enum range Tesorahn_Enum .. Talbidahr_Enum;
   subtype Rassen_Wasser_Enum is Rassen_Unterirdisch_Enum range Tesorahn_Enum .. Tesorahn_Enum;
   subtype Rassen_Erde_Enum is Rassen_Unterirdisch_Enum range Talbidahr_Enum .. Talbidahr_Enum;
   
   subtype Rassennummern is Natural range Rassen_Enum'Pos (Rassen_Enum'First) .. Rassen_Enum'Pos (Rassen_Enum'Last);
   subtype RassennummernVorhanden is Rassennummern range Rassen_Enum'Pos (Rassen_Verwendet_Enum'First) .. Rassennummern'Last;

   -- Das hier mal woanders hinschieben? Hat ja nicht wirklich was mit den Rassen zu tun. äöü
   type Spieler_Enum is (
                         Leer_Spieler_Enum,
                         
                         Mensch_Spieler_Enum,
                         KI_Spieler_Enum
                        );
   pragma Ordered (Spieler_Enum);
   
   subtype Spieler_Belegt_Enum is Spieler_Enum range Spieler_Enum'Succ (Spieler_Enum'First) .. Spieler_Enum'Last;
   
   -- Soll ich das so überhaupt einbauen? Oder mir was besseres überlegen? äöü
   type Staatsform_Enum is (
                            Anarchie_Enum,
                            Demokratie_Enum
                           );

   type StaatsformenArray is array (1 .. 5) of Staatsform_Enum;

end RassenDatentypen;
