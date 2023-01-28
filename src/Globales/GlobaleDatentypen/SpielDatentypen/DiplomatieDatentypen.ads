with SpeziesDatentypen;
with KartenRecords;
with KartengrundDatentypen;

package DiplomatieDatentypen is
   pragma Pure;

   type Status_Untereinander_Enum is (
                                      Unbekannt_Enum,
                                      
                                      Neutral_Enum, Nichtangriffspakt_Enum, Krieg_Enum
                                     );
   
   subtype Status_Untereinander_Bekannt_Enum is Status_Untereinander_Enum range Status_Untereinander_Enum'Succ (Status_Untereinander_Enum'First) .. Status_Untereinander_Enum'Last;
   
   type Meinung is range -100 .. 100;
   subtype MeinungPositive is Meinung range 1 .. 100;
   
   -- Das hier später noch in eine eigene Datei auslagern? äöü
   -- Vielleicht generell alle Arrays aus den Datentypen und rein in die Records? äöü
   -- Beziehungsweise alle Konstanten Arrays in die Konstanten schieben. äöü
   type MeinungsänderungFeldeffekteArray is array (KartenRecords.EffekteArray'Range, SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of Meinung;
   MeinungsänderungFeldeffekte : constant MeinungsänderungFeldeffekteArray := (
                                                                                 KartengrundDatentypen.Strahlung_Enum =>
                                                                                   (
                                                                                    SpeziesDatentypen.Menschen_Enum         => -1,
                                                                                    SpeziesDatentypen.Kasrodiah_Enum        => -1,
                                                                                    SpeziesDatentypen.Lasupin_Enum          => -1,
                                                                                    SpeziesDatentypen.Lamustra_Enum         => -1,
                                                                                    SpeziesDatentypen.Manuky_Enum           => -1,
                                                                                    SpeziesDatentypen.Suroka_Enum           => -1,
                                                                                    SpeziesDatentypen.Pryolon_Enum          => -1,
                                                                                    SpeziesDatentypen.Moru_Phisihl_Enum     => -1,
                                                                                    SpeziesDatentypen.Larinos_Lotaris_Enum  => -1,
                                                                                    SpeziesDatentypen.Carupex_Enum          => -1,
                                                                                    SpeziesDatentypen.Alary_Enum            => -1,
                                                                                    SpeziesDatentypen.Natries_Zermanis_Enum => -1,
                                                                                    SpeziesDatentypen.Tridatus_Enum         => -1,
                                                                                    SpeziesDatentypen.Senelari_Enum         => -1,
                                                                                    SpeziesDatentypen.Aspari_2_Enum         => -1,
                                                                                    SpeziesDatentypen.Ekropa_Enum           => -1,
                                                                                    SpeziesDatentypen.Tesorahn_Enum         => -1,
                                                                                    SpeziesDatentypen.Talbidahr_Enum        => -1
                                                                                   ),
                                                                                 
                                                                                 KartengrundDatentypen.Biologisch_Enum =>
                                                                                   (
                                                                                    SpeziesDatentypen.Menschen_Enum         => -1,
                                                                                    SpeziesDatentypen.Kasrodiah_Enum        => -1,
                                                                                    SpeziesDatentypen.Lasupin_Enum          => -1,
                                                                                    SpeziesDatentypen.Lamustra_Enum         => -1,
                                                                                    SpeziesDatentypen.Manuky_Enum           => -1,
                                                                                    SpeziesDatentypen.Suroka_Enum           => -1,
                                                                                    SpeziesDatentypen.Pryolon_Enum          => -1,
                                                                                    SpeziesDatentypen.Moru_Phisihl_Enum     => -1,
                                                                                    SpeziesDatentypen.Larinos_Lotaris_Enum  => -1,
                                                                                    SpeziesDatentypen.Carupex_Enum          => -1,
                                                                                    SpeziesDatentypen.Alary_Enum            => -1,
                                                                                    SpeziesDatentypen.Natries_Zermanis_Enum => -1,
                                                                                    SpeziesDatentypen.Tridatus_Enum         => -1,
                                                                                    SpeziesDatentypen.Senelari_Enum         => -1,
                                                                                    SpeziesDatentypen.Aspari_2_Enum         => -1,
                                                                                    SpeziesDatentypen.Ekropa_Enum           => -1,
                                                                                    SpeziesDatentypen.Tesorahn_Enum         => -1,
                                                                                    SpeziesDatentypen.Talbidahr_Enum        => -1
                                                                                   ),
                                                                                 
                                                                                 KartengrundDatentypen.Chemisch_Enum =>
                                                                                   (
                                                                                    SpeziesDatentypen.Menschen_Enum         => -1,
                                                                                    SpeziesDatentypen.Kasrodiah_Enum        => -1,
                                                                                    SpeziesDatentypen.Lasupin_Enum          => -1,
                                                                                    SpeziesDatentypen.Lamustra_Enum         => -1,
                                                                                    SpeziesDatentypen.Manuky_Enum           => -1,
                                                                                    SpeziesDatentypen.Suroka_Enum           => -1,
                                                                                    SpeziesDatentypen.Pryolon_Enum          => -1,
                                                                                    SpeziesDatentypen.Moru_Phisihl_Enum     => -1,
                                                                                    SpeziesDatentypen.Larinos_Lotaris_Enum  => -1,
                                                                                    SpeziesDatentypen.Carupex_Enum          => -1,
                                                                                    SpeziesDatentypen.Alary_Enum            => -1,
                                                                                    SpeziesDatentypen.Natries_Zermanis_Enum => -1,
                                                                                    SpeziesDatentypen.Tridatus_Enum         => -1,
                                                                                    SpeziesDatentypen.Senelari_Enum         => -1,
                                                                                    SpeziesDatentypen.Aspari_2_Enum         => -1,
                                                                                    SpeziesDatentypen.Ekropa_Enum           => -1,
                                                                                    SpeziesDatentypen.Tesorahn_Enum         => -1,
                                                                                    SpeziesDatentypen.Talbidahr_Enum        => -1
                                                                                   ),
                                                                                 
                                                                                 KartengrundDatentypen.Verschmutzt_Enum =>
                                                                                   (
                                                                                    SpeziesDatentypen.Menschen_Enum         => -1,
                                                                                    SpeziesDatentypen.Kasrodiah_Enum        => -1,
                                                                                    SpeziesDatentypen.Lasupin_Enum          => -1,
                                                                                    SpeziesDatentypen.Lamustra_Enum         => -1,
                                                                                    SpeziesDatentypen.Manuky_Enum           => -1,
                                                                                    SpeziesDatentypen.Suroka_Enum           => -1,
                                                                                    SpeziesDatentypen.Pryolon_Enum          => -1,
                                                                                    SpeziesDatentypen.Moru_Phisihl_Enum     => -1,
                                                                                    SpeziesDatentypen.Larinos_Lotaris_Enum  => -1,
                                                                                    SpeziesDatentypen.Carupex_Enum          => -1,
                                                                                    SpeziesDatentypen.Alary_Enum            => -1,
                                                                                    SpeziesDatentypen.Natries_Zermanis_Enum => -1,
                                                                                    SpeziesDatentypen.Tridatus_Enum         => -1,
                                                                                    SpeziesDatentypen.Senelari_Enum         => -1,
                                                                                    SpeziesDatentypen.Aspari_2_Enum         => -1,
                                                                                    SpeziesDatentypen.Ekropa_Enum           => -1,
                                                                                    SpeziesDatentypen.Tesorahn_Enum         => -1,
                                                                                    SpeziesDatentypen.Talbidahr_Enum        => -1
                                                                                   ),
                                                                                   
                                                                                 KartengrundDatentypen.Vernichtet_Enum =>
                                                                                   (others => Meinung'First)
                                                                                );

end DiplomatieDatentypen;
