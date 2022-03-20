pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with KartenGrundDatentypen;
with KartenVerbesserungDatentypen;
with SonstigesKonstanten;

with DatenbankRecords;
with KartenDatenbank;
with VerbesserungenDatenbank;

package EingeleseneGrafikenKonsole is
   
   ---------------------- Alles hier mal besser aufteilen und übersichtlicher gestalten.
   
   type CursorGrafikArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range) of Wide_Wide_Character;
   CursorGrafik : CursorGrafikArray := (others => SonstigesKonstanten.LeerCursorGrafik);

   type EinheitenGrafikArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range, DatenbankRecords.EinheitenListeArray'Range) of Wide_Wide_Character;
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
   
   
   
   type GebäudeGrafikArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range, DatenbankRecords.GebäudeListeArray'Range) of Wide_Wide_Character;
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
   
   
   
   type KartenfelderGrafikArray is array (KartenDatenbank.KartenGrundListeArray'Range) of Wide_Wide_Character;
   KartenfelderGrafik : KartenfelderGrafikArray := (
                                                    -- Normal
                                                    KartenGrundDatentypen.Eis_Enum       => KartenKonstanten.LeerKartenGrafik,
                                                    KartenGrundDatentypen.Wasser_Enum    => KartenKonstanten.LeerKartenGrafik,
                                                    KartenGrundDatentypen.Flachland_Enum => KartenKonstanten.LeerKartenGrafik,
                                                    KartenGrundDatentypen.Tundra_Enum    => KartenKonstanten.LeerKartenGrafik,
                                                    KartenGrundDatentypen.Wüste_Enum     => KartenKonstanten.LeerKartenGrafik,
                                      
                                                    -- Ersetzt Ebene oder ist Bestandteil von Wüste, Tundra, Wald und Dschungel
                                                    KartenGrundDatentypen.Hügel_Enum          => KartenKonstanten.LeerKartenGrafik,
                                                    KartenGrundDatentypen.Gebirge_Enum        => KartenKonstanten.LeerKartenGrafik,
                                                    KartenGrundDatentypen.Wald_Enum           => KartenKonstanten.LeerKartenGrafik,
                                                    KartenGrundDatentypen.Dschungel_Enum      => KartenKonstanten.LeerKartenGrafik,
                                                    KartenGrundDatentypen.Küstengewässer_Enum => KartenKonstanten.LeerKartenGrafik,
                                                    KartenGrundDatentypen.Sumpf_Enum          => KartenKonstanten.LeerKartenGrafik,
                                                    KartenGrundDatentypen.Hügel_Mit_Enum       => KartenKonstanten.LeerKartenGrafik,
                                                    -- Normal
      
      
      
                                                    -- Unterwasser/Unterirdisch
                                                    KartenGrundDatentypen.Unterwasser_Eis_Enum            => KartenKonstanten.LeerKartenGrafik,
                                                    KartenGrundDatentypen.Erde_Enum                      => KartenKonstanten.LeerKartenGrafik,
                                                    KartenGrundDatentypen.Erdgestein_Enum                => KartenKonstanten.LeerKartenGrafik,
                                                    KartenGrundDatentypen.Sand_Enum                      => KartenKonstanten.LeerKartenGrafik,
                                                    KartenGrundDatentypen.Unterwasser_Wasser_Enum         => KartenKonstanten.LeerKartenGrafik,
                                                    KartenGrundDatentypen.Unterwasser_Küstengewässer_Enum => KartenKonstanten.LeerKartenGrafik,
                                                    KartenGrundDatentypen.Korallen_Enum                  => KartenKonstanten.LeerKartenGrafik,
                                                    KartenGrundDatentypen.Unterwasser_Wald_Enum           => KartenKonstanten.LeerKartenGrafik,
                                                    -- Unterwasser/Unterirdisch
      
      
                   
                                                    -- Planeteninneres
                                                    KartenGrundDatentypen.Lava_Enum         => KartenKonstanten.LeerKartenGrafik,
                                                    KartenGrundDatentypen.Gestein_Enum      => KartenKonstanten.LeerKartenGrafik,
                                                    KartenGrundDatentypen.Planetenkern_Enum => KartenKonstanten.LeerKartenGrafik,
                                                    -- Planeteninneres
      
      
      
                                                    -- Luft/Weltraum
                                                    KartenGrundDatentypen.Wolken_Enum  => KartenKonstanten.LeerKartenGrafik,
                                                    KartenGrundDatentypen.Weltraum_Enum => KartenKonstanten.LeerKartenGrafik
                                                    -- Luft/Weltraum
                                                   );
   
   
   
   type KartenflussGrafikArray is array (KartenDatenbank.KartenFlussListeArray'Range) of Wide_Wide_Character;
   KartenflussGrafik : KartenflussGrafikArray := (
                                                  -- Normal
                                                  KartenGrundDatentypen.Flusskreuzung_Vier_Enum       => '╋',
                                                  KartenGrundDatentypen.Fluss_Waagrecht_Enum          => '━',
                                                  KartenGrundDatentypen.Fluss_Senkrecht_Enum          => '┃',
                                                  KartenGrundDatentypen.Flusskurve_Unten_Rechts_Enum   => '┏',
                                                  KartenGrundDatentypen.Flusskurve_Unten_Links_Enum    => '┓',
                                                  KartenGrundDatentypen.Flusskurve_Oben_Rechts_Enum    => '┗',
                                                  KartenGrundDatentypen.Flusskurve_Oben_Links_Enum     => '┛',
                                                  KartenGrundDatentypen.Flusskreuzung_Drei_Oben_Enum   => '┻',
                                                  KartenGrundDatentypen.Flusskreuzung_Drei_Unten_Enum  => '┳',
                                                  KartenGrundDatentypen.Flusskreuzung_Drei_Rechts_Enum => '┣',
                                                  KartenGrundDatentypen.Flusskreuzung_Drei_Links_Enum  => '┫',
                                                  KartenGrundDatentypen.Flussendstück_Links_Enum      => '╺',
                                                  KartenGrundDatentypen.Flussendstück_Rechts_Enum     => '╸',
                                                  KartenGrundDatentypen.Flussendstück_Unten_Enum      => '╹',
                                                  KartenGrundDatentypen.Flussendstück_Oben_Enum       => '╻',
                                                  KartenGrundDatentypen.See_Enum                     => '▪',
                                                  -- Normal
      
      
      
                                                  -- Unterirdisch
                                                  KartenGrundDatentypen.Unterirdische_Flusskreuzung_Vier_Enum       => '╋',
                                                  KartenGrundDatentypen.Unterirdischer_Fluss_Waagrecht_Enum         => '━',
                                                  KartenGrundDatentypen.Unterirdischer_Fluss_Senkrecht_Enum         => '┃',
                                                  KartenGrundDatentypen.Unterirdische_Flusskurve_Unten_Rechts_Enum   => '┏',
                                                  KartenGrundDatentypen.Unterirdische_Flusskurve_Unten_Links_Enum    => '┓',
                                                  KartenGrundDatentypen.Unterirdische_Flusskurve_Oben_Rechts_Enum    => '┗',
                                                  KartenGrundDatentypen.Unterirdische_Flusskurve_Oben_Links_Enum     => '┛',
                                                  KartenGrundDatentypen.Unterirdische_Flusskreuzung_Drei_Oben_Enum   => '┻',
                                                  KartenGrundDatentypen.Unterirdische_Flusskreuzung_Drei_Unten_Enum  => '┳',
                                                  KartenGrundDatentypen.Unterirdische_Flusskreuzung_Drei_Rechts_Enum => '┣',
                                                  KartenGrundDatentypen.Unterirdische_Flusskreuzung_Drei_Links_Enum  => '┫',
                                                  KartenGrundDatentypen.Unterirdisches_Flussendstück_Links_Enum     => '╺',
                                                  KartenGrundDatentypen.Unterirdisches_Flussendstück_Rechts_Enum    => '╸',
                                                  KartenGrundDatentypen.Unterirdisches_Flussendstück_Unten_Enum     => '╹',
                                                  KartenGrundDatentypen.Unterirdisches_Flussendstück_Oben_Enum      => '╻',
                                                  KartenGrundDatentypen.Unterirdischer_See_Enum                    => '▪',
                                                  -- Unterirdisch
      
      
      
                                                  -- Lava
                                                  KartenGrundDatentypen.Lavaflusskreuzung_Vier_Enum       => '╋',
                                                  KartenGrundDatentypen.Lavafluss_Waagrecht_Enum          => '━',
                                                  KartenGrundDatentypen.Lavafluss_Senkrecht_Enum          => '┃',
                                                  KartenGrundDatentypen.Lavaflusskurve_Unten_Rechts_Enum   => '┏',
                                                  KartenGrundDatentypen.Lavaflusskurve_Unten_Links_Enum    => '┓',
                                                  KartenGrundDatentypen.Lavaflusskurve_Oben_Rechts_Enum    => '┗',
                                                  KartenGrundDatentypen.Lavaflusskurve_Oben_Links_Enum     => '┛',
                                                  KartenGrundDatentypen.Lavaflusskreuzung_Drei_Oben_Enum   => '┻',
                                                  KartenGrundDatentypen.Lavaflusskreuzung_Drei_Unten_Enum  => '┳',
                                                  KartenGrundDatentypen.Lavaflusskreuzung_Drei_Rechts_Enum => '┣',
                                                  KartenGrundDatentypen.Lavaflusskreuzung_Drei_Links_Enum  => '┫',
                                                  KartenGrundDatentypen.Lavaflussendstück_Links_Enum      => '╺',
                                                  KartenGrundDatentypen.Lavaflussendstück_Rechts_Enum     => '╸',
                                                  KartenGrundDatentypen.Lavaflussendstück_Unten_Enum      => '╹',
                                                  KartenGrundDatentypen.Lavaflussendstück_Oben_Enum       => '╻',
                                                  KartenGrundDatentypen.Lavasee_Enum                     => '▪'
                                                  -- Lava
                                                 );
   
   

   type KartenressourcenAccessArray is array (KartenDatenbank.KartenRessourcenListeArray'Range) of Wide_Wide_Character;
   KartenressourceAccess : KartenressourcenAccessArray := (
                                                           KartenGrundDatentypen.Kohle_Enum              => '♦',
                                                           KartenGrundDatentypen.Eisen_Enum              => '♦',
                                                           KartenGrundDatentypen.Öl_Enum                 => '♦',
                                                           KartenGrundDatentypen.Fisch_Enum              => '≈',
                                                           KartenGrundDatentypen.Wal_Enum                => '≈',
                                                           KartenGrundDatentypen.Hochwertiger_Boden_Enum => '♦',
                                                           KartenGrundDatentypen.Gold_Enum               => '♦'
                                                          );
   
   
   
   type VerbesserungGrafikArray is array (VerbesserungenDatenbank.VerbesserungListeArray'Range) of Wide_Wide_Character;
   VerbesserungGrafik : VerbesserungGrafikArray := (
                                                    KartenVerbesserungDatentypen.Leer_Verbesserung_Enum => KartenKonstanten.LeerKartenGrafik,
      
      
                                                    
                                                    -- Städte
                                                    KartenVerbesserungDatentypen.Eigene_Hauptstadt_Enum => '♣',
                                                    KartenVerbesserungDatentypen.Eigene_Stadt_Enum      => '♠',
                                                    KartenVerbesserungDatentypen.Fremde_Hauptstadt_Enum => '⌂',
                                                    KartenVerbesserungDatentypen.Fremde_Stadt_Enum      => '¤',
                                                    -- Städte
      
      
                                                  
                                                    -- Gebilde
                                                    KartenVerbesserungDatentypen.Farm_Enum    => 'F',
                                                    KartenVerbesserungDatentypen.Mine_Enum    => 'M',
                                                    KartenVerbesserungDatentypen.Festung_Enum => 'B',
                                                    KartenVerbesserungDatentypen.Sperre_Enum  => 'S',
                                                    -- Gebilde
      
      
                                                  
                                                    -- Wege
                                                    -- Straßen
                                                    KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum       => '╬',
                                                    KartenVerbesserungDatentypen.Straße_Waagrecht_Enum           => '═',
                                                    KartenVerbesserungDatentypen.Straße_Senkrecht_Enum           => '║',
                                                    KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum   => '╔',
                                                    KartenVerbesserungDatentypen.Straßenkurve_Unten_Links_Enum    => '╗',
                                                    KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum    => '╚',
                                                    KartenVerbesserungDatentypen.Straßenkurve_Oben_Links_Enum     => '╝',
                                                    KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum   => '╩',
                                                    KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum  => '╦',
                                                    KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum => '╠',
                                                    KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum  => '╣',
                                                    KartenVerbesserungDatentypen.Straßenendstück_Links_Enum      => '╞',
                                                    KartenVerbesserungDatentypen.Straßenendstück_Rechts_Enum     => '╡',
                                                    KartenVerbesserungDatentypen.Straßenendstück_Unten_Enum      => '╨',
                                                    KartenVerbesserungDatentypen.Straßenendstück_Oben_Enum       => '╥',
                                                    KartenVerbesserungDatentypen.Straße_Einzeln_Enum             => '▫',
                                                    -- Straßen
      
      
      
                                                    -- Schienen
                                                    -- Schienen
      
      
                                                    
                                                    -- Tunnel
                                                    -- Tunnel
                                                    -- Wege
                                                    
                                                    others => KartenKonstanten.LeerKartenGrafik
                                                   );
   
end EingeleseneGrafikenKonsole;
