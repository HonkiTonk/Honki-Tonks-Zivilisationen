pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package KartenGrundDatentypen is

   -- Immer dran denken, alle Flussarten am Schluss hinzufügen.
   type Karten_Grund_Enum is (Leer_Grund,
                              
                              -- Feld
                              Wasser, Küstengewässer, Unterwasser_Wasser, Unterwasser_Küstengewässer,
                              Eis, Unterwasser_Eis,
                              Lava, Planetenkern,
                              Tundra, Wüste, Hügel, Gebirge, Wald, Dschungel, Sumpf, Flachland, Hügel_Mit, Wolken, Weltraum, Erde, Erdgestein, Sand, Gestein,
                              Korallen, Unterwasser_Wald,
                              
                              -- Ressourcen
                              Fisch, Wal,
                              Kohle, Eisen, Öl, Hochwertiger_Boden, Gold,
                              
                              -- Fluss
                              Flusskreuzung_Vier, Fluss_Waagrecht, Fluss_Senkrecht, Flusskurve_Unten_Rechts, Flusskurve_Unten_Links, Flusskurve_Oben_Rechts, Flusskurve_Oben_Links, Flusskreuzung_Drei_Oben,
                              Flusskreuzung_Drei_Unten, Flusskreuzung_Drei_Rechts, Flusskreuzung_Drei_Links, Flussendstück_Links, Flussendstück_Rechts, Flussendstück_Unten, Flussendstück_Oben, See,
                              
                              -- Unterirdischer Fluss
                              Unterirdische_Flusskreuzung_Vier, Unterirdischer_Fluss_Waagrecht, Unterirdischer_Fluss_Senkrecht, Unterirdische_Flusskurve_Unten_Rechts, Unterirdische_Flusskurve_Unten_Links,
                              Unterirdische_Flusskurve_Oben_Rechts, Unterirdische_Flusskurve_Oben_Links, Unterirdische_Flusskreuzung_Drei_Oben, Unterirdische_Flusskreuzung_Drei_Unten,
                              Unterirdische_Flusskreuzung_Drei_Rechts, Unterirdische_Flusskreuzung_Drei_Links, Unterirdisches_Flussendstück_Links, Unterirdisches_Flussendstück_Rechts,
                              Unterirdisches_Flussendstück_Unten, Unterirdisches_Flussendstück_Oben, Unterirdischer_See,
                              
                              -- Lavafluss
                              Lavaflusskreuzung_Vier, Lavafluss_Waagrecht, Lavafluss_Senkrecht, Lavaflusskurve_Unten_Rechts, Lavaflusskurve_Unten_Links, Lavaflusskurve_Oben_Rechts, Lavaflusskurve_Oben_Links,
                              Lavaflusskreuzung_Drei_Oben, Lavaflusskreuzung_Drei_Unten, Lavaflusskreuzung_Drei_Rechts, Lavaflusskreuzung_Drei_Links, Lavaflussendstück_Links, Lavaflussendstück_Rechts,
                              Lavaflussendstück_Unten, Lavaflussendstück_Oben, Lavasee
                             );
   pragma Ordered (Karten_Grund_Enum);
   
   subtype Karten_Grund_Vorhanden_Enum is Karten_Grund_Enum range Wasser .. Karten_Grund_Enum'Last;

   subtype Karten_Grund_Alle_Felder_Enum is Karten_Grund_Vorhanden_Enum range Wasser .. Unterwasser_Wald;
   subtype Karten_Grund_Wasser_Mit_Eis_Enum is Karten_Grund_Alle_Felder_Enum range Wasser .. Unterwasser_Eis;
   subtype Karten_Grund_Wasser_Enum is Karten_Grund_Wasser_Mit_Eis_Enum range Wasser .. Unterwasser_Küstengewässer;
   subtype Karten_Grund_Land_Enum is Karten_Grund_Alle_Felder_Enum range Eis .. Gestein;
   subtype Karten_Grund_Land_Ohne_Eis_Enum is Karten_Grund_Land_Enum range Tundra .. Gestein;
   subtype Karten_Fluss_Enum is Karten_Grund_Vorhanden_Enum range Flusskreuzung_Vier .. Karten_Grund_Vorhanden_Enum'Last;
   subtype Landschaft_Wahrscheinlichkeit_Enum is Karten_Grund_Land_Ohne_Eis_Enum range Tundra .. Sumpf;
   
   -- Flachland muss hier immer am Schluss kommen, sonst geht der Kartengenerator kaputt!
   subtype Karten_Grund_Generator_Enum is Karten_Grund_Land_Ohne_Eis_Enum range Tundra .. Flachland;
   subtype Karten_Unterwasser_Generator_Enum is Karten_Grund_Alle_Felder_Enum range Korallen .. Unterwasser_Wald;
   
   
   
   -- Hier gibt eine Einteilung nur mäßig Sinn denke ich, oder?
   type Karten_Ressourcen_Enum is (Leer_Ressource_Enum,
                                   
                                   -- Wasserressourcen
                                   Fisch_Enum, Wal_Enum,
                                   
                                   -- Landressourcen
                                   Kohle_Enum, Eisen_Enum, Öl_Enum, Hochwertiger_Boden_Enum, Gold_Enum
                                  );
   
   subtype Karten_Grund_Ressourcen_Enum is Karten_Grund_Vorhanden_Enum range Fisch .. Gold;
   subtype Karten_Grund_Ressourcen_Wasser is Karten_Grund_Ressourcen_Enum range Karten_Grund_Ressourcen_Enum'First .. Wal;
   subtype Karten_Grund_Ressourcen_Land is Karten_Grund_Ressourcen_Enum range Kohle .. Karten_Grund_Ressourcen_Enum'Last;
   
   -- type Karten_Fluss_Enum is (Leer_Fluss_Enum,
                              
   -- Fluss
   --                           Flusskreuzung_Vier, Fluss_Waagrecht, Fluss_Senkrecht, Flusskurve_Unten_Rechts, Flusskurve_Unten_Links, Flusskurve_Oben_Rechts, Flusskurve_Oben_Links, Flusskreuzung_Drei_Oben,
   --                           Flusskreuzung_Drei_Unten, Flusskreuzung_Drei_Rechts, Flusskreuzung_Drei_Links, Flussendstück_Links, Flussendstück_Rechts, Flussendstück_Unten, Flussendstück_Oben, See,
                              
   -- Unterirdischer Fluss
   --                           Unterirdische_Flusskreuzung_Vier, Unterirdischer_Fluss_Waagrecht, Unterirdischer_Fluss_Senkrecht, Unterirdische_Flusskurve_Unten_Rechts, Unterirdische_Flusskurve_Unten_Links,
   --                         Unterirdische_Flusskurve_Oben_Rechts, Unterirdische_Flusskurve_Oben_Links, Unterirdische_Flusskreuzung_Drei_Oben, Unterirdische_Flusskreuzung_Drei_Unten,
   --                         Unterirdische_Flusskreuzung_Drei_Rechts, Unterirdische_Flusskreuzung_Drei_Links, Unterirdisches_Flussendstück_Links, Unterirdisches_Flussendstück_Rechts,
   --                          Unterirdisches_Flussendstück_Unten, Unterirdisches_Flussendstück_Oben, Unterirdischer_See,
                              
   -- Lavafluss
   --                        Lavaflusskreuzung_Vier, Lavafluss_Waagrecht, Lavafluss_Senkrecht, Lavaflusskurve_Unten_Rechts, Lavaflusskurve_Unten_Links, Lavaflusskurve_Oben_Rechts, Lavaflusskurve_Oben_Links,
   --                         Lavaflusskreuzung_Drei_Oben, Lavaflusskreuzung_Drei_Unten, Lavaflusskreuzung_Drei_Rechts, Lavaflusskreuzung_Drei_Links, Lavaflussendstück_Links, Lavaflussendstück_Rechts,
   --                         Lavaflussendstück_Unten, Lavaflussendstück_Oben, Lavasee
   --                         );
                              
   subtype Karten_Grund_Fluss_Enum is Karten_Fluss_Enum range Flusskreuzung_Vier .. See;
   subtype Karten_Grund_Unterirdischer_Fluss_Enum is Karten_Fluss_Enum range Unterirdische_Flusskreuzung_Vier .. Unterirdischer_See;
   subtype Karten_Grund_Lavafluss_Enum is Karten_Fluss_Enum range Lavaflusskreuzung_Vier .. Lavasee;

end KartenGrundDatentypen;
