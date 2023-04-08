package SpeziesDatentypen is
   pragma Pure;
   
   type Spezies_Enum is (
                         Leer_Spezies_Enum,
                        
                         Menschen_Enum, Kasrodiah_Enum, Lasupin_Enum, Lamustra_Enum, Manuky_Enum, Suroka_Enum, Pryolon_Enum, Moru_Phisihl_Enum, Larinos_Lotaris_Enum, Carupex_Enum,
                         Alary_Enum, Natries_Zermanis_Enum, Tridatus_Enum, Senelari_Enum, Aspari_2_Enum, Ekropa_Enum,
                        
                         Tesorahn_Enum, Talbidahr_Enum
                        );
   pragma Ordered (Spezies_Enum);
   
   subtype Spezies_Verwendet_Enum is Spezies_Enum range Spezies_Enum'Succ (Spezies_Enum'First) .. Spezies_Enum'Last;
   subtype Spezies_Überirdisch_Enum is Spezies_Verwendet_Enum range Spezies_Verwendet_Enum'First.. Ekropa_Enum;
   subtype Spezies_Unterirdisch_Enum is Spezies_Verwendet_Enum range Tesorahn_Enum .. Talbidahr_Enum;
   subtype Spezies_Wasser_Enum is Spezies_Unterirdisch_Enum range Tesorahn_Enum .. Tesorahn_Enum;
   subtype Spezies_Erde_Enum is Spezies_Unterirdisch_Enum range Talbidahr_Enum .. Talbidahr_Enum;
   
   subtype Speziesnummern is Natural range Spezies_Enum'Pos (Spezies_Enum'First) .. Spezies_Enum'Pos (Spezies_Enum'Last);
   subtype SpeziesnummernVorhanden is Speziesnummern range Spezies_Enum'Pos (Spezies_Verwendet_Enum'First) .. Speziesnummern'Last;

   
   
   -- Das hier mal woanders hinschieben? Hat ja nicht wirklich was mit den Spezies zu tun. äöü
   type Spieler_Enum is (
                         Leer_Spieler_Enum,
                         
                         Mensch_Spieler_Enum,
                         KI_Spieler_Enum
                        );
   pragma Ordered (Spieler_Enum);
   
   subtype Spieler_Belegt_Enum is Spieler_Enum range Spieler_Enum'Succ (Spieler_Enum'First) .. Spieler_Enum'Last;
   
   
   
   type Speziesverhalten is range 1 .. 1_000;
   
   -- Soll ich das so überhaupt einbauen? Oder mir was besseres überlegen? äöü
   type Staatsform_Enum is (
                            Anarchie_Enum,
                            Demokratie_Enum
                           );

   type StaatsformenArray is array (1 .. 5) of Staatsform_Enum;

end SpeziesDatentypen;
