pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with KartengrundDatentypen;
with KartenVerbesserungDatentypen;
with WichtigesKonstanten;
with RassenDatentypen;

with DatenbankRecords;
with KartengrundDatenbank;
with VerbesserungenDatenbank;
with KartenflussDatenbank;
with KartenressourcenDatenbank;

package EingeleseneGrafikenTerminal is
   
   -- Alles hier mal besser aufteilen und übersichtlicher gestalten. äöü
   
   type CursorGrafikArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of Wide_Wide_Character;
   CursorGrafik : CursorGrafikArray := (others => WichtigesKonstanten.LeerCursorGrafik);

   type EinheitenGrafikArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, DatenbankRecords.EinheitenlisteArray'Range) of Wide_Wide_Character;
   EinheitenGrafik : EinheitenGrafikArray := (
                                              others =>
                                                (
                                                 -- Siedler
                                                 1 => 'S',
                                               
                                                 -- Steinzeitkämpfer
                                                 2 => 'N',
                                               
                                                 -- Bogenschütze
                                                 3 => 'F',
      
                                                 -- Erstes Schiff
                                                 4 => 'W',
                                               
                                                 -- Bronzekämpfer
                                                 5 => 'N',
                                               
                                                 -- Eisenkämpfer
                                                 6 => 'N',
                                               
                                                 -- Streitwagen
                                                 7 => 'N',
                                               
                                                 -- Katapult
                                                 8 => 'F',
                                               
                                                 -- Balliste
                                                 9 => 'F',
                                               
                                                 -- Segelschiff
                                                 10 => 'W',
                                               
                                                 -- Großes Segelschiff
                                                 11 => 'W',
                                               
                                                 -- Gewehrkämpfer
                                                 12 => 'N',
                                               
                                                 -- Kanone
                                                 13 => 'F',
                                               
                                                 -- Dampfschiff
                                                 14 => 'W',
                                               
                                                 -- Motorschiff
                                                 15 => 'W',
                                               
                                                 -- U-Boot
                                                 16 => 'W',
                                               
                                                 -- Gepanzerter Wagen
                                                 17 => 'N',
                                               
                                                 -- Panzer
                                                 18 => 'N',
                                               
                                                 -- Jäger
                                                 19 => 'L',
                                               
                                                 -- Bomber
                                                 20 => 'L',
                                               
                                                 -- Rakete
                                                 21 => 'O',
                                               
                                                 -- Düsenjäger
                                                 22 => 'L',
                                               
                                                 -- Düsenbomber
                                                 23 => 'L',
                                               
                                                 -- Atombombe
                                                 24 => 'S',
                                               
                                                 -- Drohne
                                                 25 => 'L',
                                               
                                                 -- Gensoldat
                                                 26 => 'N',
                                               
                                                 -- Wassersiedler
                                                 27 => 'S',
                                               
                                                 -- Cyborg
                                                 28 => 'N',
                                               
                                                 -- Unterwasser/Unterirdischer Siedler
                                                 29 => 'S',
                                               
                                                 -- PZB20
                                                 30 => 'S',
                                               
                                                 -- PZB40
                                                 31 => 'S',
                                               
                                                 -- PZB100
                                                 32 => 'S',
                                               
                                                 -- Gaußkämpfer
                                                 33 => 'N',
                                               
                                                 -- Magnetkämpfer
                                                 34 => 'N',
                                               
                                                 -- Schwebepanzer
                                                 35 => 'N',
                                               
                                                 -- Planetenkernsiedler
                                                 36 => 'S',
                                               
                                                 -- Himmel/Orbitalsiedler
                                                 37 => 'S',
                                               
                                                 -- Atmosphärenjäger
                                                 38 => 'L',
                                               
                                                 -- Atmosphärenbomber
                                                 39 => 'L',
                                               
                                                 -- Artillerie
                                                 40 => 'F',
                                               
                                                 -- Stellare Artillerie
                                                 41 => 'F',
                                               
                                                 -- Gräberschiff
                                                 42 => 'W',
                                               
                                                 -- Kerngräber
                                                 43 => 'W',
                                               
                                                 -- Moderne Infanterie
                                                 44 => 'N',
                                               
                                                 -- Alleskönner
                                                 45 => 'A',
                                                               
                                                 others => EinheitenKonstanten.LeerEinheitenGrafik
                                                )
                                             );
   
   
   
   type GebäudeGrafikArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, DatenbankRecords.GebäudelisteArray'Range) of Wide_Wide_Character;
   GebäudeGrafik : GebäudeGrafikArray := (
                                            others =>
                                              (
                                               -- Häuser
                                               1 => 'A',
                                             
                                               -- Nahrungslager
                                               2 => 'B',
                                             
                                               -- Holzpalisade
                                               3 => 'C',
                                             
                                               -- Schmiede
                                               4 => 'D',
      
                                               -- Bibliothek
                                               5 => 'E',
                                             
                                               -- Steinmauer
                                               6 => 'F',
                                             
                                               -- Bücherei
                                               7 => 'G',
                                             
                                               -- Bewässerungssystem
                                               8 => 'H',
                                             
                                               -- Kaserne
                                               9 => 'I',
                                             
                                               -- Wassermühle
                                               10 => 'J',
                                             
                                               -- Windmühle
                                               11 => 'K',
                                             
                                               -- Seehafen
                                               12 => 'L',
                                             
                                               -- Hochofen
                                               13 => 'M',
                                             
                                               -- Universität
                                               14 => 'N',
                                             
                                               -- Burg
                                               15 => 'O',
                                             
                                               -- Schwere Burg
                                               16 => 'P',
                                             
                                               -- Festungen
                                               17 => 'Q',
                                             
                                               -- Kohlekraftwerk
                                               18 => 'R',
                                             
                                               -- Fabrik
                                               19 => 'S',
                                             
                                               -- Krankenhaus
                                               20 => 'T',
                                             
                                               -- Flughafen
                                               21 => 'U',
                                             
                                               -- Atomkraftwerk
                                               22 => 'V',
                                             
                                               -- Regenerative Kraftwerke (aufteilen oder zusammenlassen?)
                                               23 => 'W',
                                             
                                               -- Genklinik
                                               24 => 'X',
                                             
                                               -- Fusionskraftwerk
                                               25 => 'Y',
                                             
                                               -- NAMR Kraftwerk
                                               26 => 'Z',
                                                              
                                               others => StadtKonstanten.LeerGebäudeGrafik
                                              )
                                           );
   
   
   
   type KartenfelderGrafikArray is array (KartengrundDatenbank.KartengrundlisteArray'Range) of Wide_Wide_Character;
   KartenfelderGrafik : KartenfelderGrafikArray := (
                                                    -- Normal
                                                    KartengrundDatentypen.Eis_Enum       => KartenKonstanten.LeerKartenGrafik,
                                                    KartengrundDatentypen.Wasser_Enum    => KartenKonstanten.LeerKartenGrafik,
                                                    KartengrundDatentypen.Flachland_Enum => KartenKonstanten.LeerKartenGrafik,
                                                    KartengrundDatentypen.Tundra_Enum    => KartenKonstanten.LeerKartenGrafik,
                                                    KartengrundDatentypen.Wüste_Enum     => KartenKonstanten.LeerKartenGrafik,
                                      
                                                    -- Ersetzt Ebene oder ist Bestandteil von Wüste, Tundra, Wald und Dschungel
                                                    KartengrundDatentypen.Hügel_Enum          => KartenKonstanten.LeerKartenGrafik,
                                                    KartengrundDatentypen.Gebirge_Enum        => KartenKonstanten.LeerKartenGrafik,
                                                    KartengrundDatentypen.Wald_Enum           => KartenKonstanten.LeerKartenGrafik,
                                                    KartengrundDatentypen.Dschungel_Enum      => KartenKonstanten.LeerKartenGrafik,
                                                    KartengrundDatentypen.Küstengewässer_Enum => KartenKonstanten.LeerKartenGrafik,
                                                    KartengrundDatentypen.Sumpf_Enum          => KartenKonstanten.LeerKartenGrafik,
                                                    -- Normal
      
                                                    
      
                                                    -- Unterwasser/Unterirdisch
                                                    KartengrundDatentypen.Untereis_Enum    => KartenKonstanten.LeerKartenGrafik,
                                                    KartengrundDatentypen.Erde_Enum        => KartenKonstanten.LeerKartenGrafik,
                                                    KartengrundDatentypen.Erdgestein_Enum  => KartenKonstanten.LeerKartenGrafik,
                                                    KartengrundDatentypen.Sand_Enum        => KartenKonstanten.LeerKartenGrafik,
                                                    KartengrundDatentypen.Meeresgrund_Enum => KartenKonstanten.LeerKartenGrafik,
                                                    KartengrundDatentypen.Küstengrund_Enum => KartenKonstanten.LeerKartenGrafik,
                                                    KartengrundDatentypen.Korallen_Enum    => KartenKonstanten.LeerKartenGrafik,
                                                    KartengrundDatentypen.Unterwald_Enum   => KartenKonstanten.LeerKartenGrafik,
                                                    KartengrundDatentypen.Gestein_Enum     => KartenKonstanten.LeerKartenGrafik,
                                                    -- Unterwasser/Unterirdisch
      
      
                   
                                                    -- Planeteninneres
                                                    KartengrundDatentypen.Lava_Enum           => KartenKonstanten.LeerKartenGrafik,
                                                    KartengrundDatentypen.Planetenkern_Enum   => KartenKonstanten.LeerKartenGrafik,
                                                    KartengrundDatentypen.Magnesiowüstit_Enum => KartenKonstanten.LeerKartenGrafik,
                                                    KartengrundDatentypen.Perowskit_Enum      => KartenKonstanten.LeerKartenGrafik,
                                                    KartengrundDatentypen.Majorit_Enum        => KartenKonstanten.LeerKartenGrafik,
                                                    KartengrundDatentypen.Ringwoodit_Enum     => KartenKonstanten.LeerKartenGrafik,
                                                    -- Planeteninneres
      
      
      
                                                    -- Luft/Weltraum
                                                    KartengrundDatentypen.Wolken_Enum   => KartenKonstanten.LeerKartenGrafik,
                                                    KartengrundDatentypen.Weltraum_Enum => KartenKonstanten.LeerKartenGrafik,
                                                    -- Luft/Weltraum
                                                    
                                                    
                                                    
                                                    -- Sonstiges
                                                    KartengrundDatentypen.Vernichtet_Enum => KartenKonstanten.LeerKartenGrafik
                                                    -- Sonstiges
                                                   );
   
   
   
   type KartenflussGrafikArray is array (KartenflussDatenbank.KartenflusslisteArray'Range) of Wide_Wide_Character;
   KartenflussGrafik : KartenflussGrafikArray := (
                                                  -- Normal
                                                  KartengrundDatentypen.Flusskreuzung_Vier_Enum        => '╋',
                                                  KartengrundDatentypen.Fluss_Waagrecht_Enum           => '━',
                                                  KartengrundDatentypen.Fluss_Senkrecht_Enum           => '┃',
                                                  KartengrundDatentypen.Flusskurve_Unten_Rechts_Enum   => '┏',
                                                  KartengrundDatentypen.Flusskurve_Unten_Links_Enum    => '┓',
                                                  KartengrundDatentypen.Flusskurve_Oben_Rechts_Enum    => '┗',
                                                  KartengrundDatentypen.Flusskurve_Oben_Links_Enum     => '┛',
                                                  KartengrundDatentypen.Flusskreuzung_Drei_Oben_Enum   => '┻',
                                                  KartengrundDatentypen.Flusskreuzung_Drei_Unten_Enum  => '┳',
                                                  KartengrundDatentypen.Flusskreuzung_Drei_Rechts_Enum => '┣',
                                                  KartengrundDatentypen.Flusskreuzung_Drei_Links_Enum  => '┫',
                                                  KartengrundDatentypen.Flussendstück_Links_Enum       => '╺',
                                                  KartengrundDatentypen.Flussendstück_Rechts_Enum      => '╸',
                                                  KartengrundDatentypen.Flussendstück_Unten_Enum       => '╹',
                                                  KartengrundDatentypen.Flussendstück_Oben_Enum        => '╻',
                                                  KartengrundDatentypen.See_Enum                       => '▪',
                                                  -- Normal
      
      
      
                                                  -- Unterirdisch
                                                  KartengrundDatentypen.Unterirdische_Flusskreuzung_Vier_Enum        => '╋',
                                                  KartengrundDatentypen.Unterirdischer_Fluss_Waagrecht_Enum          => '━',
                                                  KartengrundDatentypen.Unterirdischer_Fluss_Senkrecht_Enum          => '┃',
                                                  KartengrundDatentypen.Unterirdische_Flusskurve_Unten_Rechts_Enum   => '┏',
                                                  KartengrundDatentypen.Unterirdische_Flusskurve_Unten_Links_Enum    => '┓',
                                                  KartengrundDatentypen.Unterirdische_Flusskurve_Oben_Rechts_Enum    => '┗',
                                                  KartengrundDatentypen.Unterirdische_Flusskurve_Oben_Links_Enum     => '┛',
                                                  KartengrundDatentypen.Unterirdische_Flusskreuzung_Drei_Oben_Enum   => '┻',
                                                  KartengrundDatentypen.Unterirdische_Flusskreuzung_Drei_Unten_Enum  => '┳',
                                                  KartengrundDatentypen.Unterirdische_Flusskreuzung_Drei_Rechts_Enum => '┣',
                                                  KartengrundDatentypen.Unterirdische_Flusskreuzung_Drei_Links_Enum  => '┫',
                                                  KartengrundDatentypen.Unterirdisches_Flussendstück_Links_Enum      => '╺',
                                                  KartengrundDatentypen.Unterirdisches_Flussendstück_Rechts_Enum     => '╸',
                                                  KartengrundDatentypen.Unterirdisches_Flussendstück_Unten_Enum      => '╹',
                                                  KartengrundDatentypen.Unterirdisches_Flussendstück_Oben_Enum       => '╻',
                                                  KartengrundDatentypen.Unterirdischer_See_Enum                      => '▪',
                                                  -- Unterirdisch
      
      
      
                                                  -- Lava
                                                  KartengrundDatentypen.Lavaflusskreuzung_Vier_Enum        => '╋',
                                                  KartengrundDatentypen.Lavafluss_Waagrecht_Enum           => '━',
                                                  KartengrundDatentypen.Lavafluss_Senkrecht_Enum           => '┃',
                                                  KartengrundDatentypen.Lavaflusskurve_Unten_Rechts_Enum   => '┏',
                                                  KartengrundDatentypen.Lavaflusskurve_Unten_Links_Enum    => '┓',
                                                  KartengrundDatentypen.Lavaflusskurve_Oben_Rechts_Enum    => '┗',
                                                  KartengrundDatentypen.Lavaflusskurve_Oben_Links_Enum     => '┛',
                                                  KartengrundDatentypen.Lavaflusskreuzung_Drei_Oben_Enum   => '┻',
                                                  KartengrundDatentypen.Lavaflusskreuzung_Drei_Unten_Enum  => '┳',
                                                  KartengrundDatentypen.Lavaflusskreuzung_Drei_Rechts_Enum => '┣',
                                                  KartengrundDatentypen.Lavaflusskreuzung_Drei_Links_Enum  => '┫',
                                                  KartengrundDatentypen.Lavaflussendstück_Links_Enum       => '╺',
                                                  KartengrundDatentypen.Lavaflussendstück_Rechts_Enum      => '╸',
                                                  KartengrundDatentypen.Lavaflussendstück_Unten_Enum       => '╹',
                                                  KartengrundDatentypen.Lavaflussendstück_Oben_Enum        => '╻',
                                                  KartengrundDatentypen.Lavasee_Enum                       => '▪'
                                                  -- Lava
                                                 );
   
   

   type KartenressourcenGrafikArray is array (KartenressourcenDatenbank.KartenressourcenListeArray'Range) of Wide_Wide_Character;
   KartenressourcenGrafik : KartenressourcenGrafikArray := (
                                                            KartengrundDatentypen.Kohle_Enum              => '♦',
                                                            KartengrundDatentypen.Eisen_Enum              => '♦',
                                                            KartengrundDatentypen.Öl_Enum                 => '♦',
                                                            KartengrundDatentypen.Fisch_Enum              => '≈',
                                                            KartengrundDatentypen.Wal_Enum                => '≈',
                                                            KartengrundDatentypen.Hochwertiger_Boden_Enum => '♦',
                                                            KartengrundDatentypen.Gold_Enum               => '♦'
                                                           );
   
   
   
   type VerbesserungenGrafikArray is array (VerbesserungenDatenbank.VerbesserungenlisteArray'Range) of Wide_Wide_Character;
   VerbesserungenGrafik : VerbesserungenGrafikArray := (
                                                        -- Städte
                                                        KartenVerbesserungDatentypen.Hauptstadt_Enum => '♣',
                                                        KartenVerbesserungDatentypen.Stadt_Enum      => '♠',
                                                        -- Veraltet, rassenabhängiges Symbol einbauen? äöü
                                                        -- KartenVerbesserungDatentypen.Fremde_Hauptstadt_Enum => '⌂',
                                                        -- KartenVerbesserungDatentypen.Fremde_Stadt_Enum      => '¤',
                                                        -- Städte
      
      
                                                  
                                                        -- Gebilde
                                                        KartenVerbesserungDatentypen.Farm_Enum    => 'F',
                                                        KartenVerbesserungDatentypen.Mine_Enum    => 'M',
                                                        KartenVerbesserungDatentypen.Festung_Enum => 'B'
                                                        -- Gebilde
                                                       );
   
   
   
   type WegeGrafikArray is array (VerbesserungenDatenbank.WegelisteArray'Range) of Wide_Wide_Character;
   WegeGrafik : WegeGrafikArray := (
                                    -- Straßen
                                    KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum        => '╬',
                                    KartenVerbesserungDatentypen.Straße_Waagrecht_Enum            => '═',
                                    KartenVerbesserungDatentypen.Straße_Senkrecht_Enum            => '║',
                                    KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum   => '╔',
                                    KartenVerbesserungDatentypen.Straßenkurve_Unten_Links_Enum    => '╗',
                                    KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum    => '╚',
                                    KartenVerbesserungDatentypen.Straßenkurve_Oben_Links_Enum     => '╝',
                                    KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum   => '╩',
                                    KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum  => '╦',
                                    KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum => '╠',
                                    KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum  => '╣',
                                    KartenVerbesserungDatentypen.Straßenendstück_Links_Enum       => '╞',
                                    KartenVerbesserungDatentypen.Straßenendstück_Rechts_Enum      => '╡',
                                    KartenVerbesserungDatentypen.Straßenendstück_Unten_Enum       => '╨',
                                    KartenVerbesserungDatentypen.Straßenendstück_Oben_Enum        => '╥',
                                    KartenVerbesserungDatentypen.Straße_Einzeln_Enum              => '▫',
                                    -- Straßen
      
      
      
                                    -- Schienen
                                    
                                    -- Schienen
      
      
                                                    
                                    -- Tunnel
                                    
                                    -- Tunnel
                                                    
                                    others => KartenKonstanten.LeerKartenGrafik
                                   );
   
end EingeleseneGrafikenTerminal;
